package co.sena.cimm.adso.saludboyaca.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.Random;
import javax.imageio.ImageIO;

public class CaptchaGenerator {

    public String generarTexto(int longitud) {
        String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder sb = new StringBuilder();
        Random rnd = new Random();
        while (sb.length() < longitud) {
            int index = (int) (rnd.nextFloat() * caracteres.length());
            sb.append(caracteres.charAt(index));
        }
        return sb.toString();
    }

    public BufferedImage crearImagen(String texto) {
        int ancho = 150;
        int alto = 50;
        BufferedImage imagen = new BufferedImage(ancho, alto, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = imagen.createGraphics();

        g2d.setColor(Color.WHITE);
        g2d.fillRect(0, 0, ancho, alto);

        g2d.setColor(Color.LIGHT_GRAY);
        Random r = new Random();
        for (int i = 0; i < 10; i++) {
            g2d.drawLine(r.nextInt(ancho), r.nextInt(alto), r.nextInt(ancho), r.nextInt(alto));
        }

        g2d.setFont(new Font("Verdana", Font.BOLD, 28));
        g2d.setColor(new Color(20, 100, 200));
        g2d.drawString(texto, 20, 35);
        g2d.dispose();
        return imagen;
    }

    public String crearImagenBase64(String texto) {
        BufferedImage imagen = crearImagen(texto);
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(imagen, "png", baos);
            String base64 = Base64.getEncoder().encodeToString(baos.toByteArray());
            return "data:image/png;base64," + base64;
        } catch (IOException e) {
            e.printStackTrace();
            return "";
        }
    }
}