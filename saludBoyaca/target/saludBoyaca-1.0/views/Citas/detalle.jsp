<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="messages" />
<fmt:setLocale value="${pageContext.request.locale}" />
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><fmt:message key="cita.Comprobante"/> #${cita.id} - <fmt:message key="app.logo"/></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&family=Sora:wght@600;700&display=swap" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

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
                --danger:     #dc2626;
                --warning:    #d97706;
                --warn-light: #fef3c7;
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

            #comprobante {
                border: 1.5px solid var(--border);
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 4px 24px rgba(15,39,68,0.07);
                background: #fff;
            }

            .comp-header {
                background: var(--navy);
                padding: 1.75rem 2rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 1rem;
            }

            .comp-brand {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .comp-brand-icon {
                width: 42px;
                height: 42px;
                background: rgba(255,255,255,0.12);
                border: 1.5px solid rgba(255,255,255,0.2);
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #fff;
                font-size: 1.2rem;
            }

            .comp-brand-text h2 {
                font-family: 'Sora', sans-serif;
                font-size: 1.1rem;
                font-weight: 700;
                color: #fff;
                letter-spacing: -0.01em;
            }

            .comp-brand-text p {
                font-size: 11.5px;
                color: rgba(255,255,255,0.55);
                margin-top: 2px;
            }

            .comp-id {
                text-align: right;
            }

            .comp-id span {
                display: block;
                font-size: 11px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.08em;
                color: rgba(255,255,255,0.45);
                margin-bottom: 4px;
            }

            .comp-id strong {
                font-family: 'Sora', sans-serif;
                font-size: 1.4rem;
                font-weight: 700;
                color: #fff;
            }

            .status-strip {
                padding: 10px 2rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
                border-bottom: 1px solid var(--border);
                background: #f8fafc;
            }

            .status-strip p {
                font-size: 12px;
                color: var(--muted);
                display: flex;
                align-items: center;
                gap: 6px;
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 5px;
                padding: 5px 14px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 700;
                letter-spacing: 0.02em;
                white-space: nowrap;
            }

            .status-dot {
                width: 6px;
                height: 6px;
                border-radius: 50%;
                background: currentColor;
            }

            .status-confirmed  {
                background: var(--teal-light);
                color: var(--teal);
            }
            .status-pending    {
                background: var(--warn-light);
                color: var(--warning);
            }
            .status-danger     {
                background: #fef2f2;
                color: var(--danger);
            }
            .status-attended   {
                background: #eff6ff;
                color: var(--blue);
            }

            .comp-section {
                padding: 1.5rem 2rem;
                border-bottom: 1px solid var(--border);
            }

            .comp-section:last-of-type {
                border-bottom: none;
            }

            .comp-section-title {
                font-size: 10.5px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.09em;
                color: var(--muted);
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                gap: 7px;
            }

            .comp-section-title::after {
                content: '';
                flex: 1;
                height: 1px;
                background: var(--border);
            }

            .data-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }

            .data-grid.cols-3 {
                grid-template-columns: 1fr 1fr 1fr;
            }
            .data-grid.cols-1 {
                grid-template-columns: 1fr;
            }

            .data-field label {
                display: block;
                font-size: 10.5px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.06em;
                color: var(--muted);
                margin-bottom: 5px;
            }

            .data-field .value {
                font-size: 14.5px;
                font-weight: 600;
                color: var(--navy);
            }

            .data-field .value.mono {
                font-family: 'Sora', sans-serif;
                font-size: 1rem;
            }

            .id-chip {
                display: inline-flex;
                align-items: center;
                gap: 5px;
                padding: 4px 12px;
                background: var(--sky);
                border: 1px solid rgba(29,95,168,0.15);
                color: var(--blue);
                border-radius: 8px;
                font-size: 13px;
                font-weight: 700;
            }

            .time-chip {
                display: inline-flex;
                align-items: center;
                gap: 5px;
                background: var(--sky);
                color: var(--blue);
                font-weight: 700;
                font-size: 13px;
                padding: 4px 10px;
                border-radius: 8px;
            }

            .clinical-box {
                background: #f8fafc;
                border: 1.5px solid var(--border);
                border-radius: 12px;
                padding: 1rem 1.25rem;
                margin-bottom: 1rem;
            }

            .clinical-box:last-child {
                margin-bottom: 0;
            }

            .clinical-box h6 {
                font-size: 11px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.07em;
                color: var(--muted);
                margin-bottom: 8px;
                display: flex;
                align-items: center;
                gap: 7px;
            }

            .clinical-box.teal {
                border-color: rgba(13,148,136,0.25);
                background: #f0fdfb;
            }

            .clinical-box.teal h6 {
                color: var(--teal);
            }

            .clinical-box p {
                font-size: 14px;
                line-height: 1.6;
                color: var(--text);
            }

            .comp-footer {
                padding: 1rem 2rem;
                background: #f8fafc;
                border-top: 1px solid var(--border);
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 1rem;
                flex-wrap: wrap;
            }

            .comp-footer p {
                font-size: 11.5px;
                color: var(--muted);
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .comp-footer .seal {
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 11.5px;
                font-weight: 600;
                color: var(--teal);
            }

            .page-actions {
                display: flex;
                align-items: center;
                gap: 12px;
                flex-wrap: wrap;
                margin-top: 1.5rem;
            }

            .btn-act {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 11px 22px;
                border-radius: 12px;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-size: 14px;
                font-weight: 600;
                border: none;
                cursor: pointer;
                text-decoration: none;
                transition: all 0.2s;
            }

            .btn-back-act {
                background: transparent;
                border: 1.5px solid var(--border) !important;
                color: var(--muted);
            }
            .btn-back-act:hover {
                background: var(--sky);
                border-color: var(--blue) !important;
                color: var(--blue);
            }

            .btn-pdf-act {
                background: var(--navy);
                color: #fff;
                box-shadow: 0 4px 14px rgba(15,39,68,0.2);
            }
            .btn-pdf-act:hover {
                filter: brightness(1.1);
                transform: translateY(-1px);
                color: #fff;
            }

            .btn-attend-act {
                background: linear-gradient(135deg, var(--teal), #0ab5a6);
                color: #fff;
                box-shadow: 0 4px 12px rgba(13,148,136,0.3);
            }
            .btn-attend-act:hover {
                filter: brightness(1.08);
                transform: translateY(-1px);
                color: #fff;
            }

            @media print {
                .no-print {
                    display: none !important;
                }
                body {
                    padding: 0;
                }
                #comprobante {
                    border: none;
                    box-shadow: none;
                    border-radius: 0;
                }
            }
        </style>
    </head>
    <body>

        <fmt:message key="cita.comp.estadoActual"        var="i18nEstadoActual"/>
        <fmt:message key="cita.comp.generadoEl"          var="i18nGeneradoEl"/>
        <fmt:message key="cita.comp.selloOficial"        var="i18nSelloOficial"/>
        <fmt:message key="cita.comp.volverLista"         var="i18nVolverLista"/>
        <fmt:message key="cita.comp.descargarComp"       var="i18nDescargarComp"/>
        <fmt:message key="cita.comp.atenderPaciente"     var="i18nAtenderPaciente"/>
        <fmt:message key="cita.sinObservaciones"         var="i18nSinObservaciones"/>
        <fmt:message key="cita.comp.nombreArchivo"       var="i18nNombreArchivo"/>

        <div class="page-wrapper">

            <div class="page-header no-print">
                <div class="header-icon">
                    <i class="bi bi-file-earmark-medical"></i>
                </div>
                <div class="header-text">
                    <h1><fmt:message key="cita.Comprobante"/></h1>
                    <p><fmt:message key="app.logo"/> &mdash; <fmt:message key="cita.DocumentoOficial"/></p>
                </div>
            </div>

            <div id="comprobante">

                <div class="comp-header">
                    <div class="comp-brand">
                        <div class="comp-brand-icon">
                            <i class="bi bi-shield-plus"></i>
                        </div>
                        <div class="comp-brand-text">
                            <h2><fmt:message key="app.logo"/></h2>
                            <p><fmt:message key="cita.ComprobanteAsistencia"/></p>
                        </div>
                    </div>
                    <div class="comp-id">
                        <span><fmt:message key="cita.NumeroCita"/></span>
                        <strong>#${cita.id}</strong>
                    </div>
                </div>

                <div class="status-strip">
                    <p>
                        <i class="bi bi-info-circle"></i>
                        <fmt:message key="cita.comp.estadoActual"/>
                    </p>
                    <span class="status-badge
                          ${cita.estado == 'CONFIRMADA' ? 'status-confirmed'  :
                            cita.estado == 'ATENDIDA'   ? 'status-attended'   :
                            cita.estado == 'CANCELADA'  ? 'status-danger'     : 'status-pending'}">
                        <span class="status-dot"></span>
                        <c:choose>
                            <c:when test="${cita.estado == 'CONFIRMADA'}"><fmt:message key="cita.estado.confirmada"/></c:when>
                            <c:when test="${cita.estado == 'ATENDIDA'}"  ><fmt:message key="cita.estado.atendida"/></c:when>
                            <c:when test="${cita.estado == 'CANCELADA'}" ><fmt:message key="cita.estado.cancelada"/></c:when>
                            <c:otherwise>                                  <fmt:message key="cita.estado.programada"/></c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <div class="comp-section">
                    <div class="comp-section-title">
                        <i class="bi bi-people"></i>
                        <fmt:message key="cita.comp.partes"/>
                    </div>
                    <div class="data-grid">
                        <div class="data-field">
                            <label><fmt:message key="cita.paciente"/></label>
                            <div class="value">
                                <span class="id-chip">
                                    <i class="bi bi-person"></i> ID: ${cita.id_paciente}
                                </span>
                            </div>
                        </div>
                        <div class="data-field">
                            <label><fmt:message key="cita.comp.medicoAsignado"/></label>
                            <div class="value">
                                <span class="id-chip">
                                    <i class="bi bi-person-badge"></i> ID: ${cita.id_medico}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="comp-section">
                    <div class="comp-section-title">
                        <i class="bi bi-calendar3"></i>
                        <fmt:message key="cita.programacion"/>
                    </div>
                    <div class="data-grid cols-3">
                        <div class="data-field">
                            <label><fmt:message key="cita.fecha"/></label>
                            <div class="value mono">${cita.fecha_cita}</div>
                        </div>
                        <div class="data-field">
                            <label><fmt:message key="cita.hora"/></label>
                            <div class="value">
                                <span class="time-chip">
                                    <i class="bi bi-clock" style="font-size:12px;"></i>
                                    ${cita.hora_cita}
                                </span>
                            </div>
                        </div>
                        <div class="data-field">
                            <label><fmt:message key="cita.comp.especialidadId"/></label>
                            <div class="value mono">${cita.id_especialidad}</div>
                        </div>
                    </div>
                </div>

                <div class="comp-section">
                    <div class="comp-section-title">
                        <i class="bi bi-clipboard2-pulse"></i>
                        <fmt:message key="cita.informacionClinica"/>
                    </div>

                    <div class="clinical-box">
                        <h6><i class="bi bi-chat-left-text"></i> <fmt:message key="cita.comp.motivoConsulta"/></h6>
                        <p>${cita.motivo}</p>
                    </div>

                    <div class="clinical-box teal">
                        <h6><i class="bi bi-stethoscope"></i> <fmt:message key="cita.observaciones"/></h6>
                        <p>
                            <c:choose>
                                <c:when test="${not empty cita.observaciones}">${cita.observaciones}</c:when>
                                <c:otherwise>
                                    <em style="color:#94a3b8;"><fmt:message key="cita.comp.sinObservaciones"/></em>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>

                <div class="comp-footer">
                    <p>
                        <i class="bi bi-clock-history"></i>
                        <fmt:message key="cita.reporte"/>: <strong id="fecha-generacion"></strong>
                    </p>
                    <div class="seal">
                        <i class="bi bi-patch-check-fill"></i>
                        <fmt:message key="cita.comp.selloOficial"/>
                    </div>
                </div>

            </div>

            <div class="page-actions no-print">
                <a href="citas?accion=listar" class="btn-act btn-back-act">
                    <i class="bi bi-arrow-left"></i>
                    <fmt:message key="cita.comp.volverLista"/>
                </a>

                <button onclick="descargarPDF()" class="btn-act btn-pdf-act">
                    <i class="bi bi-file-earmark-pdf"></i>
                    <fmt:message key="cita.descargar"/>
                </button>

                <c:if test="${cita.id_medico == usuarioPendiente.id}">
                    <c:if test="${cita.estado == 'PROGRAMADA' || cita.estado == 'CONFIRMADA'}">
                        <a href="citas?accion=atender&id=${cita.id}" class="btn-act btn-attend-act">
                            <i class="bi bi-check-circle"></i>
                            <fmt:message key="cita.comp.atenderPaciente"/>
                        </a>
                    </c:if>
                </c:if>
            </div>

        </div>

        <script>
            let locale = '${lang}';

            const localeMap = {
                'es': 'es-ES',
                'en': 'en-US',
                'it': 'it-IT'
            };

            locale = localeMap[locale] || locale;

            document.getElementById('fecha-generacion').innerText =
                    new Date().toLocaleString(locale, {
                day: '2-digit',
                month: 'long',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });

            function descargarPDF() {
                const element = document.getElementById('comprobante');
                const filename = '${i18nNombreArchivo}_${cita.id}.pdf';
                const opt = {
                    margin: 15,
                    filename: filename,
                    image: {type: 'jpeg', quality: 0.98},
                    html2canvas: {scale: 2, useCORS: true},
                    jsPDF: {unit: 'mm', format: 'letter', orientation: 'portrait'}
                };
                html2pdf().set(opt).from(element).save();
            }
        </script>
    </body>
</html>
