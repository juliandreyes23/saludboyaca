<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${not empty sessionScope.lang ? sessionScope.lang : 'es'}">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><fmt:message key='app.nombre'/></title>
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500&family=Sora:wght@600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

        <style>
            :root {
                --primary-blue: #1a3a5c;
                --medical-blue: #2E86C1;
                --emerald: #17a589;
                --soft-white: rgba(255, 255, 255, 0.92);
            }

            *, *::before, *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                min-height: 100vh;
                background: linear-gradient(135deg, #f0f4f8 0%, #d9e2ec 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'DM Sans', sans-serif;
                padding: 2rem;
                position: relative;
                overflow: hidden;
            }

            .bg-blob {
                position: fixed;
                border-radius: 50%;
                filter: blur(80px);
                z-index: -1;
                opacity: 0.4;
            }
            .blob-1 {
                width: 500px;
                height: 500px;
                background: var(--medical-blue);
                top: -150px;
                left: -150px;
            }
            .blob-2 {
                width: 400px;
                height: 400px;
                background: var(--emerald);
                bottom: -100px;
                right: -100px;
            }

            .login-card {
                position: relative;
                width: 100%;
                max-width: 420px;
                background: var(--soft-white);
                border: 1px solid rgba(255,255,255,0.6);
                border-radius: 28px;
                padding: 3rem 2.5rem;
                backdrop-filter: blur(15px);
                box-shadow: 0 25px 50px -12px rgba(26, 58, 92, 0.15);
            }

            .lang-wrapper {
                position: absolute;
                top: 25px;
                right: 25px;
            }

            .lang-select {
                background: rgba(26, 58, 92, 0.05);
                border: 1px solid rgba(26, 58, 92, 0.1);
                color: var(--primary-blue);
                font-family: 'DM Sans', sans-serif;
                font-size: 12px;
                font-weight: 500;
                padding: 6px 12px;
                border-radius: 12px;
                cursor: pointer;
                outline: none;
            }

            .brand-header {
                text-align: center;
                margin-bottom: 2.5rem;
            }
            .brand-icon {
                width: 60px;
                height: 60px;
                background: linear-gradient(135deg, var(--primary-blue), var(--medical-blue));
                color: white;
                border-radius: 18px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2rem;
                margin: 0 auto 1rem;
                box-shadow: 0 10px 20px rgba(46, 134, 193, 0.2);
            }

            .login-title {
                font-family: 'Sora', sans-serif;
                font-weight: 700;
                font-size: 1.8rem;
                color: var(--primary-blue);
            }
            .login-subtitle {
                font-size: 14px;
                color: #64748b;
                margin-top: 4px;
            }

            .alert-error {
                background: #fef2f2;
                border: 1px solid #fee2e2;
                border-radius: 14px;
                padding: 14px;
                font-size: 13px;
                color: #b91c1c;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .field-group {
                margin-bottom: 1.5rem;
            }
            .field-label {
                display: block;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                color: var(--primary-blue);
                margin-bottom: 8px;
            }
            .field-input {
                width: 100%;
                background: #f8fafc;
                border: 2px solid #e2e8f0;
                border-radius: 14px;
                padding: 14px 18px;
                font-family: 'DM Sans', sans-serif;
                font-size: 15px;
                transition: all 0.2s;
            }
            .field-input:focus {
                border-color: var(--medical-blue);
                outline: none;
                background: #fff;
            }

            .password-wrapper {
                position: relative;
            }
            .toggle-password {
                position: absolute;
                top: 50%;
                right: 14px;
                transform: translateY(-50%);
                background: none;
                border: none;
                cursor: pointer;
                color: #94a3b8;
                font-size: 18px;
            }

            .btn-login {
                width: 100%;
                background: linear-gradient(135deg, var(--primary-blue), var(--medical-blue));
                border: none;
                border-radius: 16px;
                padding: 16px;
                color: #fff;
                font-weight: 600;
                cursor: pointer;
                margin-top: 1rem;
                transition: 0.3s;
            }
            .btn-login:hover {
                transform: translateY(-2px);
                filter: brightness(1.1);
            }

            .btn-back {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                margin-top: 1rem;
                padding: 10px 22px;
                border-radius: 50px;
                border: 1.5px solid rgba(26, 58, 92, 0.18);
                background: rgba(26, 58, 92, 0.04);
                color: var(--primary-blue);
                font-family: 'DM Sans', sans-serif;
                font-size: 14px;
                font-weight: 500;
                text-decoration: none;
                transition: background 0.22s, border-color 0.22s, transform 0.18s, color 0.22s;
            }
            .btn-back i {
                font-size: 17px;
                transition: transform 0.22s;
            }
            .btn-back:hover {
                background: rgba(26, 58, 92, 0.09);
                border-color: var(--medical-blue);
                color: var(--medical-blue);
                transform: translateY(-1px);
            }
            .btn-back:hover i {
                transform: translateX(-3px);
            }
            .btn-back:active {
                transform: translateY(0);
            }

            .card-footer {
                text-align: center;
                margin-top: 2.5rem;
                font-size: 13px;
                color: #94a3b8;
            }
        </style>
    </head>
    <body>

        <div class="bg-blob blob-1"></div>
        <div class="bg-blob blob-2"></div>

        <div class="login-card">
            <div class="lang-wrapper">
                <select name="lang" onchange="cambiarIdioma(this.value)" class="lang-select">
                    <option value="es" ${sessionScope.lang == 'es' ? 'selected' : ''}>
                        <fmt:message key='app.lang.es'/>
                    </option>
                    <option value="en" ${sessionScope.lang == 'en' ? 'selected' : ''}>
                        <fmt:message key='app.lang.en'/>
                    </option>
                    <option value="it" ${sessionScope.lang == 'it' ? 'selected' : ''}>
                        <fmt:message key='app.lang.it'/>
                    </option>
                </select>
            </div>

            <div class="brand-header">
                <div class="brand-icon"><i class="bi bi-shield-plus"></i></div>
                <h1 class="login-title"><fmt:message key='login.titulo'/></h1>
                <p class="login-subtitle"><fmt:message key='app.institucion'/></p>
            </div>

            <c:if test="${param.error == 'auth'}">
                <div class="alert-error">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    <fmt:message key='login.error.credenciales'/>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="field-group">
                    <label class="field-label"><fmt:message key='login.usuario'/></label>
                    <input type="text" name="username" class="field-input" placeholder="usuario@institución" required autofocus>
                </div>

                <div class="field-group">
                    <label class="field-label"><fmt:message key='login.contrasena'/></label>
                    <div class="password-wrapper">
                        <input type="password" name="password" id="passwordInput" class="field-input" placeholder="••••••••" required>
                        <button type="button" class="toggle-password" id="togglePassword" onclick="togglePasswordVisibility()">
                            <i class="bi bi-eye" id="eyeIcon"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-login">
                    <fmt:message key='login.ingresar'/>
                </button>

                <div style="text-align: center;">
                    <a href="${pageContext.request.contextPath}/" class="btn-back">
                        <i class="bi bi-arrow-left-short"></i>
                        <fmt:message key='login.volver'/>
                    </a>
                </div>
            </form>

            <p class="card-footer"><fmt:message key='app.footer'/></p>
        </div>

        <script>
            function togglePasswordVisibility() {
                const input = document.getElementById('passwordInput');
                const icon = document.getElementById('eyeIcon');
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.classList.replace('bi-eye', 'bi-eye-slash');
                } else {
                    input.type = 'password';
                    icon.classList.replace('bi-eye-slash', 'bi-eye');
                }
            }

            function cambiarIdioma(lang) {
                const url = new URL(window.location.href);
                url.searchParams.set("lang", lang);
                window.location.href = url.toString();
            }
        </script>
    </body>
</html>
