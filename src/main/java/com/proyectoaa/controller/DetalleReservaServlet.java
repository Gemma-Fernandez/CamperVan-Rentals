package com.proyectoaa.controller;

import com.proyectoaa.dao.Database;
import com.proyectoaa.dao.ReservationDao;
import com.proyectoaa.model.User;
import com.proyectoaa.model.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/detalleReserva")
public class DetalleReservaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //eguridad Admin
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("usuarioLogueado");

        if (admin == null || !"ADMIN".equals(admin.getRol())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            //Cogemos el ID de la reserva de la URL
            Integer idReserva = Integer.parseInt(request.getParameter("id"));

            //Buscamos reserva concreta en base de datos
            ReservationDao reservationDao = Database.getJdbi().onDemand(ReservationDao.class);
            Reservation reserva = reservationDao.obtenerPorId(idReserva);

            if (reserva != null) {
                request.setAttribute("reserva", reserva);
                request.getRequestDispatcher("/detalleReserva.jsp").forward(request, response);
            } else {
                response.sendRedirect("adminReservas.jsp?error=notfound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminReservas.jsp?error=id");
        }
    }
}