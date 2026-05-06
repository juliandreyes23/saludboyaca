package co.sena.cimm.adso.saludboyaca.servlet;

import co.sena.cimm.adso.saludboyaca.dao.CitaDAO;
import co.sena.cimm.adso.saludboyaca.dao.CitaDAOImpl;
import co.sena.cimm.adso.saludboyaca.dao.PacienteDAO;
import co.sena.cimm.adso.saludboyaca.dao.PacienteDAOImpl;
import co.sena.cimm.adso.saludboyaca.model.Pacientes;
import co.sena.cimm.adso.saludboyaca.model.Citas;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/consulta-cita")
public class ConsultaCitaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String captchaUser = req.getParameter("captcha");
        String captchaReal = (String) req.getSession().getAttribute("captcha_key");
        String documento   = req.getParameter("documento");

        if (captchaReal == null || !captchaReal.equalsIgnoreCase(captchaUser)) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp?error=captcha");
            return;
        }

        PacienteDAO pacienteDAO = new PacienteDAOImpl();
        Pacientes paciente = pacienteDAO.buscarPorDocumento(documento);

        if (paciente != null) {
            CitaDAO citaDAO = new CitaDAOImpl();
            List<Citas> listaCitas = citaDAO.listarPorPaciente(paciente.getId());
            req.setAttribute("paciente", paciente);
            req.setAttribute("resultados", listaCitas);
        } else {
            req.setAttribute("error_mensaje", "No se encontró ningún paciente con el documento: " + documento);
        }

        req.getSession().removeAttribute("captcha_key");

        req.getRequestDispatcher("/views/consultaCita.jsp").forward(req, resp);
    }
}