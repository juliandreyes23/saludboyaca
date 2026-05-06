<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'es'}"/>
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>
            <c:choose>
                <c:when test="${paciente.id > 0}"><fmt:message key="paciente.editarPaciente="/></c:when>
                <c:otherwise><fmt:message key="pacientes.registro"/></c:otherwise>
            </c:choose>
            <fmt:message key="app.logo"/>
        </title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&family=Sora:wght@600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
        <style>
            :root {
                --navy:    #0f2744;
                --blue:    #1d5fa8;
                --sky:     #e8f2fd;
                --teal:    #0d9488;
                --teal-light: #e6f7f5;
                --border:  #e4eaf2;
                --text:    #1e293b;
                --muted:   #64748b;
                --danger:  #dc2626;
                --radius:  14px;
            }

            *, *::before, *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                background: #ffffff;
                font-family: 'Plus Jakarta Sans', sans-serif;
                color: var(--text);
                min-height: 100vh;
                padding: 2.5rem 1.5rem;
            }

            .page-wrapper {
                max-width: 760px;
                margin: 0 auto;
                animation: fadeUp 0.4s ease both;
            }

            @keyframes fadeUp {
                from {
                    opacity: 0;
                    transform: translateY(16px);
                }
                to   {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .page-header {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin-bottom: 2rem;
            }

            .header-icon {
                width: 52px;
                height: 52px;
                background: linear-gradient(135deg, var(--navy), var(--blue));
                border-radius: 16px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #fff;
                font-size: 1.4rem;
                flex-shrink: 0;
                box-shadow: 0 6px 16px rgba(29,95,168,0.25);
            }

            .header-text h1 {
                font-family: 'Sora', sans-serif;
                font-size: 1.45rem;
                font-weight: 700;
                color: var(--navy);
                letter-spacing: -0.02em;
                line-height: 1.2;
            }

            .header-text p {
                font-size: 13px;
                color: var(--muted);
                margin-top: 3px;
            }

            .alert-error {
                background: #fef2f2;
                border: 1px solid #fee2e2;
                border-radius: var(--radius);
                padding: 14px 16px;
                font-size: 13.5px;
                color: var(--danger);
                margin-bottom: 1.5rem;
                display: flex;
                align-items: flex-start;
                gap: 10px;
            }

            .form-card {
                border: 1.5px solid var(--border);
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 4px 24px rgba(15,39,68,0.07);
            }

            .form-section {
                padding: 1.75rem 2rem;
                border-bottom: 1px solid var(--border);
            }

            .form-section:last-of-type {
                border-bottom: none;
            }

            .section-title {
                font-size: 11px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.09em;
                color: var(--muted);
                margin-bottom: 1.25rem;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .section-title::after {
                content: '';
                flex: 1;
                height: 1px;
                background: var(--border);
            }

            .grid-2 {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }
            .grid-1 {
                display: grid;
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            @media (max-width: 560px) {
                .grid-2 {
                    grid-template-columns: 1fr;
                }
            }

            .field-label {
                display: block;
                font-size: 12px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                color: var(--navy);
                margin-bottom: 7px;
            }

            .required-mark {
                color: var(--danger);
                margin-left: 2px;
            }

            .field-input,
            .field-select {
                width: 100%;
                background: #f8fafc;
                border: 2px solid var(--border);
                border-radius: 12px;
                padding: 12px 16px;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-size: 14.5px;
                color: var(--text);
                transition: all 0.2s;
                outline: none;
                appearance: none;
            }

            .field-input:focus,
            .field-select:focus {
                background: #fff;
                border-color: var(--blue);
                box-shadow: 0 0 0 4px rgba(29,95,168,0.1);
            }

            .field-input::placeholder {
                color: #b0bec5;
            }

            .select-wrapper {
                position: relative;
            }

            .select-wrapper::after {
                content: '\F282';
                font-family: 'Bootstrap-Icons';
                position: absolute;
                right: 14px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--muted);
                pointer-events: none;
                font-size: 14px;
            }

            .field-select {
                padding-right: 40px;
                cursor: pointer;
            }

            .form-actions {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 1.5rem 2rem;
                background: #f8fafc;
                border-top: 1px solid var(--border);
            }

            .btn-confirm {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 12px 28px;
                background: linear-gradient(135deg, var(--navy), var(--blue));
                color: #fff;
                border: none;
                border-radius: 12px;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-size: 14px;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.2s;
                box-shadow: 0 4px 14px rgba(29,95,168,0.3);
            }

            .btn-confirm:hover {
                filter: brightness(1.1);
                transform: translateY(-1px);
            }

            .btn-cancel {
                display: inline-flex;
                align-items: center;
                gap: 7px;
                padding: 12px 20px;
                background: transparent;
                border: 1.5px solid var(--border);
                border-radius: 12px;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-size: 14px;
                font-weight: 600;
                color: var(--muted);
                text-decoration: none;
                transition: all 0.2s;
            }

            .btn-cancel:hover {
                background: var(--sky);
                border-color: var(--blue);
                color: var(--blue);
            }
        </style>
    </head>
    <body>

        <div class="page-wrapper">

            <div class="page-header">
                <div class="header-icon">
                    <i class="bi bi-${paciente.id > 0 ? 'person-gear' : 'person-plus-fill'}"></i>
                </div>
                <div class="header-text">
                    <h1>
                        <c:choose>
                            <c:when test="${paciente.id > 0}"><fmt:message key="paciente.editarPaciente"/></c:when>
                            <c:otherwise><fmt:message key="pacientes.registro"/></c:otherwise>
                        </c:choose>
                    </h1>
                    <p><fmt:message key="app.logo"/> &mdash; <fmt:message key="cita.panelMedico"/></p>
                </div>
            </div>

            <c:if test="${not empty mensajeError}">
                <div class="alert-error">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    ${mensajeError}
                </div>
            </c:if>

            <div class="form-card">
                <form action="${pageContext.request.contextPath}/pacientes" method="POST">

                    <c:choose>
                        <c:when test="${paciente.id > 0}">
                            <input type="hidden" name="id" value="${paciente.id}">
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="id" value="">
                        </c:otherwise>
                    </c:choose>

                    <div class="form-section">
                        <div class="section-title"><i class="bi bi-person-vcard"></i> <fmt:message key="cita.identificacion"/></div>
                        <div class="grid-2">
                            <div>
                                <label class="field-label">
                                    <fmt:message key="paciente.documento"/> <span class="required-mark">*</span>
                                </label>
                                <input type="text" name="documento" class="field-input"
                                       value="${paciente.documento}"
                                       placeholder="Número de documento" required>
                            </div>
                            <div>
                                <label class="field-label">
                                    <fmt:message key="paciente.eps"/> <span class="required-mark">*</span>
                                </label>
                                <div class="select-wrapper">
                                    <select name="eps" class="field-select" required>
                                        <option value=""><fmt:message key="paciente.seleccioneEPS"/></option>
                                        <c:forEach var="eps" items="${listaEps}">
                                            <option value="${eps}" ${paciente.eps == eps ? 'selected' : ''}>
                                                ${eps}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <div class="section-title"><i class="bi bi-person-lines-fill"></i> <fmt:message key="paciente.datosPersonales"/></div>
                        <div class="grid-2">
                            <div>
                                <label class="field-label">
                                    <fmt:message key="paciente.nombres"/> <span class="required-mark">*</span>
                                </label>
                                <input type="text" name="nombres" class="field-input"
                                       value="${paciente.nombres}"
                                       placeholder="Nombres completos" required>
                            </div>
                            <div>
                                <label class="field-label">
                                    <fmt:message key="paciente.apellidos"/> <span class="required-mark">*</span>
                                </label>
                                <input type="text" name="apellidos" class="field-input"
                                       value="${paciente.apellidos}"
                                       placeholder="Apellidos completos" required>
                            </div>
                            <div>
                                <label class="field-label">
                                    <fmt:message key="paciente.nacimiento"/> <span class="required-mark">*</span>
                                </label>
                                <input type="date" name="fecha_nacimiento" class="field-input"
                                       value="${not empty paciente.fechaNacimiento ? paciente.fechaNacimiento : ''}"
                                       required>
                            </div>
                            <div>
                                <label class="field-label"><fmt:message key="paciente.telefono"/></label>
                                <input type="tel" name="telefono" class="field-input"
                                       value="${paciente.telefono}"
                                       placeholder="Ej: 3100000000">
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <div class="section-title"><i class="bi bi-geo-alt"></i> <fmt:message key="paciente.contactoUbicacion"/></div>
                        <div class="grid-2">
                            <div>
                                <label class="field-label"><fmt:message key="pacientes.correo"/> </label>
                                <input type="email" name="email" class="field-input"
                                       value="${paciente.email}"
                                       placeholder="correo@ejemplo.com">
                            </div>
                            <div>
                                <label class="field-label"><fmt:message key="pacientes.veredaBarrio"/></label>
                                <input type="text" name="vereda_barrio" class="field-input"
                                       value="${paciente.veredaBarrio}"
                                       placeholder="Vereda o barrio de residencia">
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-confirm">
                            <i class="bi bi-check-circle"></i>
                            <c:choose>
                                <c:when test="${paciente.id > 0}"><fmt:message key="cita.form.guardar.cambios"/></c:when>
                                <c:otherwise><fmt:message key="paciente.registrarPaciente"/></c:otherwise>
                            </c:choose>
                        </button>
                        <a href="${pageContext.request.contextPath}/pacientes" class="btn-cancel">
                            <i class="bi bi-x"></i> <fmt:message key="paciente.cancelar"/>
                        </a>
                    </div>

                </form>
            </div>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.querySelector('form').addEventListener('submit', function (e) {
                e.preventDefault();
                const form = this;
                const esEdicion = '${paciente.id > 0}' === 'true';

                Swal.fire({
                    title: esEdicion
                            ? '<fmt:message key="paciente.alert.guardar.titulo"/>'
                            : '<fmt:message key="paciente.alert.registrar.titulo"/>',
                    text: esEdicion
                            ? '<fmt:message key="paciente.alert.guardar.texto"/>'
                            : '<fmt:message key="paciente.alert.registrar.texto"/>',
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#0f2744',
                    cancelButtonColor: '#64748b',
                    confirmButtonText: '<fmt:message key="paciente.alert.guardar.confirmar"/>',
                    cancelButtonText: '<fmt:message key="paciente.alert.guardar.cancelar"/>',
                    reverseButtons: true
                }).then((result) => {
                    if (result.isConfirmed) {
                        form.submit();
                    }
                });
            });
        </script>
    </body>
</html>
