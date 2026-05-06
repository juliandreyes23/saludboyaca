<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><fmt:message key="otp.titulo" /> | Salud Boyacá</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <style>
            body {
                background: linear-gradient(135deg, #1a5276, #2E86C1);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Poppins', sans-serif;
            }

            .otp-container {
                background: rgba(255, 255, 255, 0.12);
                backdrop-filter: blur(16px);
                border: 1px solid rgba(255, 255, 255, 0.25);
                border-radius: 20px;
                padding: 45px 40px;
                max-width: 480px;
                width: 100%;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                color: white;
                text-align: center;
            }

            .otp-header img {
                filter: brightness(0) invert(1);
                margin-bottom: 15px;
            }

            .otp-header h2 {
                font-weight: 600;
                font-size: 1.6rem;
                margin-bottom: 8px;
            }

            .otp-header p {
                font-size: 0.9rem;
                opacity: 0.85;
                margin-bottom: 20px;
            }

            .timer-wrapper {
                margin-bottom: 25px;
            }

            .timer-display {
                font-size: 1.5rem;
                font-weight: 600;
                letter-spacing: 1px;
                margin-bottom: 8px;
                text-shadow: 1px 1px 4px rgba(0,0,0,0.5);
            }

            .timer-display.urgent {
                color: #f1948a;
                animation: pulse 1s infinite;
            }

            @keyframes pulse {
                0%, 100% { opacity: 1; }
                50% { opacity: 0.6; }
            }

            .progress-bar-track {
                background: rgba(255,255,255,0.2);
                border-radius: 99px;
                height: 6px;
                overflow: hidden;
            }

            .progress-bar-fill {
                height: 100%;
                border-radius: 99px;
                background: linear-gradient(90deg, #27ae60, #f1c40f, #e74c3c);
                background-size: 300% 100%;
                transition: width 1s linear;
            }

            .otp-input-group {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin-bottom: 30px;
            }

            .otp-field {
                width: 52px;
                height: 58px;
                text-align: center;
                font-size: 1.5rem;
                font-weight: 600;
                border: 2px solid rgba(255, 255, 255, 0.4);
                border-radius: 12px;
                background: rgba(255, 255, 255, 0.15);
                color: white;
                outline: none;
                transition: all 0.3s ease;
            }

            .otp-field:focus {
                border-color: #ffffff;
                background: rgba(255, 255, 255, 0.25);
                box-shadow: 0 0 12px rgba(255, 255, 255, 0.3);
            }

            .btn-confirm {
                width: 100%;
                padding: 13px;
                border: none;
                border-radius: 12px;
                background: white;
                color: #1a5276;
                font-weight: 600;
                font-size: 1rem;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-confirm:hover:not(:disabled) {
                background: #d6eaf8;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(0,0,0,0.2);
            }

            .footer-links {
                margin-top: 20px;
            }

            .footer-links a {
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
                font-size: 0.9rem;
            }
        </style>
    </head>
    <body>

        <div class="otp-container">
            <div class="otp-header">
                <img src="https://cdn-icons-png.flaticon.com/512/565/565547.png" width="60">
                <h2><fmt:message key="otp.titulo" /></h2>
                <p><fmt:message key="otp.instruccion.general" /></p>
            </div>

            <div class="timer-wrapper">
                <div class="timer-display" id="timerDisplay">⏱ 05:00</div>
                <div class="progress-bar-track">
                    <div class="progress-bar-fill" id="progressBar" style="width:100%;"></div>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/otp" method="POST" id="otp-form">
                <input type="hidden" name="otpCodigo" id="otpCodigo">
                <div class="otp-input-group">
                    <input type="text" class="otp-field" maxlength="1" inputmode="numeric">
                    <input type="text" class="otp-field" maxlength="1" inputmode="numeric">
                    <input type="text" class="otp-field" maxlength="1" inputmode="numeric">
                    <input type="text" class="otp-field" maxlength="1" inputmode="numeric">
                    <input type="text" class="otp-field" maxlength="1" inputmode="numeric">
                    <input type="text" class="otp-field" maxlength="1" inputmode="numeric">
                </div>

                <button type="submit" class="btn-confirm" id="btnConfirm">
                    <fmt:message key="otp.boton.validar" />
                </button>
            </form>

            <div class="footer-links">
                <a href="${pageContext.request.contextPath}/login">
                    <fmt:message key="otp.volver.login" />
                </a>
            </div>
        </div>

        <script>
            const translations = {
                expiredTitle: '<fmt:message key="otp.expirado.titulo" />',
                expiredText: '<fmt:message key="otp.expirado.texto" />',
                errorTitle: '<fmt:message key="otp.error.titulo" />',
                errorText: '<fmt:message key="otp.error.texto" />',
                incompleteTitle: '<fmt:message key="otp.alerta.incompleto.titulo" />',
                incompleteText: '<fmt:message key="otp.alerta.incompleto.texto" />',
                btnRedirect: '<fmt:message key="nav.salir" />'
            };

            const fields = document.querySelectorAll('.otp-field');
            const form = document.getElementById('otp-form');
            const hiddenInput = document.getElementById('otpCodigo');
            const timerDisplay = document.getElementById('timerDisplay');
            const progressBar = document.getElementById('progressBar');

            let secondsLeft = 300;
            const countdown = setInterval(() => {
                secondsLeft--;
                const m = Math.floor(secondsLeft / 60);
                const s = secondsLeft % 60;
                timerDisplay.textContent = `⏱ \${m < 10 ? '0' : ''}\${m}:\${s < 10 ? '0' : ''}\${s}`;
                progressBar.style.width = `\${(secondsLeft / 300) * 100}%`;

                if (secondsLeft <= 60) timerDisplay.classList.add('urgent');
                if (secondsLeft <= 0) {
                    clearInterval(countdown);
                    Swal.fire({
                        icon: 'warning',
                        title: translations.expiredTitle,
                        text: translations.expiredText,
                        confirmButtonText: translations.btnRedirect,
                        allowOutsideClick: false
                    }).then(() => window.location.href = '${pageContext.request.contextPath}/login');
                }
            }, 1000);

            fields.forEach((field, index) => {
                field.addEventListener('input', () => {
                    field.value = field.value.replace(/\D/g, '');
                    if (field.value && index < fields.length - 1) fields[index + 1].focus();
                });
                field.addEventListener('keydown', (e) => {
                    if (e.key === 'Backspace' && !field.value && index > 0) fields[index - 1].focus();
                });
            });

            form.addEventListener('submit', (e) => {
                const code = Array.from(fields).map(f => f.value).join('');
                if (code.length < 6) {
                    e.preventDefault();
                    Swal.fire({
                        icon: 'warning',
                        title: translations.incompleteTitle,
                        text: translations.incompleteText
                    });
                } else {
                    hiddenInput.value = code;
                }
            });

            <c:if test="${not empty error}">
                Swal.fire({
                    icon: 'error',
                    title: translations.errorTitle,
                    text: translations.errorText,
                    confirmButtonText: translations.btnRedirect,
                    allowOutsideClick: false
                }).then(() => window.location.href = '${pageContext.request.contextPath}/login');
            </c:if>
        </script>
    </body>
</html>