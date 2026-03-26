<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 26/3/26
  Time: 09:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.proyectoaa.model.User" %>
<%@ page import="com.proyectoaa.model.Vehicle" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //saber quién ha entrado
    User usuario = (User) session.getAttribute("usuarioLogueado");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    //Recoger la furgoneta que nos ha mandado el Servlet
    Vehicle vehiculo = (Vehicle) request.getAttribute("vehiculo");
    if (vehiculo == null) {
        response.sendRedirect("dashboard"); // Si no hay furgoneta, de vuelta al inicio
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalles - <%= vehiculo.getModelo() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container">
        <% if ("ADMIN".equals(usuario.getRol())) { %>
        <a class="navbar-brand" href="adminDashboard.jsp">⬅ Volver al panel de control</a>
        <% } else { %>
        <a class="navbar-brand" href="dashboard">⬅ Volver al catálogo</a>
        <% } %>
    </div>
</nav>

<div class="container">
    <div class="card shadow-lg border-0 overflow-hidden">
        <div class="row g-0">

            <div class="col-md-7">
                <img src="<%= vehiculo.getImagenUrl() %>" class="img-fluid w-100 h-100" style="object-fit: cover; min-height: 400px;" alt="<%= vehiculo.getModelo() %>">
            </div>

            <div class="col-md-5 d-flex flex-column">
                <div class="card-body p-5">
                    <h2 class="card-title fw-bold mb-1"><%= vehiculo.getModelo() %></h2>
                    <p class="text-muted mb-4">Matrícula: <span class="badge bg-secondary"><%= vehiculo.getMatricula() %></span></p>

                    <div class="mb-4">
                        <h4 class="text-primary fw-bold"><%= vehiculo.getPrecioPorDia() %> € <span class="fs-6 text-muted fw-normal">/ día</span></h4>
                    </div>

                    <ul class="list-group list-group-flush mb-4">
                        <li class="list-group-item px-0">👥 <strong>Capacidad:</strong> <%= vehiculo.getCapacidadPasajeros() %> personas</li>
                        <li class="list-group-item px-0">📅 <strong>En flota desde:</strong> <%= vehiculo.getFechaAltaFlota() %></li>
                        <li class="list-group-item px-0">
                            <strong>Estado:</strong>
                            <%= vehiculo.getDisponible() ? "Disponible para alquilar" : "Actualmente no disponible" %>
                        </li>
                    </ul>

                    <div class="mt-auto pt-3 border-top">
                        <% if ("ADMIN".equals(usuario.getRol())) { %>
                        <p class="small text-danger fw-bold mb-2">Opciones de Administrador</p>
                        <div class="d-grid gap-2">
                            <a href="editarVehiculo.jsp?id=<%= vehiculo.getIdVehiculo() %>" class="btn btn-outline-warning fw-bold">Modificar Datos</a>
                            <a href="borrarVehiculo?id=<%= vehiculo.getIdVehiculo() %>" class="btn btn-danger fw-bold" onclick="return confirm('¿Estás seguro de que quieres dar de baja esta furgoneta para siempre?');">Dar de Baja</a>
                        </div>
                        <% } else { %>
                        <a href="reservar.jsp?idVehiculo=<%= vehiculo.getIdVehiculo() %>&modelo=<%= vehiculo.getModelo() %>&precio=<%= vehiculo.getPrecioPorDia() %>" class="btn btn-success btn-lg w-100 fw-bold">Reservar Ahora</a>
                        <% } %>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>