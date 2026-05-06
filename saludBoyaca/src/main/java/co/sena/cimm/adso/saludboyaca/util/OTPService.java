package co.sena.cimm.adso.saludboyaca.util;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.security.SecureRandom;
import java.util.Properties;

public class OTPService {

    private static final String SMTP_HOST    = "smtp.gmail.com";
    private static final int    SMTP_PORT    = 587;
    private static final String EMAIL_REMIT  = "Juliandreyes23@gmail.com";
    private static final String EMAIL_PASS   = "kjoe pguv kyez fhmc";
    private static final int    OTP_LONGITUD = 6;
    private static final long   OTP_EXPIRY_MS = 5 * 60 * 1000L;

    private static String getAsunto(String lang) {
        switch (lang != null ? lang : "es") {
            case "en": return "Access Code - SaludBoyacá";
            case "it": return "Codice di Accesso - SaludBoyacá";
            default:   return "Código de Acceso - Salud Boyacá";
        }
    }

    private static String getSaludo(String lang) {
        switch (lang != null ? lang : "es") {
            case "en": return "Dear user,";
            case "it": return "Gentile utente,";
            default:   return "Estimado/a usuario/a,";
        }
    }

    private static String getInstruccion(String lang) {
        switch (lang != null ? lang : "es") {
            case "en": return "To complete your sign-in to the <strong>SaludBoyacá System</strong>, use the following security code:";
            case "it": return "Per completare l&apos;accesso al <strong>Sistema SaludBoyacá</strong>, utilizza il seguente codice di sicurezza:";
            default:   return "Para completar su inicio de sesión en el <strong>Sistema Salud Boyacá</strong>, ingrese el siguiente código de seguridad:";
        }
    }

    private static String getValidez(String lang) {
        switch (lang != null ? lang : "es") {
            case "en": return "This code is single-use and valid for <strong>5 minutes</strong>.";
            case "it": return "Questo codice è monouso e valido per <strong>5 minuti</strong>.";
            default:   return "Este código es de uso único y tiene una validez de <strong>5 minutos</strong>.";
        }
    }

    private static String getIgnorar(String lang) {
        switch (lang != null ? lang : "es") {
            case "en": return "If you did not attempt to access the system, please ignore this message.";
            case "it": return "Se non hai tentato di accedere al sistema, ignora questo messaggio.";
            default:   return "Si no ha intentado acceder al sistema, por favor ignore este mensaje.";
        }
    }

    private static String getDespedida(String lang) {
        switch (lang != null ? lang : "es") {
            case "en": return "Best regards,<br>Security Team – SaludBoyacá";
            case "it": return "Cordiali saluti,<br>Team Sicurezza – SaludBoyacá";
            default:   return "Atentamente,<br>Equipo de Seguridad – Salud Boyacá";
        }
    }

    private static String getLabelCodigo(String lang) {
        switch (lang != null ? lang : "es") {
            case "en": return "VERIFICATION CODE";
            case "it": return "CODICE DI VERIFICA";
            default:   return "CÓDIGO DE VERIFICACIÓN";
        }
    }

    private static String getLabelExpira(String lang) {
        switch (lang != null ? lang : "es") {
            case "en": return "Expires in 5 minutes";
            case "it": return "Scade in 5 minuti";
            default:   return "Expira en 5 minutos";
        }
    }

    public static String generarOTP() {
        SecureRandom rnd = new SecureRandom();
        StringBuilder sb = new StringBuilder(OTP_LONGITUD);
        for (int i = 0; i < OTP_LONGITUD; i++) {
            sb.append(rnd.nextInt(10));
        }
        return sb.toString();
    }

    public static void enviarOTPIngreso(String destinatario, String codigoOTP) throws MessagingException {
        enviarOTPIngreso(destinatario, codigoOTP, "es");
    }

