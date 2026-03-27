package com.proyectoaa.controller;

import com.proyectoaa.dao.Database;
import com.proyectoaa.dao.ReservationDao;
import com.proyectoaa.model.Reservation;
import com.proyectoaa.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cancelarMiReserva")
public class CancelarMiReservaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //comprobamos que esté logueado
        HttpSession session = request.getSession();
        User cliente = (User) session.getAttribute("usuarioLogueado");

        if (cliente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Integer idReserva = Integer.parseInt(request.getParameter("id"));

            //Buscamos la reserva ANTES de borrarla
            ReservationDao reservationDao = Database.getJdbi().onDemand(ReservationDao.class);
            Reservation reservaCancelada = reservationDao.obtenerPorId(idReserva);

            if (reservaCancelada != null) {
                //Liberamos la furgoneta
                com.proyectoaa.dao.VehicleDao vehicleDao = Database.getJdbi().onDemand(com.proyectoaa.dao.VehicleDao.class);
                vehicleDao.hacerDisponible(reservaCancelada.getIdVehiculo());

                //Ahora sí, destruimos la reserva
                reservationDao.borrarReserva(idReserva);
            }

            //Volvemos al panel del cliente
            response.sendRedirect("dashboard.jsp?cancelada=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=cancelar");
        }
    }
}