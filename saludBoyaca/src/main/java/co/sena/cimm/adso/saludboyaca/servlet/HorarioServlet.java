package co.sena.cimm.adso.saludboyaca.servlet;

import co.sena.cimm.adso.saludboyaca.dao.HorarioDAO;
import co.sena.cimm.adso.saludboyaca.dao.HorarioDAOImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/horarios")
public class HorarioServlet extends HttpServlet {

    private HorarioDAO dao = new HorarioDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        try {
            switch (accion) {
                case "listar":
                    req.setAttribute("listaHorarios", dao.listarTodos());
                    req.getRequestDispatcher("/views/horarios/lista.jsp").forward(req, resp);
                    break;

                case "consultarDisponibles":
                    String fecha = req.getParameter("fecha");
                    String idMedStr = req.getParameter("idMedico");

                    if (idMedStr != null && fecha != null) {
                        int idMedico = Integer.parseInt(idMedStr);
                        req.setAttribute("horasDisponibles", dao.obtenerHorasDisponibles(idMedico, fecha));
                        req.getRequestDispatcher("/views/citas/bloques_horarios.jsp").forward(req, resp);
                    }
                    break;

                default:
                    resp.sendRedirect("horarios?accion=listar");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Error: " + e.getMessage());
        }
    }
}
