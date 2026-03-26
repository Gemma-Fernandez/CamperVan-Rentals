package com.proyectoaa.controller;


import com.proyectoaa.dao.Database;
import com.proyectoaa.dao.VehicleDao;
import com.proyectoaa.model.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


    @WebServlet("/detalleVehiculo")
    public class DetalleVehiculoServlet extends HttpServlet {

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            try {
                // Cogemos el ID de la URL (ej: /detalleVehiculo?id=3)
                Integer id = Integer.parseInt(request.getParameter("id"));

                // Buscamos el vehículo en la base de datos
                VehicleDao vehicleDao = Database.getJdbi().onDemand(VehicleDao.class);
                Vehicle vehiculo = vehicleDao.obtenerPorId(id);

                if (vehiculo != null) {
                    // Lo guardamos y mandamos a la pantalla de detalle
                    request.setAttribute("vehiculo", vehiculo);
                    request.getRequestDispatcher("detalleVehiculo.jsp").forward(request, response);
                } else {
                    response.sendRedirect("dashboard?error=notfound");
                }
            } catch (Exception e) {
                response.sendRedirect("dashboard?error=id");
            }
        }
    }

