<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 23/3/26
  Time: 17:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.proyectoaa.model.User" %>
<%
    // Recuperamos el usuario que guardamos en la sesión durante el login
    User usuario = (User) session.getAttribute("usuarioLogueado");

    // Si alguien intenta entrar escribiendo la URL sin loguearse, lo echamos al login
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
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

        <div class="col-md-4">
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-body">
                    <h5 class="card-title">Mi Perfil</h5>
                    <hr>
                    <p class="mb-1"><strong>Nombre:</strong> <%= usuario.getNombre() %></p>
                    <p class="mb-1"><strong>Email:</strong> <%= usuario.getEmail() %></p>
                    <p class="mb-1"><strong>Rol:</strong> <span class="badge bg-info text-dark"><%= usuario.getRol() %></span></p>
                    <p class="mb-0 mt-3 fs-4 text-success"><strong>Saldo:</strong> <%= usuario.getSaldoMonedero() %> €</p>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-body p-5 text-center text-muted">
                    <h3>Aún no tienes reservas</h3>
                    <p>¡Explora nuestras furgonetas y empieza tu aventura!</p>
                    <button class="btn btn-primary mt-3">Ver furgonetas disponibles</button>
                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>
