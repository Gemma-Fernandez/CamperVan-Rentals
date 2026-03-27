package com.proyectoaa.controller;

import com.proyectoaa.dao.Database;
import com.proyectoaa.dao.ReservationDao;
import com.proyectoaa.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/borrarReserva")
public class BorrarReservaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Seguridad admin
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("usuarioLogueado");

        if (admin == null || !"ADMIN".equals(admin.getRol())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            //Cogemos el ID de la reserva
            Integer idReserva = Integer.parseInt(request.getParameter("id"));

            //Ordenamos a la base de datos que borre
            ReservationDao reservationDao = Database.getJdbi().onDemand(ReservationDao.class);
            reservationDao.borrarReserva(idReserva);

            //Volvemos al listado general de reservas con un mensaje
            response.sendRedirect("adminReservas.jsp?borradoOk=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminReservas.jsp?error=borrado");
        }
    }
}