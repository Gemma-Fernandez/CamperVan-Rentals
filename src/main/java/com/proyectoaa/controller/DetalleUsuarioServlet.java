package com.proyectoaa.controller;

import com.proyectoaa.dao.Database;
import com.proyectoaa.dao.UserDao;
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
import java.util.List;

@WebServlet("/detalleUsuario")
public class DetalleUsuarioServlet extends HttpServlet {

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
            //Cogemos ID cliente que hemos hecho clic
            Integer idUsuario = Integer.parseInt(request.getParameter("id"));

            //Buscamos sus datos personales
            UserDao userDao = Database.getJdbi().onDemand(UserDao.class);
            User cliente = userDao.obtenerPorId(idUsuario);

            if (cliente != null) {
                //Buscamos también todas sus reservas
                ReservationDao reservationDao = Database.getJdbi().onDemand(ReservationDao.class);
                List<Reservation> reservasCliente = reservationDao.obtenerPorUsuario(idUsuario);

                //lo mandamos a la vista
                request.setAttribute("cliente", cliente);
                request.setAttribute("reservasCliente", reservasCliente);

                request.getRequestDispatcher("/detalleUsuario.jsp").forward(request, response);
            } else {
                response.sendRedirect("adminUsuarios.jsp?error=notfound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminUsuarios.jsp?error=id");
        }
    }
}
