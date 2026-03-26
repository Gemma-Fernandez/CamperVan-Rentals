<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 26/3/26
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.proyectoaa.model.User" %>
<%@ page import="com.proyectoaa.model.Vehicle" %>
<%@ page import="com.proyectoaa.dao.Database" %>
<%@ page import="com.proyectoaa.dao.VehicleDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  //Seguridad admin
  User usuario = (User) session.getAttribute("usuarioLogueado");
  if (usuario == null || !"ADMIN".equals(usuario.getRol())) {
    response.sendRedirect("login.jsp");
    return;
  }

  //Buscar datos actuales para rellenar los huecos
  Integer id = Integer.parseInt(request.getParameter("id"));
  VehicleDao vehicleDao = Database.getJdbi().onDemand(VehicleDao.class);
  Vehicle v = vehicleDao.obtenerPorId(id);
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Editar <%= v.getModelo() %></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-8">
      <div class="card shadow border-0">
        <div class="card-header bg-warning text-dark fw-bold text-center fs-4">
          Editando: <%= v.getModelo() %>
        </div>
        <div class="card-body p-5">
          <form action="modificarVehiculo" method="POST">

            <input type="hidden" name="idVehiculo" value="<%= v.getIdVehiculo() %>">

            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label fw-bold">Modelo</label>
                <input type="text" name="modelo" class="form-control" value="<%= v.getModelo() %>" required>
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label fw-bold">Matrícula</label>
                <input type="text" name="matricula" class="form-control" value="<%= v.getMatricula() %>" required maxlength="10">
              </div>
            </div>

            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label fw-bold">Plazas</label>
                <input type="number" name="capacidadPasajeros" class="form-control" value="<%= v.getCapacidadPasajeros() %>" required min="1" max="9">
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label fw-bold">Precio por día (€)</label>
                <input type="number" name="precioPorDia" class="form-control" value="<%= v.getPrecioPorDia() %>" step="0.01" min="10" required>
              </div>
            </div>

            <div class="mb-4 mt-3 form-check form-switch fs-5">
              <input class="form-check-input" type="checkbox" name="disponible" id="flexSwitchCheck" <%= v.getDisponible() ? "checked" : "" %>>
              <label class="form-check-label" for="flexSwitchCheck">
                Furgoneta Disponible para el público
              </label>
            </div>

            <div class="d-grid gap-2 d-md-flex justify-content-md-between">
              <a href="detalleVehiculo?id=<%= v.getIdVehiculo() %>" class="btn btn-outline-secondary">Cancelar</a>
              <button type="submit" class="btn btn-warning px-5 fw-bold">Guardar Cambios</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>