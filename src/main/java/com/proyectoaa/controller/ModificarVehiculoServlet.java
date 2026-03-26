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

@WebServlet("/modificarVehiculo")
public class ModificarVehiculoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //Recogemos los datos modificados del formulario
            Integer idVehiculo = Integer.parseInt(request.getParameter("idVehiculo"));
            String modelo = request.getParameter("modelo");
            String matricula = request.getParameter("matricula");
            Integer capacidad = Integer.parseInt(request.getParameter("capacidadPasajeros"));
            Double precio = Double.parseDouble(request.getParameter("precioPorDia"));


            boolean disponible = request.getParameter("disponible") != null;

            //Rellenamos el objeto
            Vehicle v = new Vehicle();
            v.setIdVehiculo(idVehiculo);
            v.setModelo(modelo);
            v.setMatricula(matricula);
            v.setCapacidadPasajeros(capacidad);
            v.setPrecioPorDia(precio);
            v.setDisponible(disponible);

            // se envia a la base de datos
            VehicleDao vehicleDao = Database.getJdbi().onDemand(VehicleDao.class);
            vehicleDao.modificarVehiculo(v);

            //Volvemos a la vista detalle de esta misma furgoneta
            response.sendRedirect("detalleVehiculo?id=" + idVehiculo);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=modificar");
        }
    }
}
