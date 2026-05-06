package co.sena.cimm.adso.saludboyaca.util;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;
import java.io.OutputStream;
import java.util.Date;

public class PDFGenerator {

    public void generarComprobanteCita(String datos, OutputStream out) throws DocumentException {
        Document documento = new Document();
        
        try {
            PdfWriter.getInstance(documento, out);
            
            documento.open();
            
            Font tituloFont = new Font(Font.HELVETICA, 18, Font.BOLD);
            Font cuerpoFont = new Font(Font.HELVETICA, 12, Font.NORMAL);
            
            documento.add(new Paragraph("SISTEMA DE SALUD BOYACÁ", tituloFont));
            documento.add(new Paragraph("Comprobante de Cita Médica", tituloFont));
            documento.add(new Paragraph("--------------------------------------------------"));
            documento.add(new Paragraph("Fecha de emisión: " + new Date().toString(), cuerpoFont));
            documento.add(new Paragraph("\nDetalles de la Cita:", cuerpoFont));
            documento.add(new Paragraph(datos, cuerpoFont));
            
            documento.add(new Paragraph("\n\nNota: Por favor presentarse 15 minutos antes."));
            
        } finally {
            if (documento.isOpen()) {
                documento.close();
            }
        }
    }
}