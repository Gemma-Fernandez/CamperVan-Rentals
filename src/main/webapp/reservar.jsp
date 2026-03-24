<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 24/3/26
  Time: 19:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.proyectoaa.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  //comprobamos que está logueado
  User usuario = (User) session.getAttribute("usuarioLogueado");
  if (usuario == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  // Recogemos datos de furgoneta que vienen en la URL
  String idVehiculo = request.getParameter("idVehiculo");
  String modelo = request.getParameter("modelo");
  String precio = request.getParameter("precio");
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Completar Reserva</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow border-0 p-4">
        <h3 class="mb-4 text-center">Reservar <%= modelo %></h3>

        <div class="alert alert-info text-center">
          Precio por día: <strong><%= precio %> €</strong>
        </div>

        <form action="procesar_reserva" method="POST">

          <input type="hidden" name="idVehiculo" value="<%= idVehiculo %>">
          <input type="hidden" name="precioPorDia" value="<%= precio %>">

          <div class="mb-3">
            <label class="form-label fw-bold">Fecha de inicio del viaje</label>
            <input type="date" name="fechaInicioViaje" class="form-control" required>
          </div>

          <div class="mb-3">
            <label class="form-label fw-bold">¿Cuántos días la vas a alquilar?</label>
            <input type="number" name="diasAlquiler" class="form-control" min="1" max="30" required>
          </div>

          <div class="mb-4">
            <label class="form-label fw-bold">Observaciones (Opcional)</label>
            <textarea name="observacionesCliente" class="form-control" rows="2" placeholder="Ej: Necesito cadenas para la nieve..."></textarea>
          </div>

          <div class="d-grid gap-2 d-md-flex justify-content-md-between">
            <a href="dashboard" class="btn btn-outline-secondary">Cancelar</a>
            <button type="submit" class="btn btn-success px-5">Confirmar y Pagar</button>
          </div>
        </form>

      </div>
    </div>
  </div>
</div>
</body>
</html>