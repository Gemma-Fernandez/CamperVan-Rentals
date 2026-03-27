<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 23/3/26
  Time: 17:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.proyectoaa.model.User" %>
<%@ page import="com.proyectoaa.model.Vehicle" %>
<%@ page import="com.proyectoaa.model.Reservation" %>
<%@ page import="java.util.List" %>
<%@ page import="com.proyectoaa.dao.VehicleDao" %>
<%@ page import="com.proyectoaa.dao.ReservationDao" %>
<%@ page import="com.proyectoaa.dao.Database" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User usuario = (User) session.getAttribute("usuarioLogueado");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    VehicleDao vehicleDao = Database.getJdbi().onDemand(VehicleDao.class);
    ReservationDao reservationDao = Database.getJdbi().onDemand(ReservationDao.class);

    // Buscamos los vehículos disponibles y las reservas SOLO de este usuario
    List<Vehicle> vehiculos = vehicleDao.obtenerDisponibles();
    List<Reservation> misReservas = reservationDao.obtenerPorUsuario(usuario.getIdUsuario());
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Control - Campervan Rentals</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">🚐 Campervan Rentals</a>
        <div class="d-flex text-white align-items-center">
            <span class="me-3">Hola, <%= usuario.getNombre() %></span>
            <a href="logout" class="btn btn-outline-light btn-sm">Cerrar sesión</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row">

        <div class="col-md-4 mb-4">
            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <h5 class="card-title">Mi Perfil</h5>
                    <hr>
                    <p class="mb-1"><strong>Nombre:</strong> <%= usuario.getNombre() %></p>
                    <p class="mb-1"><strong>Email:</strong> <%= usuario.getEmail() %></p>
                    <p class="mb-0 mt-3 fs-4 text-success"><strong>Saldo:</strong> <%= usuario.getSaldoMonedero() %> €</p>
                </div>
            </div>
            <div class="card shadow-sm border-0 mt-4">
                <div class="card-body">
                    <h5 class="card-title">Mis Viajes Pendientes</h5>
                    <hr>
                    <%
                        if (misReservas != null && !misReservas.isEmpty()) {
                            for (Reservation r : misReservas) {
                    %>
                    <div class="alert alert-secondary p-2 mb-2 small">
                        <strong>Viaje el:</strong> <%= r.getFechaInicioViaje() %><br>
                        <strong>Días:</strong> <%= r.getDiasAlquiler() %> |
                        <strong>Total:</strong> <%= r.getCosteTotal() %> €

                        <div class="mt-2 d-flex justify-content-between align-items-center">
                            <span class="text-success fw-bold">ID Vehículo: <%= r.getIdVehiculo() %></span>

                            <a href="cancelarMiReserva?id=<%= r.getIdReserva() %>" class="btn btn-sm btn-outline-danger fw-bold" onclick="return confirm('¿Seguro que quieres cancelar tu viaje? Esta acción no se puede deshacer.');"> Cancelar</a>
                        </div>
                    </div>

                    <%
                        }
                    } else {
                    %>
                    <p class="text-muted small mb-0">No tienes ninguna aventura programada.</p>
                    <% } %>
                </div>
            </div>
        </div>


        <div class="col-md-8">
            <h4 class="mb-3">Vehículos Disponibles</h4>
            <% if ("true".equals(request.getParameter("reservaOk"))) { %>
            <div class="alert alert-success border-0 shadow-sm text-center">¡Reserva confirmada con éxito!</div>
            <% } %>
            <div class="row">
                <%
                    // Si hay vehículos, mostramos uno a uno
                    if (vehiculos != null && !vehiculos.isEmpty()) {
                        for (Vehicle v : vehiculos) {
                %>
                <div class="col-md-6 mb-4">
                    <div class="card shadow-sm border-0 h-100">
                        <img src="<%= v.getImagenUrl() %>" class="card-img-top" alt="<%= v.getModelo() %>" style="height: 200px; object-fit: cover;">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title"><%= v.getModelo() %></h5>
                            <p class="text-muted small mb-2">Matrícula: <%= v.getMatricula() %></p>
                            <p class="mb-1"><%= v.getCapacidadPasajeros() %> plazas</p>
                            <h5 class="text-primary mt-auto pt-3"><%= v.getPrecioPorDia() %> € <small class="text-muted fs-6">/ día</small></h5>
                            <a href="detalleVehiculo?id=<%= v.getIdVehiculo() %>" class="btn btn-primary mt-3 w-100">Ver Detalles</a>                        </div>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <div class="col-12">
                    <div class="alert alert-warning">No hay vehículos disponibles en este momento.</div>
                </div>
                <% } %>
            </div>
        </div>

    </div>
</div>
</body>
</html>
