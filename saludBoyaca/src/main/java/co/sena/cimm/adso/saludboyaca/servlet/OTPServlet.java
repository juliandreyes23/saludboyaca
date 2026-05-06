package co.sena.cimm.adso.saludboyaca.servlet;

import co.sena.cimm.adso.saludboyaca.util.OTPService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/otp")
public class OTPServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("otpGenerado") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String email = (String) session.getAttribute("otpEmail");
        req.setAttribute("emailMasked", enmascararEmail(email));
        req.getRequestDispatcher("/views/otp-verificacion.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String codigoIngresado = req.getParameter("otpCodigo");
        String codigoGenerado  = (String) session.getAttribute("otpGenerado");
        Long   timestamp       = (Long)   session.getAttribute("otpTimestamp");

        if (OTPService.esValido(codigoIngresado, codigoGenerado, timestamp)) {
            session.removeAttribute("otpGenerado");
            session.removeAttribute("otpTimestamp");
            session.removeAttribute("otpEmail");
            resp.sendRedirect(req.getContextPath() + "/dashboard");

        } else {
            session.removeAttribute("otpGenerado");
            session.removeAttribute("otpTimestamp");
        

            String lang = (String) session.getAttribute("lang");
            if (lang == null) lang = "es";

            java.util.ResourceBundle rb = java.util.ResourceBundle.getBundle(
                    "messages", new java.util.Locale(lang));

            boolean expiredByTime = OTPService.estaExpirado(timestamp);
            String mensajeError = expiredByTime
                    ? rb.getString("otp.expired") 
                    : rb.getString("otp.error");    

            req.setAttribute("error", mensajeError);

            String email = (String) session.getAttribute("otpEmail");
            req.setAttribute("emailMasked", enmascararEmail(email));

            req.getRequestDispatcher("/views/otp-verificacion.jsp").forward(req, resp);
        }
    }

    private String enmascararEmail(String email) {
        if (email == null || !email.contains("@")) return "***";
        String[] partes = email.split("@");
        String local = partes[0];
        if (local.length() <= 3) return local + "***@" + partes[1];
        return local.substring(0, 3) + "***@" + partes[1];
    }
}