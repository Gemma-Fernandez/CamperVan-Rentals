package com.proyectoaa.controller;

import com.proyectoaa.dao.Database;
import com.proyectoaa.dao.ReservationDao;
import com.proyectoaa.model.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/modificarReserva")
public class ModificarReservaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //Recogemos los datos del formulario
            Integer idReserva = Integer.parseInt(request.getParameter("idReserva"));
            LocalDate fechaInicio = LocalDate.parse(request.getParameter("fechaInicio"));
            Integer dias = Integer.parseInt(request.getParameter("diasAlquiler"));
            Double coste = Double.parseDouble(request.getParameter("costeTotal"));
            Boolean pagada = Boolean.parseBoolean(request.getParameter("pagada"));
            String observaciones = request.getParameter("observaciones");

            //Rellenamos un objeto Reservation vacío SOLO con lo que vamos a cambiar
            Reservation reservaModificada = new Reservation();
            reservaModificada.setIdReserva(idReserva);
            reservaModificada.setFechaInicioViaje(fechaInicio);
            reservaModificada.setDiasAlquiler(dias);
            reservaModificada.setCosteTotal(coste);
            reservaModificada.setPagadaPorCompleto(pagada);
            reservaModificada.setObservacionesCliente(observaciones);

            // Se lleva a la base de datos
            ReservationDao reservationDao = Database.getJdbi().onDemand(ReservationDao.class);
            reservationDao.modificarReserva(reservaModificada);

            //Volvemos a la factura para ver los cambios
            response.sendRedirect("detalleReserva?id=" + idReserva);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminReservas.jsp?error=modificar");
        }
    }
}
