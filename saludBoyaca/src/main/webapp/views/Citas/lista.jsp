<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="messages"/>

<c:set var="currentLocale" value="${pageContext.response.locale.language}" />

<!DOCTYPE html>
<html lang="${currentLocale}">
    <head>
        <meta charset="UTF-8">
        <title><fmt:message key="app.nombre"/></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&family=Sora:wght@600;700&display=swap" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

        <style>
            :root {
                --navy: #0f2744;
                --blue: #1d5fa8;
                --sky: #e8f2fd;
                --teal: #0d9488;
                --teal-light: #e6f7f5;
                --danger: #dc2626;
                --warning: #d97706;
                --warn-light: #fef3c7;
                --border: #e4eaf2;
                --text: #1e293b;
                --muted: #64748b;
                --radius: 14px;
            }
            body {
                background: #ffffff;
                font-family: 'Plus Jakarta Sans', sans-serif;
                color: var(--text);
                padding: 2rem 1.5rem;
            }
            .page-wrapper {
                max-width: 1200px;
                margin: 0 auto;
                animation: fadeUp 0.4s ease both;
            }
            @keyframes fadeUp {
                from {
                    opacity: 0;
                    transform: translateY(16px);
                }
                to {
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
                box-shadow: 0 6px 16px rgba(29, 95, 168, 0.25);
            }
            .header-text h1 {
                font-family: 'Sora', sans-serif;
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--navy);
            }
            .btn-action {
                display: inline-flex;
                align-items: center;
                gap: 7px;
                padding: 10px 20px;
                border-radius: 12px;
                font-size: 14px;
                font-weight: 600;
                border: none;
                cursor: pointer;
                text-decoration: none;
                transition: all 0.2s ease;
            }
            .btn-new {
                background: var(--teal);
                color: #fff;
            }
            .btn-pdf {
                background: var(--navy);
                color: #fff;
            }
            .table-card {
                border: 1.5px solid var(--border);
                border-radius: var(--radius);
                overflow: hidden;
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
                color: rgba(255,255,255,0.75);
            }
            tbody td {
                padding: 14px 18px;
                font-size: 14px;
            }
            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 5px;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 700;
            }
            .status-confirmed {
                background: var(--teal-light);
                color: var(--teal);
            }
            .status-pending {
                background: var(--warn-light);
                color: var(--warning);
            }
            .status-attended {
                background: #eff6ff;
                color: var(--blue);
            }
            .status-danger {
                background: #fef2f2;
                color: var(--danger);
            }
            .action-btn {
                width: 34px;
                height: 34px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 10px;
                border: 1.5px solid var(--border);
            }
            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                font-size: 13.5px;
                font-weight: 600;
                color: var(--muted);
                text-decoration: none;
                margin-top: 1.25rem;
            }
        </style>
    </head>
    <body>
        <div class="page-wrapper">
            <div id="area-reporte">
                <div class="page-header">
                    <div class="header-left">
                        <div class="header-icon"><i class="bi bi-calendar2-check"></i></div>
                        <div class="header-text">
                            <h1><fmt:message key="cita.titulo"/></h1>
                            <p><fmt:message key="app.logo"/> &mdash; <fmt:message key="cita.panelMedico"/></p>
                        </div>
                    </div>

                    <div class="header-actions d-flex gap-2" data-html2canvas-ignore="true">
                        <c:if test="${usuarioPendiente.rol == 'RECEPCIONISTA'}">
                            <a href="citas?accion=nuevo" class="btn-action btn-new">
                                <i class="bi bi-plus-lg"></i> <fmt:message key="cita.nueva"/>
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
                                    <th><fmt:message key="cita.fecha"/></th>
                                    <th><fmt:message key="cita.hora"/></th>
                                    <th><fmt:message key="cita.paciente"/></th>
                                    <th><fmt:message key="cita.motivo"/></th>
                                    <th><fmt:message key="cita.observaciones"/></th>
                                    <th><fmt:message key="cita.estado"/></th>
                                        <c:if test="${usuarioPendiente.rol != 'ENFERMERO'}">
                                        <th class="text-center" data-html2canvas-ignore="true"><fmt:message key="cita.acciones"/></th>
                                        </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${listaCitas}">
                                    <tr>
                                        <td class="cell-date">
                                            <c:choose>
                                                <c:when test="${fn:contains(c.fecha_cita, 'T')}">${fn:substringBefore(c.fecha_cita, 'T')}</c:when>
                                                <c:otherwise>${c.fecha_cita}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><span class="cell-time"><i class="bi bi-clock"></i> ${c.hora_cita}</span></td>
                                        <td><span class="patient-badge"><i class="bi bi-person"></i> ID: ${c.id_paciente}</span></td>
                                        <td><span class="cell-text">${c.motivo}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty c.observaciones}">
                                                    <span class="cell-text" style="color: var(--muted);">${c.observaciones}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="cell-empty"><fmt:message key="cita.sinObservaciones"/></span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="status-badge 
                                                  ${c.estado == 'CONFIRMADA' ? 'status-confirmed' : 
                                                    c.estado == 'ATENDIDA' ? 'status-attended' : 
                                                    c.estado == 'CANCELADA' ? 'status-danger' : 'status-pending'}">
                                                <span class="status-dot"></span>
                                                ${c.estado}
                                            </span>
                                        </td>
                                        <c:if test="${usuarioPendiente.rol != 'ENFERMERO'}">
                                            <td class="text-center" data-html2canvas-ignore="true">
                                                <div class="d-flex gap-2 justify-content-center">
                                                    <a href="citas?accion=detalle&id=${c.id}" class="action-btn action-view"><i class="bi bi-file-earmark-medical"></i></a>
                                                    <a href="citas?accion=editar&id=${c.id}" class="action-btn action-edit"><i class="bi bi-pencil"></i></a>
                                                        <c:if test="${usuarioPendiente.rol == 'RECEPCIONISTA'}">
                                                        <button onclick="confirmarEliminar('${c.id}')" class="action-btn action-delete"><i class="bi bi-trash3"></i></button>
                                                        </c:if>
                                                </div>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listaCitas}">
                                    <tr>
                                        <td colspan="7">
                                            <div class="empty-state">
                                                <i class="bi bi-calendar-x"></i>
                                                <p><fmt:message key="cita.noRegistros"/></p>
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
                        <fmt:message key="cita.reporte"/>: <strong id="fecha-actual"></strong>
                    </span>
                </div>
            </div>

            <div data-html2canvas-ignore="true">
                <a href="dashboard" class="back-link">
                    <i class="bi bi-arrow-left"></i> <fmt:message key="cita.volver"/>
                </a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                                                            let locale = 'es-CO';

                                                            if ('${currentLocale}' === 'en') {
                                                                locale = 'en-US';
                                                            } else if ('${currentLocale}' === 'it') {
                                                                locale = 'it-IT';
                                                            }

                                                            document.getElementById('fecha-actual').innerText = new Date().toLocaleString(locale, {
                                                                day: '2-digit',
                                                                month: 'long',
                                                                year: 'numeric',
                                                                hour: '2-digit',
                                                                minute: '2-digit'
                                                            });

                                                            function confirmarEliminar(id) {
                                                                Swal.fire({
                                                                    title: '<fmt:message key="alert.eliminarTitulo"/>',
                                                                    text: '<fmt:message key="alert.eliminarTexto"/>',
                                                                    icon: 'warning',
                                                                    showCancelButton: true,
                                                                    confirmButtonColor: '#dc2626',
                                                                    cancelButtonColor: '#64748b',
                                                                    confirmButtonText: '<fmt:message key="alert.confirmarBtn"/>',
                                                                    cancelButtonText: '<fmt:message key="alert.cancelarBtn"/>',
                                                                    reverseButtons: true
                                                                }).then((result) => {
                                                                    if (result.isConfirmed) {
                                                                        window.location.href = 'citas?accion=eliminar&id=' + id;
                                                                    }
                                                                });
                                                            }

                                                            function generarReportePDF() {
                                                                const element = document.getElementById('area-reporte');
                                                                const opt = {
                                                                    margin: [10, 5, 10, 5],
                                                                    filename: 'Reporte_Citas_' + new Date().getTime() + '.pdf',
                                                                    image: {type: 'jpeg', quality: 0.98},
                                                                    html2canvas: {scale: 2, useCORS: true},
                                                                    jsPDF: {unit: 'mm', format: 'a4', orientation: 'landscape'}
                                                                };
                                                                html2pdf().set(opt).from(element).save();
                                                            }
        </script>
    </body>
</html>