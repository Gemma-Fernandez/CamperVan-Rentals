<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 26/3/26
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.proyectoaa.model.User" %>
<%@ page import="com.proyectoaa.model.Reservation" %>
<%@ page import="java.util.List" %>
<%@ page import="com.proyectoaa.dao.Database" %>
<%@ page import="com.proyectoaa.dao.ReservationDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // Seguridad ADMIN
  User admin = (User) session.getAttribute("usuarioLogueado");
  if (admin == null || !"ADMIN".equals(admin.getRol())) {
    response.sendRedirect("login.jsp");
    return;
  }

  // Traemos TODAS las reservas de la base de datos
  ReservationDao reservationDao = Database.getJdbi().onDemand(ReservationDao.class);

//Recogemos lo que admin ha escrito
  String filtroCliente = request.getParameter("clienteBusqueda");
  String filtroVehiculo = request.getParameter("vehiculoBusqueda");

  List<Reservation> listaReservas;

  if (filtroCliente != null || filtroVehiculo != null) {
    String cli = (filtroCliente != null) ? filtroCliente : "";
    String veh = (filtroVehiculo != null) ? filtroVehiculo : "";
    listaReservas = reservationDao.buscarReservasDoble(cli, veh);
  } else {
    listaReservas = reservationDao.obtenerTodas();
  }

%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Gestión de Reservas - Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-black border-bottom border-secondary">
  <div class="container">
    <a class="navbar-brand text-warning" href="#">⚙️ Admin Panel</a>
    <div class="d-flex text-white align-items-center">
      <span class="me-3">Hola, <%= admin.getNombre() %></span>
      <a href="logout" class="btn btn-outline-light btn-sm">Cerrar sesión</a>
    </div>
  </div>
</nav>

<div class="container mt-5">

  <ul class="nav nav-tabs border-secondary mb-4">
    <li class="nav-item">
      <a class="nav-link text-light border-secondary" href="adminDashboard.jsp">Flota</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-light border-secondary" href="adminUsuarios.jsp">Clientes</a>
    </li>
    <li class="nav-item">
      <a class="nav-link active bg-warning text-dark fw-bold border-warning" href="adminReservas.jsp">Reservas</a>
    </li>
  </ul>

  <h2 class="mb-4 text-warning">Historial Global de Reservas</h2>

  <div class="card bg-secondary text-white mb-4 shadow-sm border-0">
    <div class="card-body">
      <form action="adminReservas.jsp" method="GET" class="row g-3 align-items-end">
        <div class="col-md-5">
          <label class="form-label fw-bold">Buscar por Cliente:</label>
          <input type="text" name="clienteBusqueda" class="form-control" placeholder="Ej: Gemma..." value="<%= (filtroCliente != null) ? filtroCliente : "" %>">
        </div>
        <div class="col-md-4">
          <label class="form-label fw-bold">Buscar por Vehículo:</label>
          <input type="text" name="vehiculoBusqueda" class="form-control" placeholder="Ej: Volkswagen..." value="<%= (filtroVehiculo != null) ? filtroVehiculo : "" %>">
        </div>
        <div class="col-md-3">
          <button type="submit" class="btn btn-warning fw-bold w-100">Aplicar Filtros</button>
        </div>
      </form>
    </div>
  </div>
  <% if ("true".equals(request.getParameter("borradoOk"))) { %>
  <div class="alert alert-success border-0 shadow-sm alert-dismissible fade show" role="alert">
    <strong>¡Reserva cancelada!</strong> El registro ha sido eliminado del sistema.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <% } %>

  <div class="card bg-dark border border-secondary shadow-sm">
    <div class="card-body p-0">
      <table class="table table-dark table-striped table-hover mb-0">
        <thead>
        <tr>
          <th>ID Reserva</th>
          <th>Nombre cliente</th>
          <th>Vehículo</th>
          <th>Inicio</th>
          <th>Días</th>
          <th>Total (€)</th>
          <th class="text-end">Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
          if (listaReservas != null && !listaReservas.isEmpty()) {
            for (Reservation r : listaReservas) {
        %>
        <tr>
          <td class="fw-bold text-warning">#<%= r.getIdReserva() %></td>
          <td><%= r.getNombreUsuario() %></td>
          <td><%= r.getModeloVehiculo() %>-- ID #<%= r.getIdVehiculo() %></td>
          <td><%= r.getFechaInicioViaje() %></td>
          <td><%= r.getDiasAlquiler() %></td>
          <td class="text-success fw-bold"><%= r.getCosteTotal() %> €</td>
          <td class="text-end">
            <a href="detalleReserva?id=<%= r.getIdReserva() %>" class="btn btn-sm btn-outline-warning fw-bold">Gestionar</a>
          </td>
        </tr>
        <%
          }
        } else {
        %>
        <tr><td colspan="7" class="text-center py-4 text-muted">Aún no hay reservas en el sistema.</td></tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>

</div>
</body>
</html>