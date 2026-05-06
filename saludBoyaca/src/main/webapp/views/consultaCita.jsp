<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SaludBoyacá - Comprobante de Citas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/dist/css/all.min.css">
        <style>
            body {
                background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
                min-height: 100vh;
                color: white;
                padding: 40px 0;
            }
            .glass-card {
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 15px;
                padding: 2rem;
            }
            .no-print {
                display: block;
            }
            @media print {
                .no-print {
                    display: none !important;
                }
                body {
                    background: white !important;
                    color: black !important;
                }
                .glass-card {
                    border: 1px solid #000;
                    background: white !important;
                    color: black !important;
                }
            }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="glass-card">
                <div class="d-flex justify-content-between align-items-start border-bottom pb-3 mb-4">
                    <div>
                        <h1 class="h2">Paciente: ${paciente.nombres} ${paciente.apellidos}</h1>
                        <p class="mb-0 opacity-75">Documento: ${paciente.documento}</p>
                    </div>
                    <div class="text-end">
                        <h3 class="h5 text-info">SaludBoyacá</h3>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-dark table-hover border-secondary">
                        <thead>
                            <tr>
                                <th>Fecha</th>
                                <th>Hora</th>
                                <th>Vacuna / Motivo</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- IMPORTANTE: Verificamos si la lista 'resultados' existe --%>
                            <c:forEach var="cita" items="${resultados}">
                                <tr>
                                    <td>${cita.fecha_cita.toLocalDate()}</td>
                                    <td>${cita.hora_cita}</td>
                                    <td>${cita.motivo}</td>
                                    <td>
                                        <span class="badge ${cita.estado == 'REALIZADA' ? 'bg-success' : 'bg-warning'} text-dark">
                                            ${cita.estado}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>

                            <%-- Mensaje si no hay datos --%>
                            <c:if test="${empty resultados}">
                                <tr>
                                    <td colspan="4" class="text-center py-4 text-warning">
                                        <i class="fas fa-search me-2"></i>
                                        No se encontraron citas para el ID: ${paciente.id}. Verifique en la base de datos.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

                <!-- ... (resto de tu código) ... -->

                <div class="container">
                    <!-- 2. Agregamos un ID a la tarjeta para que la librería sepa qué exportar -->
                    <div class="glass-card" id="comprobante-contenido">

                        <!-- ... (Contenido de tu tabla y datos del paciente) ... -->

                        <div class="d-flex justify-content-center gap-3 mt-4 no-print">
                            <!-- 3. Cambiamos el onclick para llamar a nuestra nueva función JS -->
                            <button onclick="exportarPDF()" class="btn btn-danger px-4">
                                <i class="fas fa-file-pdf me-2"></i>Exportar PDF
                            </button>

                            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-light px-4">
                                <i class="fas fa-home me-2"></i>Volver al Inicio
                            </a>
                        </div>
                    </div>
                </div>

                <script>
                    function exportarPDF() {
                        const elemento = document.getElementById('comprobante-contenido');

                        const opciones = {
                            margin: 0.5,
                            filename: 'Comprobante_Cita_${paciente.documento}.pdf',
                            image: {type: 'jpeg', quality: 0.98},
                            html2canvas: {
                                scale: 2,
                                useCORS: true,
                                backgroundColor: '#0f2027' 
                            },
                            jsPDF: {unit: 'in', format: 'letter', orientation: 'portrait'}
                        };

                        const botones = elemento.querySelector('.no-print');
                        botones.style.visibility = 'hidden';

                        html2pdf().set(opciones).from(elemento).save().then(() => {
                            botones.style.visibility = 'visible';
                        });
                    }
                </script>
            </div>
        </div>

    </body>
</html>