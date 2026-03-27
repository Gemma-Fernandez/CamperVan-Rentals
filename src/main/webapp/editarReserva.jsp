<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 27/3/26
  Time: 11:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.proyectoaa.model.User" %>
<%@ page import="com.proyectoaa.model.Reservation" %>
<%@ page import="com.proyectoaa.dao.Database" %>
<%@ page import="com.proyectoaa.dao.ReservationDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  //Seguridad admin
  User admin = (User) session.getAttribute("usuarioLogueado");
  if (admin == null || !"ADMIN".equals(admin.getRol())) {
    response.sendRedirect("login.jsp");
    return;
  }

  //Buscamos reserva actual para rellenar huecos
  Integer id = Integer.parseInt(request.getParameter("id"));
  ReservationDao reservationDao = Database.getJdbi().onDemand(ReservationDao.class);
  Reservation reserva = reservationDao.obtenerPorId(id);
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Editar Reserva #<%= reserva.getIdReserva() %></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow border-0">
        <div class="card-header bg-warning text-dark fw-bold text-center fs-5">
          Editando Reserva #<%= reserva.getIdReserva() %>
        </div>
        <div class="card-body p-4">
          <form action="modificarReserva" method="POST">

            <input type="hidden" name="idReserva" value="<%= reserva.getIdReserva() %>">

            <div class="row mb-3">
              <div class="col-md-6">
                <label class="form-label fw-bold">Fecha de Inicio</label>
                <input type="date" name="fechaInicio" class="form-control" value="<%= reserva.getFechaInicioViaje() %>" required>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-bold">Días de Alquiler</label>
                <input type="number" name="diasAlquiler" class="form-control" value="<%= reserva.getDiasAlquiler() %>" required min="1">
              </div>
            </div>

            <div class="row mb-3">
              <div class="col-md-6">
                <label class="form-label fw-bold">Coste Total (€)</label>
                <input type="number" step="0.01" name="costeTotal" class="form-control" value="<%= reserva.getCosteTotal() %>" required>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-bold">Estado del Pago</label>
                <select name="pagada" class="form-select">
                  <option value="false" <%= (reserva.getPagadaPorCompleto() == null || !reserva.getPagadaPorCompleto()) ? "selected" : "" %>>Pendiente</option>
                  <option value="true" <%= (reserva.getPagadaPorCompleto() != null && reserva.getPagadaPorCompleto()) ? "selected" : "" %>>Pagada</option>
                </select>
              </div>
            </div>

            <div class="mb-4">
              <label class="form-label fw-bold">Observaciones del Cliente</label>
              <textarea name="observaciones" class="form-control" rows="3"><%= (reserva.getObservacionesCliente() != null) ? reserva.getObservacionesCliente() : "" %></textarea>
            </div>

            <div class="d-grid gap-2 d-md-flex justify-content-md-between">
              <a href="detalleReserva?id=<%= reserva.getIdReserva() %>" class="btn btn-outline-secondary">Cancelar</a>
              <button type="submit" class="btn btn-warning px-5 fw-bold">💾 Guardar Cambios</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
