package co.sena.cimm.adso.saludboyaca.servlet;

import co.sena.cimm.adso.saludboyaca.dao.CitaDAO;
import co.sena.cimm.adso.saludboyaca.dao.CitaDAOImpl;
import co.sena.cimm.adso.saludboyaca.model.Citas;
import co.sena.cimm.adso.saludboyaca.model.Usuarios;

import java.io.IOException;
import java.sql.Time;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/citas")
public class CitaServlet extends HttpServlet {

    private final CitaDAO dao = new CitaDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        HttpSession session = req.getSession();
        Usuarios userLogueado = (Usuarios) session.getAttribute("usuarioPendiente");

        if (userLogueado == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        switch (accion) {
            case "listar":
                if ("RECEPCIONISTA".equals(userLogueado.getRol()) || "ENFERMERO".equals(userLogueado.getRol())) {
                    req.setAttribute("listaCitas", dao.listarTodas());
                } else {
                    req.setAttribute("listaCitas", dao.listarPorMedico(userLogueado.getId()));
                }
                req.getRequestDispatcher("/views/Citas/lista.jsp").forward(req, resp);
                break;

            case "nuevo":
                if (!"RECEPCIONISTA".equals(userLogueado.getRol())) {
                    resp.sendRedirect("citas?accion=listar");
                    return;
                }
                req.setAttribute("cita", null);
                req.getRequestDispatcher("/views/Citas/formulario.jsp").forward(req, resp);
                break;

            case "editar":
                int idEdit = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("cita", dao.buscarPorId(idEdit));
                req.getRequestDispatcher("/views/Citas/formulario.jsp").forward(req, resp);
                break;

            case "eliminar":
                if ("RECEPCIONISTA".equals(userLogueado.getRol())) {
                    dao.eliminar(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect("citas?accion=listar&msg=eliminado");
                } else {
                    resp.sendRedirect("citas?accion=listar?error=sin_permiso");
                }
                break;

            case "detalle":
                int idDetalle = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("cita", dao.buscarPorId(idDetalle));
                req.getRequestDispatcher("/views/Citas/detalle.jsp").forward(req, resp);
                break;

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Usuarios userLogueado = (Usuarios) session.getAttribute("usuarioPendiente");

        String accion = req.getParameter("accion");
        Citas c = new Citas();

        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            c.setId(Integer.parseInt(idStr));
        }

        c.setId_paciente(Integer.parseInt(req.getParameter("id_paciente")));
        c.setId_medico(Integer.parseInt(req.getParameter("id_medico")));
        c.setId_especialidad(Integer.parseInt(req.getParameter("id_especialidad")));
        c.setMotivo(req.getParameter("motivo"));
        c.setObservaciones(req.getParameter("observaciones"));
        c.setEstado(req.getParameter("estado"));

        try {
            String fechaInput = req.getParameter("fecha_cita");
            if (fechaInput != null && !fechaInput.isEmpty()) {
                LocalDate date = LocalDate.parse(fechaInput);
                c.setFecha_cita(date.atStartOfDay());
            }

            String horaInput = req.getParameter("hora_cita");
            if (horaInput != null && !horaInput.isEmpty()) {
                c.setHora_cita(Time.valueOf(horaInput + ":00"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        c.setId_registrado_por(userLogueado.getId());

        if ("actualizar".equals(accion)) {
            dao.actualizar(c);
        } else {
            dao.insertar(c);
        }
        resp.sendRedirect("citas?accion=listar");
    }
}
