<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${not empty sessionScope.lang ? sessionScope.lang : 'es'}">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><fmt:message key="nav.dashboard"/></title>

        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&family=Sora:wght@600;700;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

        <style>
            :root {
                --sidebar-w: 260px;
                --navy: #0f2744;
                --blue: #1d5fa8;
                --blue-light: #e8f2fd;
                --teal: #0d9488;
                --teal-light: #e6f7f5;
                --indigo: #6366f1;
                --indigo-light: #eef2ff;
                --bg: #f4f7fb;
                --surface: #ffffff;
                --border: #e4eaf2;
                --text: #1e293b;
                --muted: #64748b;
                --sidebar-fg: rgba(255,255,255,0.72);
                --sidebar-hover: rgba(255,255,255,0.10);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Plus Jakarta Sans', sans-serif;
                background: var(--bg);
                color: var(--text);
                display: flex;
                min-height: 100vh;
            }

            .sidebar {
                width: var(--sidebar-w);
                background: var(--navy);
                color: white;
                display: flex;
                flex-direction: column;
                position: fixed;
                height: 100vh;
                z-index: 1000;
            }

            .sidebar-brand {
                padding: 24px;
                display: flex;
                align-items: center;
                gap: 12px;
                background: rgba(0,0,0,0.1);
            }

            .brand-icon {
                width: 40px;
                height: 40px;
                background: var(--blue);
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.2rem;
            }

            .brand-text h1 {
                font-family: 'Sora', sans-serif;
                font-size: 1.1rem;
            }
            .brand-text span {
                font-size: 0.7rem;
                color: var(--sidebar-fg);
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .sidebar-user {
                padding: 20px 24px;
                border-bottom: 1px solid rgba(255,255,255,0.05);
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .user-avatar {
                width: 44px;
                height: 44px;
                background: linear-gradient(135deg, var(--blue), var(--teal));
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
                color: white;
                border: 2px solid rgba(255,255,255,0.2);
            }

            .user-name {
                font-size: 0.9rem;
                font-weight: 600;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            .user-role {
                font-size: 0.75rem;
                color: var(--sidebar-fg);
            }

            .sidebar-nav {
                padding: 20px 12px;
                flex-grow: 1;
            }
            .nav-label {
                padding: 0 12px 10px;
                font-size: 0.7rem;
                font-weight: 700;
                color: rgba(255,255,255,0.3);
                text-transform: uppercase;
            }
            .nav-item {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 12px;
                color: var(--sidebar-fg);
                text-decoration: none;
                border-radius: 10px;
                transition: 0.2s;
                margin-bottom: 4px;
                font-size: 0.9rem;
            }
            .nav-item i {
                font-size: 1.1rem;
            }
            .nav-item:hover, .nav-item.active {
                background: var(--sidebar-hover);
                color: white;
            }
            .nav-item.active {
                background: var(--blue);
                color: white;
            }

            .sidebar-footer {
                padding: 20px;
                border-top: 1px solid rgba(255,255,255,0.05);
            }
            .logout-link {
                display: flex;
                align-items: center;
                gap: 10px;
                color: #ff6b6b;
                text-decoration: none;
                font-size: 0.9rem;
                font-weight: 600;
            }

            .main-wrapper {
                margin-left: var(--sidebar-w);
                flex-grow: 1;
                min-width: 0;
            }

            .topbar {
                height: 70px;
                background: var(--surface);
                border-bottom: 1px solid var(--border);
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 32px;
                position: sticky;
                top: 0;
                z-index: 900;
            }

            .topbar-title {
                font-weight: 700;
                color: var(--navy);
                font-size: 1.1rem;
            }

            .page-content {
                padding: 32px;
                max-width: 1200px;
                margin: 0 auto;
            }

            .welcome-banner {
                padding: 40px;
                border-radius: 24px;
                color: white;
                margin-bottom: 32px;
                position: relative;
                overflow: hidden;
                box-shadow: 0 20px 40px rgba(15, 39, 68, 0.1);
            }
            .bg-medico {
                background: linear-gradient(135deg, #1d5fa8 0%, #2E86C1 100%);
            }
            .bg-admin {
                background: linear-gradient(135deg, #0f2744 0%, #1d5fa8 100%);
            }
            .bg-enfermero {
                background: linear-gradient(135deg, #0d9488 0%, #14b8a6 100%);
            }
            .bg-default {
                background: linear-gradient(135deg, #64748b 0%, #94a3b8 100%);
            }

            .banner-tag {
                background: rgba(255,255,255,0.15);
                padding: 6px 14px;
                border-radius: 30px;
                font-size: 0.75rem;
                font-weight: 700;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                margin-bottom: 16px;
                backdrop-filter: blur(4px);
                border: 1px solid rgba(255,255,255,0.1);
            }

            .banner-title {
                font-family: 'Sora', sans-serif;
                font-size: 2rem;
                margin-bottom: 8px;
            }
            .banner-sub {
                color: rgba(255,255,255,0.8);
                font-size: 1rem;
            }

            .section-title {
                font-size: 1.1rem;
                font-weight: 800;
                color: var(--navy);
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .cards-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 24px;
            }

            .stat-card {
                background: var(--surface);
                border-radius: 20px;
                padding: 24px;
                border: 1px solid var(--border);
                text-decoration: none;
                transition: 0.3s;
            }
            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 30px rgba(0,0,0,0.05);
                border-color: var(--blue);
            }

            .card-inner {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
            }
            .card-label {
                color: var(--muted);
                font-size: 0.85rem;
                font-weight: 600;
                margin-bottom: 4px;
            }
            .card-value {
                color: var(--navy);
                font-size: 1.4rem;
                font-weight: 800;
            }
            .card-icon {
                width: 50px;
                height: 50px;
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
            }

            footer {
                text-align: center;
                padding: 40px;
                color: var(--muted);
                font-size: 0.85rem;
            }
        </style>
    </head>
    <body>

        <aside class="sidebar">
            <div class="sidebar-brand">
                <div class="brand-icon"><i class="bi bi-heart-pulse-fill"></i></div>
                <div class="brand-text">
                    <h1><fmt:message key="app.logo"/> </h1>
                    <span><fmt:message key="footer.sistema"/></span>
                </div>
            </div>

            <div class="sidebar-user">
                <div class="user-avatar">
                    <c:choose>
                        <c:when test="${not empty usuarioPendiente.nombres}">
                            ${fn:substring(usuarioPendiente.nombres, 0, 1)}
                        </c:when>
                        <c:otherwise><i class="bi bi-person"></i></c:otherwise>
                    </c:choose>
                </div>
                <div>
                    <div class="user-name">${usuarioPendiente.nombres}</div>
                    <div class="user-role">

                        <fmt:message key="role.${fn:toLowerCase(usuarioPendiente.rol)}"/>
                    </div>
                </div>
            </div>

            <nav class="sidebar-nav">
                <div class="nav-label"><fmt:message key="nav.administrar"/></div>

                <a href="${pageContext.request.contextPath}/dashboard" class="nav-item active">
                    <i class="bi bi-grid-1x2-fill"></i> <fmt:message key="nav.dashboard"/>
                </a>

                <a href="${pageContext.request.contextPath}/pacientes" class="nav-item">
                    <i class="bi bi-people-fill"></i> <fmt:message key="nav.pacientes"/>
                </a>

                <a href="${pageContext.request.contextPath}/citas" class="nav-item">
                    <i class="bi bi-calendar-check-fill"></i> <fmt:message key="nav.gestionCitas"/>
                </a>


                <c:if test="${usuarioPendiente.rol == 'RECEPCIONISTA' || usuarioPendiente.rol == 'MEDICO'}">
                    <a href="${pageContext.request.contextPath}/horarios" class="nav-item">
                        <i class="bi bi-clock-fill"></i> <fmt:message key="nav.horarios"/>
                    </a>
                </c:if>
            </nav>

            <div class="sidebar-footer">
                <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                    <i class="bi bi-box-arrow-left"></i> <fmt:message key="nav.salir"/>
                </a>
            </div>
        </aside>

        <div class="main-wrapper">
            <header class="topbar">
                <div class="topbar-title"><fmt:message key="nav.dashboard"/> </div>
                <div class="topbar-right">
                    <span id="currentDate" style="color: var(--muted); font-size: 0.9rem;"></span>
                </div>
            </header>

            <main class="page-content">
                <div class="welcome-banner 
                     <c:choose>
                         <c:when test="${usuarioPendiente.rol == 'MEDICO'}">bg-medico</c:when>
                         <c:when test="${usuarioPendiente.rol == 'ADMIN'}">bg-admin</c:when>
                         <c:when test="${usuarioPendiente.rol == 'ENFERMERO'}">bg-enfermero</c:when>
                         <c:otherwise>bg-default</c:otherwise>
                     </c:choose>">

                    <div class="banner-tag">
                        <i class="bi bi-shield-check"></i> 
                        <fmt:message key="dashboard.rolActivo"/>: 
                        <fmt:message key="role.${fn:toLowerCase(usuarioPendiente.rol)}"/>
                    </div>
                    <div class="banner-title">
                        <fmt:message key="dashboard.bienvenida">
                            <fmt:param value="${usuarioPendiente.nombres}"/>
                        </fmt:message>
                    </div>
                    <div class="banner-sub">
                        <c:choose>
                            <c:when test="${usuarioPendiente.rol == 'MEDICO'}"><fmt:message key="cita.estado.programada"/></c:when>
                            <c:otherwise><fmt:message key="nav.horarios.desc"/></c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="section-title"><fmt:message key="nav.consultar"/></div>
                <div class="cards-grid">
                    <a href="${pageContext.request.contextPath}/citas" class="stat-card">
                        <div class="card-inner">
                            <div>
                                <div class="card-label"><fmt:message key="dashboard.citasHoy"/></div>
                                <div class="card-value" style="color:var(--blue)"><fmt:message key="nav.citas"/></div>
                            </div>
                            <div class="card-icon" style="background:var(--blue-light); color:var(--blue)">
                                <i class="bi bi-calendar-date"></i>
                            </div>
                        </div>
                    </a>

                    <a href="${pageContext.request.contextPath}/pacientes" class="stat-card">
                        <div class="card-inner">
                            <div>
                                <div class="card-label"><fmt:message key="paciente.ver"/></div>
                                <div class="card-value" style="color:var(--teal)"><fmt:message key="nav.pacientes"/></div>
                            </div>
                            <div class="card-icon" style="background:var(--teal-light); color:var(--teal)">
                                <i class="bi bi-person-lines-fill"></i>
                            </div>
                        </div>
                    </a>

                    <c:if test="${usuarioPendiente.rol == 'RECEPCIONISTA' || usuarioPendiente.rol == 'MEDICO'}">
                        <a href="${pageContext.request.contextPath}/horarios" class="stat-card">
                            <div class="card-inner">
                                <div>
                                    <div class="card-label"><fmt:message key="nav.horarios.desc"/></div>
                                    <div class="card-value" style="color:var(--indigo)"><fmt:message key="nav.horarios"/></div>
                                </div>
                                <div class="card-icon" style="background:var(--indigo-light); color:var(--indigo)">
                                    <i class="bi bi-clock-history"></i>
                                </div>
                            </div>
                        </a>
                    </c:if>
                </div>
            </main>

            <footer>
                <fmt:message key="app.footer"/> &mdash; <fmt:message key="app.institucion"/>
            </footer>
        </div>

        <script>
            const dateElement = document.getElementById('currentDate');
            const lang = document.documentElement.lang || 'es';
            const options = {weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'};
            dateElement.textContent = new Date().toLocaleDateString(lang, options);
        </script>
    </body>
</html>