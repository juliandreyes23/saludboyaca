package co.sena.cimm.adso.saludboyaca.util;

import java.io.IOException;
import java.util.Locale;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import javax.servlet.jsp.jstl.core.Config;

@WebFilter(filterName = "LocaleFilter", urlPatterns = {"/*"})
public class LocaleFilter implements Filter {

    private static final String LANG_DEFAULT = "es";

    @Override
    public void init(FilterConfig fc) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(true);

        String lang = req.getParameter("lang");
        
        if (lang != null && (lang.equals("es") || lang.equals("en") || lang.equals("it"))) {
            session.setAttribute("lang", lang);
        }

        String currentLang = (String) session.getAttribute("lang");
        if (currentLang == null) {
            currentLang = LANG_DEFAULT;
            session.setAttribute("lang", currentLang);
        }

        Locale locale = new Locale(currentLang);
        Config.set(session, Config.FMT_LOCALE, locale);
        
        res.setLocale(locale);
        res.setCharacterEncoding("UTF-8");

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}