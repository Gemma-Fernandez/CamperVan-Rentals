<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 25/3/26
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.proyectoaa.model.User" %>
<%@ page import="com.proyectoaa.dao.VehicleDao" %>
<%@ page import="com.proyectoaa.model.Vehicle" %>
<%@ page import="java.util.List" %>
<%@ page import="com.proyectoaa.dao.Database" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // Doble seguridad: Tiene que estar logueado Y además ser ADMIN
  User usuario = (User) session.getAttribute("usuarioLogueado");
  if (usuario == null || !"ADMIN".equals(usuario.getRol())) {
    response.sendRedirect("login.jsp");
    return;
  }
  VehicleDao vehicleDao = Database.getJdbi().onDemand(VehicleDao.class);
  List<Vehicle> vehiculos = vehicleDao.obtenerTodos();
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Panel de Administración - Campervan Rentals</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-light"> <nav class="navbar navbar-expand-lg navbar-dark bg-black border-bottom border-secondary">
  <div class="container">
    <a class="navbar-brand text-warning" href="#">⚙️ Admin Panel</a>
    <div class="d-flex text-white align-items-center">
      <span class="me-3">Hola, <%= usuario.getNombre() %></span>
      <a href="logout" class="btn btn-outline-light btn-sm">Cerrar sesión</a>
    </div>
  </div>
</nav>

<div class="container mt-5">
  <ul class="nav nav-tabs border-secondary mb-4">
    <li class="nav-item">
      <a class="nav-link active bg-warning text-dark fw-bold border-warning" href="adminDashboard.jsp">Flota</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-light border-secondary" href="adminUsuarios.jsp">Clientes</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-light border-secondary" href="adminReservas.jsp">Reservas</a>
    </li>
  </ul>
  <h2 class="mb-4 text-warning">Gestión de la Flota</h2>
  <% if ("true".equals(request.getParameter("borradoOk"))) { %>
  <div class="alert alert-success border-0 shadow-sm alert-dismissible fade show" role="alert">
    <strong>¡Baja completada!</strong> La furgoneta ha sido eliminada de la flota correctamente.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <% } %>

  <% if ("borrado".equals(request.getParameter("error"))) { %>
  <div class="alert alert-danger border-0 shadow-sm alert-dismissible fade show" role="alert">
    <strong>¡Operación bloqueada por seguridad!</strong><br>
    No puedes dar de baja esta furgoneta porque tiene <strong>reservas asociadas</strong>. Como alternativa, deberías editarla y marcarla como "No disponible".
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <% } %>
  <div class="row">
    <div class="col-md-12">
      <div class="card bg-secondary text-white border-0 shadow">
        <div class="card-body d-flex justify-content-between align-items-center">
          <div>
            <h4 class="mb-0">Vehículos Registrados</h4>
            <p class="mb-0 small text-light">Aquí gestionas las altas, bajas y modificaciones.</p>
          </div>
          <a href="nuevoVehiculo.jsp" class="btn btn-warning fw-bold">Añadir Nueva Furgoneta</a>
        </div>
      </div>
    </div>
  </div>
  <hr class="border-secondary mt-2 mb-4"> <div class="row mt-4">
    <%
      if (vehiculos != null && !vehiculos.isEmpty()) {
        for (Vehicle v : vehiculos) {
    %>
    <div class="col-md-4 mb-4">
      <div class="card bg-dark border border-secondary shadow-sm h-100">
        <img src="<%= v.getImagenUrl() %>" class="card-img-top" alt="<%= v.getModelo() %>" style="height: 200px; object-fit: cover;">
        <div class="card-body d-flex flex-column">
          <h5 class="card-title text-warning">
            <%= v.getModelo() %>
            <% if (!v.getDisponible()) { %>
            <span class="badge bg-danger ms-2 fs-6">No Disponible</span>
            <% } %>
          </h5>
          <p class="text-light small mb-2">Matrícula: <%= v.getMatricula() %></p>
          <p class="mb-3 text-light"> <%= v.getPrecioPorDia() %> € / día</p>

          <a href="detalleVehiculo?id=<%= v.getIdVehiculo() %>" class="btn btn-outline-warning mt-auto w-100 fw-bold">Ver Detalles / Editar</a>
        </div>
      </div>
    </div>
    <%
      }
    } else {
    %>
    <div class="col-12">
      <div class="alert alert-secondary text-center">Aún no hay vehículos registrados en la flota.</div>
    </div>
    <% } %>
  </div>
</div>
</body>
</html>
