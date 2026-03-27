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

@WebServlet("/borrarUsuario")
public class BorrarUsuarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Solo admin puede borrar
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("usuarioLogueado");

        if (admin == null || !"ADMIN".equals(admin.getRol())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            //Cogemos el ID del usuario a eliminar
            Integer idUsuario = Integer.parseInt(request.getParameter("id"));

            //Evitar que el Admin se borre a sí mismo por error
            if (idUsuario.equals(admin.getIdUsuario())) {
                response.sendRedirect("adminUsuarios.jsp?error=propiaCuenta");
                return;
            }

            //Decimos a la Base de Datos que elimine
            UserDao userDao = Database.getJdbi().onDemand(UserDao.class);
            userDao.borrarUsuario(idUsuario);

            //Volvemos al directorio con éxito
            response.sendRedirect("adminUsuarios.jsp?borradoOk=true");

        } catch (Exception e) {
            //Si el usuario tiene reservas, MariaDB bloqueará el borrado
            e.printStackTrace();
            response.sendRedirect("adminUsuarios.jsp?error=borrado");
        }
    }
}
