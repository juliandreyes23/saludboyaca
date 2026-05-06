<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title><fmt:message key="cita.titulo"/> - <fmt:message key="app.logo"/></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&family=Sora:wght@600;700&display=swap" rel="stylesheet">

        <style>
            :root {
                --navy:       #0f2744;
                --blue:       #1d5fa8;
                --sky:        #e8f2fd;
                --teal:       #0d9488;
                --teal-light: #e6f7f5;
                --border:     #e4eaf2;
                --text:       #1e293b;
                --muted:      #64748b;
                --radius:     14px;
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
                max-width: 720px;
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
                box-shadow: 0 6px 16px rgba(29, 95, 168, 0.25);
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

            .form-card {
                border: 1.5px solid var(--border);
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 4px 24px rgba(15, 39, 68, 0.07);
            }

            .form-section {
                padding: 1.75rem 2rem;
                border-bottom: 1px solid var(--border);
            }

            .form-section:last-child {
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

            .field-label {
                display: block;
                font-size: 12px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                color: var(--navy);
                margin-bottom: 7px;
            }

            .field-label.teal {
                color: var(--teal);
            }

            .field-input,
            .field-select,
            .field-textarea {
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
            .field-select:focus,
            .field-textarea:focus {
                background: #fff;
                border-color: var(--blue);
                box-shadow: 0 0 0 4px rgba(29, 95, 168, 0.1);
            }

            .field-input[readonly],
            .field-textarea[readonly] {
                background: #f1f5f9;
                border-color: #e2e8f0;
                color: var(--muted);
                cursor: not-allowed;
            }

            .field-textarea {
                resize: vertical;
                min-height: 90px;
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

            .status-chip {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 700;
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
                box-shadow: 0 4px 14px rgba(29, 95, 168, 0.3);
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

            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                font-size: 13.5px;
                font-weight: 600;
                color: var(--muted);
                text-decoration: none;
                padding: 8px 14px;
                border-radius: 10px;
                transition: all 0.2s;
                margin-top: 1.25rem;
            }

            .back-link:hover {
                background: var(--sky);
                color: var(--blue);
            }
        </style>
    </head>
    <body>

        <%-- Variables i18n expuestas al JS mediante data-attributes --%>
        <fmt:message key="cita.alert.actualizar.titulo" var="i18nActualizarTitulo"/>
        <fmt:message key="cita.alert.actualizar.texto"  var="i18nActualizarTexto"/>
        <fmt:message key="cita.alert.registrar.titulo"  var="i18nRegistrarTitulo"/>
        <fmt:message key="cita.alert.registrar.texto"   var="i18nRegistrarTexto"/>
        <fmt:message key="cita.alert.confirmar.btn"     var="i18nConfirmarBtn"/>
        <fmt:message key="cita.alert.revisar.btn"       var="i18nRevisarBtn"/>

        <div class="page-wrapper">

            <div class="page-header">
                <div class="header-icon">
                    <i class="bi bi-${cita != null ? 'pencil-square' : 'calendar-plus'}"></i>
                </div>
                <div class="header-text">
                    <h1>
                        <c:choose>
                            <c:when test="${cita != null}">
                                <fmt:message key="cita.form.titulo.editar"/>
                                <span style="color: var(--muted); font-size: 1rem; font-weight: 500;">&nbsp;#${cita.id}</span>
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="cita.form.titulo.nueva"/>
                            </c:otherwise>
                        </c:choose>
                    </h1>
                    <p><fmt:message key="app.logo"/> &mdash; <fmt:message key="cita.panelMedico"/></p>
                </div>
            </div>

            <div class="form-card">
                <form action="citas" method="POST" id="formCita"
                      data-titulo-edicion="${i18nActualizarTitulo}"
                      data-texto-edicion="${i18nActualizarTexto}"
                      data-titulo-registro="${i18nRegistrarTitulo}"
                      data-texto-registro="${i18nRegistrarTexto}"
                      data-btn-confirmar="${i18nConfirmarBtn}"
                      data-btn-revisar="${i18nRevisarBtn}">

                    <input type="hidden" name="id"     value="${cita.id}">
                    <input type="hidden" name="accion" value="${cita != null ? 'actualizar' : 'insertar'}">

                    <div class="form-section">
                        <div class="section-title">
                            <i class="bi bi-person-vcard"></i>
                            <fmt:message key="cita.identificacion"/>
                        </div>
                        <div class="grid-2">
                            <div>
                                <label class="field-label"><fmt:message key="cita.IdPaciente"/></label>
                                <input type="number" name="id_paciente" class="field-input"
                                       value="${cita.id_paciente}"
                                       ${usuarioPendiente.rol != 'RECEPCIONISTA' ? 'readonly' : ''} required>
                            </div>
                            <div>
                                <label class="field-label"><fmt:message key="cita.IdMedico"/></label>
                                <input type="number" name="id_medico" class="field-input"
                                       value="${cita != null ? cita.id_medico : ''}"
                                       ${usuarioPendiente.rol != 'RECEPCIONISTA' ? 'readonly' : ''} required>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <div class="section-title">
                            <i class="bi bi-calendar3"></i>
                            <fmt:message key="cita.programacion"/>
                        </div>
                        <div class="grid-2">
                            <div>
                                <label class="field-label"><fmt:message key="cita.fecha"/></label>
                                <input type="date" name="fecha_cita" class="field-input"
                                       value="${cita != null ? cita.fecha_cita.toLocalDate() : ''}"
                                       ${usuarioPendiente.rol != 'RECEPCIONISTA' ? 'readonly' : ''} required>
                            </div>
                            <div>
                                <label class="field-label"><fmt:message key="cita.hora"/></label>
                                <input type="time" name="hora_cita" class="field-input"
                                       value="${cita != null ? cita.hora_cita.toString().substring(0,5) : ''}"
                                       ${usuarioPendiente.rol != 'RECEPCIONISTA' ? 'readonly' : ''} required>
                            </div>
                            <div>
                                <label class="field-label"><fmt:message key="cita.form.especialidad.id"/></label>
                                <input type="number" name="id_especialidad" class="field-input"
                                       value="${cita.id_especialidad}"
                                       ${usuarioPendiente.rol != 'RECEPCIONISTA' ? 'readonly' : ''} required>
                            </div>
                            <div>
                                <label class="field-label"><fmt:message key="cita.form.estado.label"/></label>
                                <div class="select-wrapper">
                                    <select name="estado" class="field-select">
                                        <option value="PROGRAMADA"  ${cita.estado == 'PROGRAMADA'  ? 'selected' : ''}>📅 <fmt:message key="cita.estado.programada"/></option>
                                        <option value="CONFIRMADA"  ${cita.estado == 'CONFIRMADA'  ? 'selected' : ''}>✅ <fmt:message key="cita.estado.confirmada"/></option>
                                        <option value="ATENDIDA"    ${cita.estado == 'ATENDIDA'    ? 'selected' : ''}>🩺 <fmt:message key="cita.estado.atendida"/></option>
                                        <option value="CANCELADA"   ${cita.estado == 'CANCELADA'   ? 'selected' : ''}>❌ <fmt:message key="cita.estado.cancelada"/></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <div class="section-title">
                            <i class="bi bi-clipboard2-pulse"></i>
                            <fmt:message key="cita.informacionClinica"/>
                        </div>
                        <div class="grid-1">
                            <div>
                                <label class="field-label"><fmt:message key="cita.motivo"/></label>
                                <textarea name="motivo" class="field-textarea"
                                          ${usuarioPendiente.rol != 'RECEPCIONISTA' ? 'readonly' : ''}
                                          required>${cita.motivo}</textarea>
                            </div>
                            <div>
                                <label class="field-label teal">
                                    <i class="bi bi-stethoscope"></i> <fmt:message key="cita.observaciones"/>
                                </label>
                                <textarea name="observaciones" class="field-textarea"
                                          style="border-color: rgba(13,148,136,0.3); background: #f0fdfb;">${cita.observaciones}</textarea>
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-confirm">
                            <i class="bi bi-check-circle"></i>
                            <c:choose>
                                <c:when test="${cita != null}">
                                    <fmt:message key="cita.form.guardar.cambios"/>
                                </c:when>
                                <c:otherwise>
                                    <fmt:message key="cita.form.registrar"/>
                                </c:otherwise>
                            </c:choose>
                        </button>
                        <a href="citas?accion=listar" class="btn-cancel">
                            <i class="bi bi-x"></i> <fmt:message key="cita.cancelar"/>
                        </a>
                    </div>
                </form>
            </div>

            <a href="dashboard" class="back-link">
                <i class="bi bi-arrow-left"></i> <fmt:message key="cita.volver"/>
            </a>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.getElementById('formCita').addEventListener('submit', function (e) {
                e.preventDefault();

                const form       = this;
                const esEdicion  = "${cita != null}" === "true";

                const titulo = esEdicion
                        ? form.dataset.tituloEdicion
                        : form.dataset.tituloRegistro;
                const texto  = esEdicion
                        ? form.dataset.textoEdicion
                        : form.dataset.textoRegistro;

                Swal.fire({
                    title:              titulo,
                    text:               texto,
                    icon:               'question',
                    showCancelButton:   true,
                    confirmButtonColor: '#1d5fa8',
                    cancelButtonColor:  '#64748b',
                    confirmButtonText:  form.dataset.btnConfirmar,
                    cancelButtonText:   form.dataset.btnRevisar,
                    reverseButtons:     true
                }).then((result) => {
                    if (result.isConfirmed) form.submit();
                });
            });
        </script>
    </body>
</html>
