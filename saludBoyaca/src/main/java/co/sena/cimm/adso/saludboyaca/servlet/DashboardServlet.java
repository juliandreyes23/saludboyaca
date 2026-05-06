package co.sena.cimm.adso.saludboyaca.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("usuarioPendiente") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // usuarioPendiente ya vive en la sesión, el JSP lo accede con ${usuarioPendiente}
        req.getRequestDispatcher("/views/dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}