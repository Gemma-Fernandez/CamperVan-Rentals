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
import java.time.LocalDate;

// Esta anotación le dice a Tomcat: "Si alguien pide la ruta /registro, llámame a mí"
@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Extraemos los datos del formulario
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        //Creamos el objeto User y lo rellenamos
        User nuevoUsuario = new User();
        nuevoUsuario.setNombre(nombre);
        nuevoUsuario.setEmail(email);
        nuevoUsuario.setPassword(password); // Más adelante le pondremos seguridad
        nuevoUsuario.setRol("CLIENTE");
        nuevoUsuario.setSaldoMonedero(0.0);
        nuevoUsuario.setFechaRegistro(LocalDate.now());
        nuevoUsuario.setCuentaActiva(true);

        try {
            //Conectamos con la base de datos a través del DAO
            UserDao userDao = Database.getJdbi().onDemand(UserDao.class);
            boolean insertado = userDao.registrarUsuario(nuevoUsuario);

            // Mostramos el resultado al usuario
            response.setContentType("text/html;charset=UTF-8");
            if (insertado) {
                response.getWriter().println("<div style='text-align:center; margin-top:50px;'>");
                response.getWriter().println("<h1 style='color:green;'>¡Registro completado!</h1>");
                response.getWriter().println("<p>Bienvenido/a, " + nombre + ". Ya estás en nuestra base de datos.</p>");
                response.getWriter().println("<a href='index.jsp'>Volver al inicio</a>");
                response.getWriter().println("</div>");
            } else {
                response.getWriter().println("<h1 style='color:red;'>Error: No se pudo guardar el usuario.</h1>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h1>Error crítico en el servidor</h1>");
        }
    }
}