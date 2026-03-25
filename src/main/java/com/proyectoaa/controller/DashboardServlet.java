package com.proyectoaa.controller;

import com.proyectoaa.dao.Database;
import com.proyectoaa.dao.ReservationDao;
import com.proyectoaa.dao.VehicleDao;
import com.proyectoaa.model.Reservation;
import com.proyectoaa.model.User;
import com.proyectoaa.model.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Comprobamos si el usuario ha iniciado sesión
        HttpSession session = request.getSession();
        User usuario = (User) session.getAttribute("usuarioLogueado");

        if (usuario == null) {
            // Si no logueado, lo echamos
            response.sendRedirect("login.jsp");
            return;
        }

        //Si está logueado, buscamos vehículos disponibles
        VehicleDao vehicleDao = Database.getJdbi().onDemand(VehicleDao.class);
        List<Vehicle> listaVehiculos = vehicleDao.obtenerDisponibles();
        //Guardamos la lista para que la web pueda leerla
        request.setAttribute("vehiculos", listaVehiculos);

        // Buscamos las reservas del usuario
        ReservationDao reservationDao = Database.getJdbi().onDemand(ReservationDao.class);
        List<Reservation> misReservas = reservationDao.obtenerPorUsuario(usuario.getIdUsuario());
        request.setAttribute("misReservas", misReservas);

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