    public static void enviarOTPIngreso(String destinatario, String codigoOTP, String lang)
            throws MessagingException {

        Properties props = new Properties();
        props.put("mail.smtp.host",              SMTP_HOST);
        props.put("mail.smtp.port",              SMTP_PORT);
        props.put("mail.smtp.auth",              "true");
        props.put("mail.smtp.starttls.enable",   "true");
        props.put("mail.smtp.ssl.protocols",     "TLSv1.2");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.ssl.trust",         "smtp.gmail.com");

        Session mailSession = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_REMIT, EMAIL_PASS);
            }
        });

        try {
            Message mensaje = new MimeMessage(mailSession);
            mensaje.setFrom(new InternetAddress(EMAIL_REMIT, "Seguridad Salud Boyacá"));
            mensaje.setRecipient(Message.RecipientType.TO, new InternetAddress(destinatario));
            mensaje.setSubject(getAsunto(lang));

            String html = buildHtmlEmail(codigoOTP, lang);
            mensaje.setContent(html, "text/html; charset=UTF-8");

            Transport.send(mensaje);
        } catch (Exception e) {
            throw new MessagingException("Error al enviar el correo de acceso: " + e.getMessage());
        }
    }

    private static String buildHtmlEmail(String codigo, String lang) {
        String[] digits = codigo.split("");
        StringBuilder digitCells = new StringBuilder();
        for (String d : digits) {
            digitCells.append(
                "<td style=\"padding:0 5px;\">" +
                "<div style=\"" +
                    "width:42px;height:52px;" +
                    "background:#f0f7ff;" +
                    "border:2px solid #2E86C1;" +
                    "border-radius:10px;" +
                    "display:flex;align-items:center;justify-content:center;" +
                    "font-size:26px;font-weight:700;" +
                    "color:#1a3a5c;" +
                    "font-family:'Courier New',monospace;" +
                    "text-align:center;" +
                    "line-height:52px;" +
                "\">" + d + "</div>" +
                "</td>"
            );
        }

        return "<!DOCTYPE html>" +
        "<html lang='" + (lang != null ? lang : "es") + "'>" +
        "<head><meta charset='UTF-8'><meta name='viewport' content='width=device-width,initial-scale=1'></head>" +
        "<body style='margin:0;padding:0;background:#edf2f7;font-family:\"DM Sans\",Arial,sans-serif;'>" +

        "<table width='100%' cellpadding='0' cellspacing='0' style='background:#edf2f7;padding:40px 0;'>" +
        "<tr><td align='center'>" +

        "<table width='560' cellpadding='0' cellspacing='0' style='" +
            "max-width:560px;width:100%;" +
            "background:#ffffff;" +
            "border-radius:24px;" +
            "overflow:hidden;" +
            "box-shadow:0 8px 30px rgba(26,58,92,0.12);" +
        "'>" +

        "<tr><td style='" +
            "background:linear-gradient(135deg,#1a3a5c 0%,#2E86C1 100%);" +
            "padding:36px 40px 28px;" +
            "text-align:center;" +
        "'>" +
            "<div style='" +
                "width:64px;height:64px;" +
                "background:rgba(255,255,255,0.15);" +
                "border-radius:18px;" +
                "margin:0 auto 16px;" +
                "display:flex;align-items:center;justify-content:center;" +
                "font-size:32px;" +
                "border:1.5px solid rgba(255,255,255,0.3);" +
                "line-height:64px;" +
                "text-align:center;" +
            "'>&#128737;</div>" +
            "<h1 style='" +
                "color:#ffffff;margin:0 0 6px;" +
                "font-size:22px;font-weight:700;" +
                "letter-spacing:0.3px;" +
            "'>Salud Boyac&aacute;</h1>" +
            "<p style='color:rgba(255,255,255,0.75);margin:0;font-size:13px;'>" +
                "Sistema de Verificaci&oacute;n Segura" +
            "</p>" +
        "</td></tr>" +

        "<tr><td style='padding:36px 40px 20px;'>" +

            "<p style='color:#475569;font-size:15px;margin:0 0 8px;'>" + getSaludo(lang) + "</p>" +
            "<p style='color:#334155;font-size:15px;margin:0 0 28px;line-height:1.6;'>" +
                getInstruccion(lang) +
            "</p>" +

            "<p style='" +
                "color:#94a3b8;font-size:11px;font-weight:600;" +
                "letter-spacing:1.5px;text-transform:uppercase;" +
                "margin:0 0 12px;text-align:center;" +
            "'>" + getLabelCodigo(lang) + "</p>" +

            "<table cellpadding='0' cellspacing='0' style='margin:0 auto 10px;'>" +
            "<tr>" + digitCells.toString() + "</tr>" +
            "</table>" +

            "<p style='" +
                "color:#94a3b8;font-size:12px;" +
                "text-align:center;margin:0 0 28px;" +
            "'>&#128337; " + getLabelExpira(lang) + "</p>" +

            "<hr style='border:none;border-top:1px solid #e2e8f0;margin:0 0 20px;'/>" +

            "<p style='color:#64748b;font-size:13px;line-height:1.6;margin:0 0 6px;'>" +
                getValidez(lang) +
            "</p>" +
            "<p style='color:#94a3b8;font-size:12px;line-height:1.6;margin:0 0 24px;'>" +
                getIgnorar(lang) +
            "</p>" +

            "<p style='color:#475569;font-size:14px;line-height:1.6;margin:0;'>" +
                getDespedida(lang) +
            "</p>" +

        "</td></tr>" +

        "<tr><td style='" +
            "background:#f8fafc;" +
            "border-top:1px solid #e2e8f0;" +
            "padding:18px 40px;" +
            "text-align:center;" +
        "'>" +
            "<p style='color:#94a3b8;font-size:11px;margin:0;'>" +
                "SENA &middot; CIMM &middot; Regional Boyac&aacute; &middot; 2026" +
            "</p>" +
        "</td></tr>" +

        "</table>" +
        "</td></tr>" +
        "</table>" + 

        "</body></html>";
    }

    public static boolean esValido(String ingresado, String sesion, Long timestamp) {
        if (ingresado == null || sesion == null || timestamp == null) return false;
        return ingresado.equals(sesion) && !estaExpirado(timestamp);
    }

    public static boolean estaExpirado(Long timestamp) {
        if (timestamp == null) return true;
        return (System.currentTimeMillis() - timestamp) > OTP_EXPIRY_MS;
    }
}