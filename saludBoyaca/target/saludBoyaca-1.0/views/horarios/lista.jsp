<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><fmt:message key="horarios.gestion"/></title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>

        <style>
            :root {
                --primary-color: #1a56db;
                --glass-bg: rgba(255, 255, 255, 0.95);
            }

            body {
                background-color: #f0f4f8;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .glass-card {
                background: var(--glass-bg);
                border-radius: 16px;
                box-shadow: 0 4px 24px rgba(0,0,0,0.08);
                border: 1px solid rgba(255, 255, 255, 0.3);
                backdrop-filter: blur(10px);
            }

            .page-header {
                border-bottom: 1px solid #e9ecef;
                padding-bottom: 1rem;
                margin-bottom: 1.5rem;
            }

            .table thead th {
                font-size: 0.75rem;
                letter-spacing: 0.05em;
                text-transform: uppercase;
                color: #6c757d;
                background-color: #f8fafc;
                border-bottom: 2px solid #dee2e6;
            }

            .badge-dia {
                background-color: #e8f0fe;
                color: var(--primary-color);
                font-weight: 600;
                font-size: 0.8rem;
                padding: 6px 14px;
                border-radius: 20px;
                display: inline-block;
            }

            .hora-badge {
                font-family: 'Courier New', Courier, monospace;
                font-weight: 600;
                color: #374151;
                background: #f3f4f6;
                padding: 2px 8px;
                border-radius: 4px;
            }

            .page-footer {
                border-top: 1px solid #e9ecef;
                padding-top: 1.5rem;
                margin-top: 2rem;
            }

            @media print {
                .no-print {
                    display: none !important;
                }
                body {
                    background: white;
                }
                .glass-card {
                    box-shadow: none;
                    border: none;
                }
            }
        </style>
    </head>
    <body>

        <div class="container py-5">
            <div class="glass-card p-4">

                <div class="page-header d-flex justify-content-between align-items-start flex-wrap gap-2">
                    <div>
                        <h2 class="mb-1">
                            <i class="bi bi-clock-history text-primary me-2"></i>
                            <fmt:message key="horarios.horarios"/>
                        </h2>
                        <small class="text-muted"><fmt:message key="horarios.disponibilidad"/></small>
                    </div>

                    <div class="no-print d-flex gap-2">
                        <button onclick="exportarPDF()" class="btn btn-danger shadow-sm">
                            <i class="bi bi-file-earmark-pdf me-1"></i> 
                            <fmt:message key="horarios.exportarPDF"/>
                        </button>

                        <c:if test="${sessionScope.rol == 'RECEPCIONISTA'}">
                            <a href="horarios?accion=nuevo" class="btn btn-success shadow-sm">
                                <i class="bi bi-plus-circle me-1"></i> 
                                <fmt:message key="horarios.nuevo"/>
                            </a>
                        </c:if>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle" id="tablaHorarios">
                        <thead>
                            <tr>
                                <th><fmt:message key="cita.IdMedico"/></th>
                                <th><fmt:message key="horarios.diaSemana"/></th>
                                <th><fmt:message key="horarios.horaInicio"/></th>
                                <th><fmt:message key="horarios.horaFin"/></th>
                                <th class="text-center"><fmt:message key="horarios.maximoCitas"/></th>
                                    <c:if test="${sessionScope.rol == 'RECEPCIONISTA'}">
                                    <th class="text-center no-print"><fmt:message key="cita.acciones"/></th>
                                    </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="h" items="${listaHorarios}">
                                <tr>
                                    <td><span class="fw-bold text-dark">${h.id_medico}</span></td>
                                    <td>
                                        <span class="badge-dia">
                                            <fmt:message key="day.${h.dia_semana}"/>
                                        </span>
                                    </td>
                                    <td><span class="hora-badge">${h.hora_inicio}</span></td>
                                    <td><span class="hora-badge">${h.hora_fin}</span></td>
                                    <td class="text-center">
                                        <span class="badge rounded-pill bg-info text-dark" style="min-width: 40px;">
                                            ${h.max_citas}
                                        </span>
                                    </td>
                                    <c:if test="${sessionScope.rol == 'RECEPCIONISTA'}">
                                        <td class="text-center no-print">
                                            <a href="horarios?accion=editar&id=${h.id}" 
                                               class="btn btn-outline-primary btn-sm rounded-pill"
                                               title="<fmt:message key='cita.editar'/>">
                                                <i class="bi bi-pencil-square"></i>
                                            </a>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listaHorarios}">
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted italic">
                                        <i class="bi bi-info-circle me-2"></i> No hay horarios registrados.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="page-footer no-print">
                    <a href="dashboard" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left-circle me-2"></i>
                        <fmt:message key="horarios.volver"/>
                    </a>
                </div>
            </div>
        </div>

        <script>
            async function exportarPDF() {
                const {jsPDF} = window.jspdf;
                const doc = new jsPDF('p', 'pt', 'a4');

                const tituloReporte = "<fmt:message key='pdf.titulo'/>";
                const labelFecha = "<fmt:message key='pdf.emision'/>";

                const primaryColor = [26, 86, 219];

                doc.setFontSize(18);
                doc.setTextColor(40, 40, 40);
                doc.text(tituloReporte, 40, 50);

                doc.setFontSize(10);
                doc.setTextColor(100, 100, 100);
                doc.text(`${labelFecha}: $\{new Date().toLocaleString()}`, 40, 65);

                doc.setDrawColor(primaryColor[0], primaryColor[1], primaryColor[2]);
                doc.setLineWidth(1.5);
                doc.line(40, 75, 550, 75);

                doc.autoTable({
                    html: '#tablaHorarios',
                    startY: 95,
                    theme: 'striped',
                    headStyles: {
                        fillColor: primaryColor,
                        textColor: [255, 255, 255],
                        fontSize: 10,
                        halign: 'center'
                    },
                    styles: {
                        fontSize: 9,
                        cellPadding: 6
                    },
                    columnStyles: {
                        0: {halign: 'center'},
                        4: {halign: 'center'}
                    },
                    didParseCell: function (data) {
                        if (data.column.index === 5) {
                            data.cell.text = "";
                        }
                    }
                });

                const totalPages = doc.internal.getNumberOfPages();
                for (let i = 1; i <= totalPages; i++) {
                    doc.setPage(i);
                    doc.setFontSize(8);
                    doc.text(`Página ${i} de ${totalPages}`, 40, doc.internal.pageSize.height - 20);
                }

                doc.save('Horarios_SaludBoyaca.pdf');
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>