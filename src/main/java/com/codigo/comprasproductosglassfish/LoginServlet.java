package com.codigo.comprasproductosglassfish;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");

        if (!"admin".equals(user) || !"1234".equals(pass)) {
            request.setAttribute("error", "Usuario o contraseña incorrectos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("usuario", user);

        // Verificar si hay una página anterior guardada
        String paginaAnterior = (String) session.getAttribute("paginaAnterior");
        if (paginaAnterior != null) {
            session.removeAttribute("paginaAnterior");
            response.sendRedirect(paginaAnterior);
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}

// ALTERNATIVA: Si quieres lanzar una excepción personalizada
class LoginServletAlternativa extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");

        if (!"admin".equals(user) || !"1234".equals(pass)) {
            // LÍNEA CRÍTICA ALTERNATIVA: Lanzar excepción
            throw new ServletException("Usuario o contraseña incorrectos");
        }

        HttpSession session = request.getSession();
        session.setAttribute("usuario", user);
        response.sendRedirect("index.jsp");
    }
}