package com.proyectoaa.controller;

import com.proyectoaa.dao.Database;
import com.proyectoaa.dao.UserDao;
import com.proyectoaa.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 1. Buscamos al usuario en la base de datos
        UserDao userDao = Database.getJdbi().onDemand(UserDao.class);
        User usuario = userDao.obtenerUsuarioPorEmail(email);

        // 2. Comprobamos si el usuario existe y si la contraseña coincide
        if (usuario != null && usuario.getPassword().equals(password)) {
            // ¡ÉXITO! Creamos una "Sesión" para este usuario
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuario);

            // Lo enviamos a su panel de control
            response.sendRedirect("dashboard.jsp");
        } else {
            // ERROR: Le devolvemos al login marcando un error en la URL
            response.sendRedirect("login.jsp?error=1");
        }
    }
}
