package co.sena.cimm.adso.saludboyaca.servlet;

import co.sena.cimm.adso.saludboyaca.dao.UsuarioDAO;
import co.sena.cimm.adso.saludboyaca.dao.UsuarioDAOImpl;
import co.sena.cimm.adso.saludboyaca.model.Usuarios;
import co.sena.cimm.adso.saludboyaca.util.OTPService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String userParam = request.getParameter("username") != null
                ? request.getParameter("username").trim() : "";
        String passParam = request.getParameter("password") != null
                ? request.getParameter("password").trim() : "";

        UsuarioDAO dao = new UsuarioDAOImpl();
        Usuarios usuario = dao.buscarPorUsername(userParam);

        if (usuario != null) {
            System.out.println("Login: [" + userParam + "] DB_Pass: ["
                    + usuario.getPassword() + "] vs Input_Pass: [" + passParam + "]");
        } else {
            System.out.println("Usuario no encontrado en la DB: [" + userParam + "]");
        }

        if (usuario != null && usuario.getPassword().trim().equals(passParam)) {

            if (usuario.getActivo() != 1) {
                response.sendRedirect(request.getContextPath() + "/login?error=inactive");
                return;
            }

            String otp = OTPService.generarOTP();

            try {
                OTPService.enviarOTPIngreso(usuario.getEmail(), otp);

                HttpSession session = request.getSession();
                session.setAttribute("otpGenerado", otp);                
                session.setAttribute("otpTimestamp", System.currentTimeMillis());
                session.setAttribute("usuarioPendiente", usuario);        

                response.sendRedirect(request.getContextPath() + "/otp");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/login?error=mail");
            }

        } else {
            response.sendRedirect(request.getContextPath() + "/login?error=auth");
        }
    }
}