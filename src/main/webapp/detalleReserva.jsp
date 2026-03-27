<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 27/3/26
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.proyectoaa.model.User" %>
<%@ page import="com.proyectoaa.model.Reservation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  User admin = (User) session.getAttribute("usuarioLogueado");
  if (admin == null || !"ADMIN".equals(admin.getRol())) {
    response.sendRedirect("login.jsp");
    return;
  }

  Reservation reserva = (Reservation) request.getAttribute("reserva");
  if (reserva == null) {
    response.sendRedirect("adminReservas.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Detalle de Reserva #<%= reserva.getIdReserva() %></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
  <div class="container">
    <a class="navbar-brand" href="adminReservas.jsp">Volver al historial de reservas</a>
  </div>
</nav>

<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-8">
      <div class="card shadow-sm border-0">
        <div class="card-header bg-primary text-white fw-bold d-flex justify-content-between align-items-center">
          <span>📄 Factura / Reserva #<%= reserva.getIdReserva() %></span>
          <span class="badge bg-light text-dark"><%= reserva.getPagadaPorCompleto() != null && reserva.getPagadaPorCompleto() ? "Pagada" : "Pendiente de pagar" %></span>
        </div>
        <div class="card-body p-5">

          <div class="row mb-4">
            <div class="col-sm-6">
              <h6 class="text-muted fw-bold mb-1">Datos del Cliente</h6>
              <p class="mb-0 fs-5"><%= reserva.getNombreUsuario() %></p>
              <p class="text-muted small">ID Cliente: #<%= reserva.getIdUsuario() %></p>
            </div>
            <div class="col-sm-6 text-sm-end">
              <h6 class="text-muted fw-bold mb-1">Vehículo Reservado</h6>
              <p class="mb-0 fs-5"><%= reserva.getModeloVehiculo() %></p>
              <p class="text-muted small">ID Vehículo: #<%= reserva.getIdVehiculo() %></p>
            </div>
          </div>

          <hr class="mb-4">

          <div class="row text-center mb-4">
            <div class="col-4">
              <span class="text-muted d-block small fw-bold">Fecha de Inicio</span>
              <span class="fs-5"><%= reserva.getFechaInicioViaje() %></span>
            </div>
            <div class="col-4 border-start border-end">
              <span class="text-muted d-block small fw-bold">Duración</span>
              <span class="fs-5"><%= reserva.getDiasAlquiler() %> días</span>
            </div>
            <div class="col-4">
              <span class="text-muted d-block small fw-bold">Coste Total</span>
              <span class="fs-4 fw-bold text-success"><%= reserva.getCosteTotal() %> €</span>
            </div>
          </div>

          <% if (reserva.getObservacionesCliente() != null && !reserva.getObservacionesCliente().isEmpty()) { %>
          <div class="alert alert-secondary mt-4">
            <strong>Notas del cliente:</strong> <%= reserva.getObservacionesCliente() %>
          </div>
          <% } %>

          <div class="mt-5 pt-3 border-top d-flex justify-content-between">
            <a href="editarReserva.jsp?id=<%= reserva.getIdReserva() %>" class="btn btn-outline-warning fw-bold px-4">Modificar Reserva</a>
            <a href="borrarReserva?id=<%= reserva.getIdReserva() %>" class="btn btn-danger fw-bold px-4" onclick="return confirm('¿Estás seguro de que quieres cancelar y borrar esta reserva para siempre?');">Cancelar Reserva</a>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>