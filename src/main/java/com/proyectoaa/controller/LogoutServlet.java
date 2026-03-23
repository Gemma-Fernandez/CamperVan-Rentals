package com.proyectoaa.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Recuperamos sesión actual del usuario
        HttpSession session = request.getSession(false);

        // Si usuario tenía sesión abierta,se borran sus datos de la memoria
        if (session != null) {
            session.invalidate();
        }

        //Mandamos de vuelta a la página principal
        response.sendRedirect("index.jsp");
    }
}