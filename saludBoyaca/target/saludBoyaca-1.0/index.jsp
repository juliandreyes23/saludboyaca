<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="co.sena.cimm.adso.saludboyaca.util.CaptchaGenerator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="messages"/>

<%
    CaptchaGenerator captchaGen = new CaptchaGenerator();
    String captchaText = captchaGen.generarTexto(6);
    String captchaImage = captchaGen.crearImagenBase64(captchaText);
    session.setAttribute("captcha_key", captchaText);

    String captchaError = (String) session.getAttribute("captcha_error");
    if (captchaError != null) {
        session.removeAttribute("captcha_error");
    }
%>
<!DOCTYPE html>
<html lang="${not empty sessionScope.lang ? sessionScope.lang : 'es'}">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><fmt:message key="index.titulo"/></title>

        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500&family=Sora:wght@600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

        <style>
            :root {
                --primary-blue:  #1a3a5c;
                --medical-blue:  #2E86C1;
                --emerald:       #17a589;
                --soft-white:    rgba(255, 255, 255, 0.92);
            }

            *, *::before, *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                min-height: 100vh;
                font-family: 'DM Sans', sans-serif;
                background: linear-gradient(135deg, #0f2027 0%, #203a43 50%, #2c5364 100%);
                background-attachment: fixed;
                display: flex;
                flex-direction: column;
            }

            .glass-navbar {
                background: rgba(0, 0, 0, 0.25);
                backdrop-filter: blur(12px);
                -webkit-backdrop-filter: blur(12px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }

            .navbar-brand {
                font-family: 'Sora', sans-serif;
                font-weight: 700;
                color: #7ecfee !important;
                letter-spacing: 0.5px;
            }

            .btn-admin {
                background: transparent;
                border: 1.5px solid rgba(255, 255, 255, 0.45);
                color: #fff;
                border-radius: 50px;
                padding: 8px 22px;
                font-size: 14px;
                font-weight: 500;
                transition: 0.25s;
            }
            .btn-admin:hover {
                background: rgba(255, 255, 255, 0.12);
                color: #fff;
                border-color: rgba(255, 255, 255, 0.7);
            }

            .lang-select {
                background: rgba(255, 255, 255, 0.08);
                border: 1px solid rgba(255, 255, 255, 0.25);
                color: #fff;
                font-family: 'DM Sans', sans-serif;
                font-size: 13px;
                font-weight: 500;
                padding: 6px 14px;
                border-radius: 50px;
                cursor: pointer;
                outline: none;
                transition: background 0.2s, border-color 0.2s;
                appearance: none;
                -webkit-appearance: none;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6' fill='none'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%23fff' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 12px center;
                padding-right: 30px;
            }
            .lang-select:hover {
                background-color: rgba(255, 255, 255, 0.15);
                border-color: rgba(255, 255, 255, 0.5);
            }
            .lang-select option {
                background: #1a3a5c;
                color: #fff;
            }

            .hero-section {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 5rem 1.5rem 3rem;
            }

            .hero-title {
                font-family: 'Sora', sans-serif;
                font-size: clamp(1.8rem, 4vw, 3rem);
                font-weight: 700;
                color: #fff;
                margin-bottom: 0.75rem;
            }

            .hero-subtitle {
                font-size: 1rem;
                color: rgba(255, 255, 255, 0.7);
                margin-bottom: 2.5rem;
            }

            .search-container {
                background: rgba(255, 255, 255, 0.12);
                backdrop-filter: blur(16px);
                -webkit-backdrop-filter: blur(16px);
                border: 1px solid rgba(255, 255, 255, 0.22);
                border-radius: 60px;
                padding: 8px 8px 8px 24px;
                display: flex;
                align-items: center;
                gap: 12px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.18);
                transition: border-color 0.25s;
            }
            .search-container:focus-within {
                border-color: rgba(126, 207, 238, 0.5);
            }

            .search-icon {
                color: rgba(255, 255, 255, 0.7);
                font-size: 1.2rem;
                flex-shrink: 0;
            }

            .search-input {
                flex: 1;
                background: transparent;
                border: none;
                outline: none;
                color: #fff;
                font-size: 1rem;
                font-family: 'DM Sans', sans-serif;
            }
            .search-input::placeholder {
                color: rgba(255, 255, 255, 0.55);
            }

            .btn-buscar {
                background: linear-gradient(135deg, var(--primary-blue), var(--medical-blue));
                border: none;
                border-radius: 50px;
                padding: 12px 32px;
                color: #fff;
                font-weight: 500;
                font-size: 15px;
                letter-spacing: 0.5px;
                cursor: pointer;
                transition: 0.25s;
                flex-shrink: 0;
            }
            .btn-buscar:hover {
                filter: brightness(1.15);
                transform: translateY(-1px);
            }

            .modal-content.dark-modal {
                background: rgba(15, 24, 40, 0.97);
                backdrop-filter: blur(20px);
                -webkit-backdrop-filter: blur(20px);
                border: 1px solid rgba(46, 134, 193, 0.3);
                border-radius: 24px;
                color: #fff;
            }

            .modal-header.dark-modal-header {
                border-bottom: 1px solid rgba(255, 255, 255, 0.08);
                padding: 1.5rem 1.75rem 1rem;
            }

            .modal-title-text {
                font-family: 'Sora', sans-serif;
                font-size: 1.05rem;
                font-weight: 600;
                color: #7ecfee;
            }

            .btn-close-white {
                filter: invert(1) brightness(2);
            }

            .modal-body.dark-modal-body {
                padding: 1.5rem 1.75rem 2rem;
            }

            .doc-badge {
                display: inline-block;
                background: rgba(46, 134, 193, 0.2);
                border: 1px solid rgba(46, 134, 193, 0.35);
                border-radius: 8px;
                padding: 3px 12px;
                color: #7ecfee;
                font-weight: 500;
                font-size: 0.95rem;
            }

            .captcha-wrap {
                background: #fff;
                border-radius: 12px;
                padding: 10px 14px;
                display: inline-flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 1rem;
                box-shadow: 0 2px 8px rgba(0,0,0,0.12);
            }

            .captcha-wrap img {
                border-radius: 6px;
                display: block;
            }

            .btn-refresh {
                background: none;
                border: none;
                color: var(--medical-blue);
                font-size: 1.1rem;
                cursor: pointer;
                padding: 4px;
                border-radius: 6px;
                transition: color 0.2s, transform 0.2s;
            }
            .btn-refresh:hover {
                color: var(--emerald);
                transform: rotate(90deg);
            }

            .captcha-input {
                width: 100%;
                background: #f8fafc;
                border: 2px solid #e2e8f0;
                border-radius: 14px;
                padding: 13px 18px;
                font-family: 'DM Sans', sans-serif;
                font-size: 1.1rem;
                font-weight: 500;
                text-align: center;
                color: #1a3a5c;
                letter-spacing: 4px;
                transition: border-color 0.2s;
                margin-bottom: 1rem;
            }
            .captcha-input:focus {
                outline: none;
                border-color: var(--medical-blue);
                background: #fff;
            }

            .btn-validar {
                width: 100%;
                background: linear-gradient(135deg, var(--primary-blue), var(--medical-blue));
                border: none;
                border-radius: 16px;
                padding: 15px;
                color: #fff;
                font-family: 'DM Sans', sans-serif;
                font-weight: 500;
                font-size: 1rem;
                cursor: pointer;
                transition: 0.25s;
                letter-spacing: 0.5px;
            }
            .btn-validar:hover {
                filter: brightness(1.12);
                transform: translateY(-1px);
            }

            /* ── Background blobs ── */
            .bg-blob {
                position: fixed;
                border-radius: 50%;
                filter: blur(90px);
                z-index: -1;
                opacity: 0.25;
                pointer-events: none;
            }
            .blob-1 {
                width: 520px;
                height: 520px;
                background: var(--medical-blue);
                top: -160px;
                left: -160px;
            }
            .blob-2 {
                width: 420px;
                height: 420px;
                background: var(--emerald);
                bottom: -120px;
                right: -120px;
            }
        </style>
    </head>
    <body>

        <div class="bg-blob blob-1"></div>
        <div class="bg-blob blob-2"></div>

        <nav class="navbar navbar-expand-lg navbar-dark fixed-top glass-navbar">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <i class="bi bi-shield-plus me-2"></i><fmt:message key="index.nav.brand"/>
                </a>
                <div class="ms-auto d-flex align-items-center gap-3">
                    <select class="lang-select" onchange="cambiarIdioma(this.value)">
                        <option value="es" ${sessionScope.lang == 'es' || empty sessionScope.lang ? 'selected' : ''}>
                            <fmt:message key="app.lang.es"/>
                        </option>
                        <option value="en" ${sessionScope.lang == 'en' ? 'selected' : ''}>
                            <fmt:message key="app.lang.en"/>
                        </option>
                        <option value="it" ${sessionScope.lang == 'it' ? 'selected' : ''}>
                            <fmt:message key="app.lang.it"/>
                        </option>
                    </select>
                    <a href="views/login.jsp" class="btn-admin"><fmt:message key="index.nav.admin"/></a>
                </div>
            </div>
        </nav>

        <main class="hero-section">
            <div class="container text-center">
                <h1 class="hero-title"><fmt:message key="index.hero.titulo"/></h1>
                <p class="hero-subtitle"><fmt:message key="index.hero.subtitulo"/></p>

                <div class="row justify-content-center">
                    <div class="col-lg-7 col-md-9">
                        <div class="search-container">
                            <i class="bi bi-person-vcard search-icon"></i>
                            <input type="text" id="docInput"
                                   class="search-input"
                                   placeholder="<fmt:message key='index.search.placeholder'/>"
                                   onkeydown="if (event.key === 'Enter')
                                               abrirVerificacion()">
                            <button class="btn-buscar" onclick="abrirVerificacion()">
                                <i class="bi bi-search me-1"></i> <fmt:message key="index.search.boton"/>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <div class="modal fade" id="captchaModal" tabindex="-1" aria-labelledby="captchaModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content dark-modal">

                    <div class="modal-header dark-modal-header">
                        <h5 class="modal-title-text" id="captchaModalLabel">
                            <i class="bi bi-shield-lock me-2"></i><fmt:message key="index.captcha.titulo"/>
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>

                    <div class="modal-body dark-modal-body text-center">

                        <p class="mb-3" style="color: rgba(255,255,255,0.75); font-size: 14px;">
                            <fmt:message key="index.captcha.instruccion"/>
                            <span id="displayDoc" class="doc-badge ms-1"></span>
                        </p>

                        <form action="${pageContext.request.contextPath}/consulta-cita" method="POST" id="captchaForm">
                            <input type="hidden" name="documento" id="hiddenDoc">

                            <div class="captcha-wrap">
                                <img src="<%= captchaImage%>" alt="Captcha" width="150" height="50" id="captchaImg">
                                <button type="button" class="btn-refresh"
                                        title="<fmt:message key='index.captcha.recargar'/>"
                                        onclick="location.reload()">
                                    <i class="bi bi-arrow-clockwise"></i>
                                </button>
                            </div>

                            <input type="text"
                                   name="captcha"
                                   id="captchaInput"
                                   class="captcha-input"
                                   placeholder="<fmt:message key='index.captcha.placeholder'/>"
                                   autocomplete="off"
                                   required>

                            <button type="submit" class="btn-validar">
                                <i class="bi bi-check2-circle me-1"></i> <fmt:message key="index.captcha.boton"/>
                            </button>
                        </form>

                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
                                            const i18n = {
                                                vacioTitulo: '<fmt:message key="index.alerta.vacio.titulo"/>',
                                                vacioTexto: '<fmt:message key="index.alerta.vacio.texto"/>',
                                                vacioBoton: '<fmt:message key="index.alerta.vacio.boton"/>',
                                                captchaErrTitulo: '<fmt:message key="index.captcha.error.titulo"/>',
                                                captchaErrTexto: '<fmt:message key="index.captcha.error.texto"/>',
                                                captchaErrBoton: '<fmt:message key="index.captcha.error.boton"/>'
                                            };

                                            function abrirVerificacion() {
                                                const doc = document.getElementById('docInput').value.trim();
                                                if (!doc) {
                                                    Swal.fire({
                                                        icon: 'warning',
                                                        title: i18n.vacioTitulo,
                                                        text: i18n.vacioTexto,
                                                        confirmButtonColor: '#2E86C1',
                                                        confirmButtonText: i18n.vacioBoton,
                                                        background: '#0f1828',
                                                        color: '#ffffff',
                                                        iconColor: '#f59e0b'
                                                    });
                                                    return;
                                                }
                                                document.getElementById('hiddenDoc').value = doc;
                                                document.getElementById('displayDoc').innerText = doc;
                                                document.getElementById('captchaInput').value = '';
                                                new bootstrap.Modal(document.getElementById('captchaModal')).show();
                                            }

                                            function cambiarIdioma(lang) {
                                                const url = new URL(window.location.href);
                                                url.searchParams.set("lang", lang);
                                                window.location.href = url.toString();
                                            }

            <% if ("captcha".equals(captchaError)) { %>
                                            window.addEventListener('DOMContentLoaded', function () {
                                                Swal.fire({
                                                    icon: 'error',
                                                    title: i18n.captchaErrTitulo,
                                                    text: i18n.captchaErrTexto,
                                                    confirmButtonColor: '#2E86C1',
                                                    confirmButtonText: i18n.captchaErrBoton,
                                                    background: '#0f1828',
                                                    color: '#ffffff',
                                                    iconColor: '#ef4444',
                                                    showClass: {popup: 'animate__animated animate__shakeX'}
                                                });
                                            });
            <% }%>

                                            const urlParams = new URLSearchParams(window.location.search);
                                            if (urlParams.get('error') === 'captcha') {
                                                Swal.fire({
                                                    icon: 'error',
                                                    title: i18n.captchaErrTitulo,
                                                    text: i18n.captchaErrTexto,
                                                    confirmButtonColor: '#2E86C1',
                                                    confirmButtonText: i18n.captchaErrBoton,
                                                    background: '#0f1828',
                                                    color: '#ffffff',
                                                    iconColor: '#ef4444'
                                                });
                                                history.replaceState(null, '', window.location.pathname);
                                            }
        </script>

    </body>
</html>
