package co.sena.cimm.adso.saludboyaca.util;

import co.sena.cimm.adso.saludboyaca.model.Usuarios;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {
    "/dashboard",
    "/citas",
    "/citas/*",
    "/pacientes",
    "/pacientes/*",
    "/horarios",
    "/horarios/*"
})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(javax.servlet.ServletRequest servletRequest,
                         javax.servlet.ServletResponse servletResponse,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req  = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;

        HttpSession session = req.getSession(false);
        Usuarios usuario = (session != null)
                ? (Usuarios) session.getAttribute("usuarioPendiente") : null;

        if (usuario == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String rol         = usuario.getRol();
        String metodo      = req.getMethod().toUpperCase();
        String servletPath = req.getServletPath();
        String accion      = req.getParameter("accion");

        if (servletPath.startsWith("/pacientes")) {

            if (rol.equals("ENFERMERO")) {
                boolean esEscritura = metodo.equals("POST")
                        || "nuevo".equals(accion)
                        || "editar".equals(accion)
                        || "eliminar".equals(accion);
                if (esEscritura) {
                    denegar(req, resp, "El Enfermero solo tiene acceso de lectura a pacientes.");
                    return;
                }
            }

            if (!rol.equals("RECEPCIONISTA") && !rol.equals("ADMIN")
                    && !rol.equals("MEDICO") && !rol.equals("ENFERMERO")) {
                denegar(req, resp, "No tienes permiso para acceder al módulo de pacientes.");
                return;
            }
        }

        if (servletPath.startsWith("/horarios")) {
            if (rol.equals("ENFERMERO")) {
                denegar(req, resp, "No tienes permiso para gestionar horarios.");
                return;
            }
        }

        if (servletPath.equals("/citas") || servletPath.startsWith("/citas/")) {

            if (rol.equals("ENFERMERO")) {
                boolean esEscritura = metodo.equals("POST")
                        || "nuevo".equals(accion)
                        || "editar".equals(accion)
                        || "eliminar".equals(accion);
                if (esEscritura) {
                    denegar(req, resp, "El Enfermero solo puede consultar el listado y detalle de citas.");
                    return;
                }
            }

            if (rol.equals("MEDICO")) {
                if ("nuevo".equals(accion)) {
                    denegar(req, resp, "La programación de nuevas citas es tarea de Recepción.");
                    return;
                }
                if (metodo.equals("POST") && !"actualizar".equals(accion)) {
                    denegar(req, resp, "No tienes permisos para crear citas nuevas.");
                    return;
                }
            }
        }

        chain.doFilter(req, resp);
    }

    @Override
    public void destroy() {}

    private void denegar(HttpServletRequest req, HttpServletResponse resp, String msgKey)
            throws IOException, ServletException {
        resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
        req.setAttribute("errorKey", msgKey);
        req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
    }
}