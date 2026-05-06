<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'es'}"/>
<fmt:setBundle basename="messages"/>


<!DOCTYPE html>
<html lang="${sessionScope.lang}">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><fmt:message key="app.nombre"/></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&family=Sora:wght@600;700&display=swap" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

        <style>
            :root {
                --navy:       #0f2744;
                --blue:       #1d5fa8;
                --sky:        #e8f2fd;
                --teal:       #0d9488;
                --teal-light: #e6f7f5;
                --danger:     #dc2626;
                --warning:    #d97706;
                --warn-light: #fef3c7;
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
                padding: 2rem 1.5rem;
            }

            .page-wrapper {
                max-width: 1300px;
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
                justify-content: space-between;
                flex-wrap: wrap;
                gap: 1rem;
                margin-bottom: 2rem;
            }

            .header-left {
                display: flex;
                align-items: center;
                gap: 1rem;
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
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--navy);
                letter-spacing: -0.02em;
                line-height: 1.2;
            }

            .header-text p {
                font-size: 13px;
                color: var(--muted);
                margin-top: 2px;
            }

            .btn-action {
                display: inline-flex;
                align-items: center;
                gap: 7px;
                padding: 10px 20px;
                border-radius: 12px;
                font-family: 'Plus Jakarta Sans', sans-serif;
                font-size: 14px;
                font-weight: 600;
                border: none;
                cursor: pointer;
                text-decoration: none;
                transition: all 0.2s ease;
            }

            .btn-new {
                background: linear-gradient(135deg, var(--teal), #0ab5a6);
                color: #fff;
                box-shadow: 0 4px 12px rgba(13, 148, 136, 0.3);
            }
            .btn-new:hover {
                filter: brightness(1.08);
                transform: translateY(-1px);
                color: #fff;
            }

            .btn-pdf {
                background: var(--navy);
                color: #fff;
                box-shadow: 0 4px 12px rgba(15, 39, 68, 0.25);
            }
            .btn-pdf:hover {
                filter: brightness(1.15);
                transform: translateY(-1px);
                color: #fff;
            }

            .section-divider {
                height: 1px;
                background: var(--border);
                margin-bottom: 1.75rem;
            }

            .table-card {
                border: 1.5px solid var(--border);
                border-radius: var(--radius);
                overflow: hidden;
                box-shadow: 0 2px 12px rgba(15, 39, 68, 0.06);
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }
            thead tr {
                background: var(--navy);
            }
            thead th {
                padding: 14px 18px;
                font-size: 11.5px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.07em;
                color: rgba(255,255,255,0.75);
                border: none;
                white-space: nowrap;
            }

            tbody tr {
                border-bottom: 1px solid var(--border);
                transition: background 0.15s;
            }
            tbody tr:hover {
                background: #f7faff;
            }
            tbody td {
                padding: 14px 18px;
                font-size: 14px;
                vertical-align: middle;
                color: var(--text);
            }

            .cell-doc {
                font-weight: 700;
                color: var(--navy);
                font-size: 13px;
                font-family: 'Sora', sans-serif;
            }
            .eps-badge {
                display: inline-flex;
                align-items: center;
                background: var(--sky);
                border: 1px solid rgba(29,95,168,0.2);
                color: var(--blue);
                font-size: 12px;
                font-weight: 600;
                padding: 4px 10px;
                border-radius: 8px;
            }
            .cell-link {
                color: var(--blue);
                font-size: 13px;
                text-decoration: none;
            }
            .cell-link:hover {
                text-decoration: underline;
            }
            .cell-empty {
                color: #b0bec5;
                font-style: italic;
                font-size: 13px;
            }

            .action-btn {
                width: 34px;
                height: 34px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 10px;
                font-size: 15px;
                border: 1.5px solid var(--border);
                background: #fff;
                cursor: pointer;
                text-decoration: none;
                transition: all 0.18s;
            }
            .action-edit {
                color: var(--blue);
            }
            .action-edit:hover {
                background: var(--sky);
                border-color: var(--blue);
                color: var(--blue);
            }
            .action-delete {
                color: var(--danger);
            }
            .action-delete:hover {
                background: #fff1f1;
                border-color: var(--danger);
                color: var(--danger);
            }

            .report-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 0.5rem;
                padding-top: 1.25rem;
                margin-top: 1.25rem;
                border-top: 1px solid var(--border);
            }
            .report-footer .timestamp {
                font-size: 12.5px;
                color: var(--muted);
                display: flex;
                align-items: center;
                gap: 6px;
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

            .empty-state {
                text-align: center;
                padding: 3rem 1rem;
                color: var(--muted);
            }
            .empty-state i {
                font-size: 2.5rem;
                opacity: 0.3;
                display: block;
                margin-bottom: 0.75rem;
            }
        </style>
    </head>
    <body>
        <div class="page-wrapper">
            <div id="area-reporte">

                <div class="page-header">
                    <div class="header-left">
                        <div class="header-icon">
                            <i class="bi bi-people-fill"></i>
                        </div>
                        <div class="header-text">
                            <h1><fmt:message key="pacientes.Gestion"/></h1>
                            <p><fmt:message key="app.logo"/> &mdash; <fmt:message key="pacientes.registro"/></p>
                        </div>
                    </div>

                    <div class="header-actions d-flex gap-2" data-html2canvas-ignore="true">
                        <c:if test="${usuarioPendiente.rol == 'ADMIN' || usuarioPendiente.rol == 'RECEPCIONISTA'}">
                            <a href="${pageContext.request.contextPath}/pacientes/nuevo" class="btn-action btn-new">
                                <i class="bi bi-person-plus-fill"></i> <fmt:message key="paciente.nuevo"/>
                            </a>
                        </c:if>
                        <c:if test="${usuarioPendiente.rol != 'ENFERMERO'}">
                            <button onclick="generarReportePDF()" class="btn-action btn-pdf">
                                <i class="bi bi-file-earmark-pdf"></i> <fmt:message key="cita.GuardarPDF"/>
                            </button>
                        </c:if>
                    </div>
                </div>

                <div class="section-divider"></div>

                <div class="table-card">
                    <div style="overflow-x: auto;">
                        <table>
                            <thead>
                                <tr>
                                    <th><fmt:message key="paciente.documento"/></th>
                                    <th><fmt:message key="paciente.nombres"/></th>
                                    <th><fmt:message key="paciente.apellidos"/></th>
                                    <th><fmt:message key="paciente.eps"/></th>
                                    <th><fmt:message key="paciente.nacimiento"/></th>
                                    <th><fmt:message key="paciente.telefono"/></th>
                                    <th><fmt:message key="pacientes.correo"/></th>
                                    <th><fmt:message key="pacientes.veredaBarrio"/></th>
                                        <c:if test="${usuarioPendiente.rol != 'ENFERMERO'}">
                                        <th class="text-center" data-html2canvas-ignore="true"><fmt:message key="cita.acciones"/></th>
                                        </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${listaPacientes}">
                                    <tr>
                                        <td><span class="cell-doc">${p.documento}</span></td>
                                        <td>${p.nombres}</td>
                                        <td>${p.apellidos}</td>
                                        <td>
                                            <span class="eps-badge">
                                                <i class="bi bi-shield-plus me-1" style="font-size:11px;"></i>
                                                ${p.eps}
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty p.fechaNacimiento}">
                                                    <fmt:parseDate value="${p.fechaNacimiento}" pattern="yyyy-MM-dd" var="fechaParsed" type="date"/>
                                                    <fmt:formatDate value="${fechaParsed}" pattern="dd/MM/yyyy"/>
                                                </c:when>
                                                <c:otherwise><span class="cell-empty">—</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${not empty p.telefono ? p.telefono : '<span class="cell-empty">—</span>'}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty p.email}">
                                                    <a href="mailto:${p.email}" class="cell-link">${p.email}</a>
                                                </c:when>
                                                <c:otherwise><span class="cell-empty">—</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${not empty p.veredaBarrio ? p.veredaBarrio : '<span class="cell-empty">—</span>'}</td>

                                        <c:if test="${usuarioPendiente.rol != 'ENFERMERO'}">
                                            <td class="text-center" data-html2canvas-ignore="true">
                                                <div class="d-flex gap-2 justify-content-center">
                                                    <c:if test="${usuarioPendiente.rol == 'ADMIN' || usuarioPendiente.rol == 'RECEPCIONISTA'}">
                                                        <a href="${pageContext.request.contextPath}/pacientes/editar?id=${p.id}" class="action-btn action-edit" title="Editar">
                                                            <i class="bi bi-pencil"></i>
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${usuarioPendiente.rol == 'RECEPCIONISTA'}">
                                                        <button onclick="confirmarEliminar('${p.id}')" class="action-btn action-delete" title="Eliminar">
                                                            <i class="bi bi-trash3"></i>
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty listaPacientes}">
                                    <tr>
                                        <td colspan="${usuarioPendiente.rol == 'ENFERMERO' ? 8 : 9}">
                                            <div class="empty-state">
                                                <i class="bi bi-person-x"></i>
                                                <p>No se encontraron pacientes en la base de datos.</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="report-footer">
                    <span class="timestamp">
                        <i class="bi bi-clock-history"></i>
                        <fmt:message key="cita.reporte"/> <strong id="fecha-actual"></strong>
                    </span>
                </div>
            </div>

            <div data-html2canvas-ignore="true">
                <a href="${pageContext.request.contextPath}/dashboard" class="back-link">
                    <i class="bi bi-arrow-left"></i> <fmt:message key="cita.volver"/>
                </a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                                                            const lang = '${sessionScope.lang != null ? sessionScope.lang : "es"}';

                                                            const locales = {
                                                                es: 'es-CO',
                                                                en: 'en-US',
                                                                it: 'it-IT'
                                                            };

                                                            const locale = locales[lang] || 'es-CO';

                                                            document.getElementById('fecha-actual').innerText = new Date().toLocaleString(locale, {
                                                                day: '2-digit',
                                                                month: 'long',
                                                                year: 'numeric',
                                                                hour: '2-digit',
                                                                minute: '2-digit'
                                                            });

                                                            function confirmarEliminar(id) {
                                                                Swal.fire({
                                                                    title: '<fmt:message key="paciente.alert.eliminar.titulo"/>',
                                                                    text: '<fmt:message key="paciente.alert.eliminar.texto"/>',
                                                                    icon: 'warning',
                                                                    showCancelButton: true,
                                                                    confirmButtonColor: '#dc2626',
                                                                    cancelButtonColor: '#64748b',
                                                                    confirmButtonText: '<fmt:message key="paciente.alert.eliminar.confirmar"/>',
                                                                    cancelButtonText: '<fmt:message key="paciente.alert.eliminar.cancelar"/>',
                                                                    reverseButtons: true
                                                                }).then((result) => {
                                                                    if (result.isConfirmed) {
                                                                        window.location.href = '${pageContext.request.contextPath}/pacientes/eliminar?id=' + id;
                                                                    }
                                                                });
                                                            }

                                                            function generarReportePDF() {
                                                                const element = document.getElementById('area-reporte');
                                                                const opt = {
                                                                    margin: [10, 5, 10, 5],
                                                                    filename: 'Reporte_Pacientes_SaludBoyaca.pdf',
                                                                    image: {type: 'jpeg', quality: 0.98},
                                                                    html2canvas: {scale: 2, useCORS: true},
                                                                    jsPDF: {unit: 'mm', format: 'a4', orientation: 'landscape'}
                                                                };
                                                                html2pdf().set(opt).from(element).save();
                                                            }

                                                            const urlParams = new URLSearchParams(window.location.search);
                                                            const msg = urlParams.get('msg');

                                                            const mensajes = {
                                                                creado: {
                                                                    title: '<fmt:message key="paciente.alert.creado.titulo"/>',
                                                                    text: '<fmt:message key="paciente.alert.creado.texto"/>'
                                                                },
                                                                editado: {
                                                                    title: '<fmt:message key="paciente.alert.editado.titulo"/>',
                                                                    text: '<fmt:message key="paciente.alert.editado.texto"/>'
                                                                },
                                                                eliminado: {
                                                                    title: '<fmt:message key="paciente.alert.eliminado.titulo"/>',
                                                                    text: '<fmt:message key="paciente.alert.eliminado.texto"/>'
                                                                }
                                                            };

                                                            if (msg && mensajes[msg]) {
                                                                Swal.fire({
                                                                    icon: 'success',
                                                                    title: mensajes[msg].title,
                                                                    text: mensajes[msg].text,
                                                                    confirmButtonColor: '#0f2744',
                                                                    timer: 2500,
                                                                    timerProgressBar: true,
                                                                    showConfirmButton: false
                                                                });
                                                            }
        </script>
    </body>
</html>