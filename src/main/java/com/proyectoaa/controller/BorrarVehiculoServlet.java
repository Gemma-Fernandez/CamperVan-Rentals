package com.proyectoaa.controller;

import com.proyectoaa.dao.Database;
import com.proyectoaa.dao.VehicleDao;
import com.proyectoaa.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/borrarVehiculo")
public class BorrarVehiculoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Comprobamos que es el admin
        HttpSession session = request.getSession();
        User usuario = (User) session.getAttribute("usuarioLogueado");

        if (usuario == null || !"ADMIN".equals(usuario.getRol())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            //Cogemos el ID de la furgoneta que queremos borrar
            Integer id = Integer.parseInt(request.getParameter("id"));

            //decimos a la Base de Datos que elimine
            VehicleDao vehicleDao = Database.getJdbi().onDemand(VehicleDao.class);
            vehicleDao.borrarVehiculo(id);

            //Volvemos al panel del Admin con una marca de éxito
            response.sendRedirect("adminDashboard.jsp?borradoOk=true");

        } catch (Exception e) {
            // Si hay un error
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=borrado");
        }
    }
}