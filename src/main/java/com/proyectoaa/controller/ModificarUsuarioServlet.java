package com.proyectoaa.controller;

import com.proyectoaa.dao.Database;
import com.proyectoaa.dao.UserDao;
import com.proyectoaa.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/modificarUsuario")
public class ModificarUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //Recogemos los datos modificados del formulario
            Integer id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String email = request.getParameter("email");
            String rol = request.getParameter("rol");

            //Rellenamos el objeto User
            User usuarioModificado = new User();
            usuarioModificado.setIdUsuario(id);
            usuarioModificado.setNombre(nombre);
            usuarioModificado.setEmail(email);
            usuarioModificado.setRol(rol);

            // enviamos a la base de datos
            UserDao userDao = Database.getJdbi().onDemand(UserDao.class);
            userDao.modificarUsuario(usuarioModificado);

            //Volvemos a la vista detalle de este mismo usuario
            response.sendRedirect("detalleUsuario?id=" + id);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminUsuarios.jsp?error=modificar");
        }
    }
}