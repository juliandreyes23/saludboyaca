package co.sena.cimm.adso.saludboyaca.servlet;

import co.sena.cimm.adso.saludboyaca.dao.PacienteDAO;
import co.sena.cimm.adso.saludboyaca.dao.PacienteDAOImpl;
import co.sena.cimm.adso.saludboyaca.model.Pacientes;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet(urlPatterns = {"/pacientes", "/pacientes/*"})
public class PacienteServlet extends HttpServlet {

    private final PacienteDAO dao = new PacienteDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo();

        if (path == null || path.equals("/")) {
            req.setAttribute("listaPacientes", dao.listarTodos());
            req.getRequestDispatcher("/views/Pacientes/lista.jsp").forward(req, resp);

        } else if (path.equals("/nuevo")) {
            req.setAttribute("listaEps", dao.listarEps());
            req.setAttribute("paciente", new Pacientes());
            req.getRequestDispatcher("/views/Pacientes/formulario.jsp").forward(req, resp);

        } else if (path.equals("/eliminar")) {
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.isBlank()) {
                try {
                    int id = Integer.parseInt(idParam);
                    boolean eliminado = dao.eliminar(id);
                    System.out.println("[PacienteServlet] Eliminar id=" + id + " resultado=" + eliminado);
                } catch (Exception e) {
                    System.err.println("[PacienteServlet] Error al eliminar: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/pacientes?msg=eliminado");
        } else {
            resp.sendRedirect(req.getContextPath() + "/pacientes");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String idParam = req.getParameter("id");
        String nombres = req.getParameter("nombres");
        String apellidos = req.getParameter("apellidos");
        String documento = req.getParameter("documento");
        String eps = req.getParameter("eps");
        String telefono = req.getParameter("telefono");
        String email = req.getParameter("email");
        String veredaBarrio = req.getParameter("vereda_barrio");
        String fechaParam = req.getParameter("fecha_nacimiento");

        Pacientes p = new Pacientes();
        p.setNombres(nombres);
        p.setApellidos(apellidos);
        p.setDocumento(documento);
        p.setEps(eps);
        p.setTelefono(telefono);
        p.setEmail(email);
        p.setVeredaBarrio(veredaBarrio);

        if (fechaParam != null && !fechaParam.isBlank()) {
            p.setFechaNacimiento(LocalDate.parse(fechaParam));
        }

        if (idParam != null && !idParam.isBlank() && !idParam.equals("0")) {
            p.setId(Integer.parseInt(idParam));
            dao.actualizar(p);
            resp.sendRedirect(req.getContextPath() + "/pacientes?msg=editado");
        } else {
            dao.insertar(p);
            resp.sendRedirect(req.getContextPath() + "/pacientes?msg=creado");
        }
    }
}
