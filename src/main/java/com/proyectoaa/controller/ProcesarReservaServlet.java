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
import java.time.LocalDate;

@WebServlet("/procesar_reserva")
public class ProcesarReservaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Verificamos que el usuario sigue logueado
        HttpSession session = request.getSession();
        User usuario = (User) session.getAttribute("usuarioLogueado");

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            //Recogemos datos que el user ha escrito en formulario
            Integer idVehiculo = Integer.parseInt(request.getParameter("idVehiculo"));
            Double precioPorDia = Double.parseDouble(request.getParameter("precioPorDia"));
            LocalDate fechaInicio = LocalDate.parse(request.getParameter("fechaInicioViaje"));
            Integer diasAlquiler = Integer.parseInt(request.getParameter("diasAlquiler"));
            String observaciones = request.getParameter("observacionesCliente");

            //Calculamos el coste total
            Double costeTotal = precioPorDia * diasAlquiler;

            //Creamos el objeto Reservation y rellenamos
            Reservation nuevaReserva = new Reservation();
            nuevaReserva.setIdUsuario(usuario.getIdUsuario());
            nuevaReserva.setIdVehiculo(idVehiculo);
            nuevaReserva.setFechaInicioViaje(fechaInicio);
            nuevaReserva.setDiasAlquiler(diasAlquiler);
            nuevaReserva.setObservacionesCliente(observaciones);
            nuevaReserva.setCosteTotal(costeTotal);


            nuevaReserva.setPagadaPorCompleto(false);

            //Guardamos en la base de datos a través del DAO
            ReservationDao reservationDao = Database.getJdbi().onDemand(ReservationDao.class);
            reservationDao.crearReserva(nuevaReserva);

            //mandamos de vuelta al dashboard con un mensaje
            response.sendRedirect("dashboard?reservaOk=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard?error=reserva");
        }
    }
}