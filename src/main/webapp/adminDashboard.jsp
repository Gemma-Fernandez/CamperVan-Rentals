<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 25/3/26
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.proyectoaa.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // Doble seguridad: Tiene que estar logueado Y además ser ADMIN
  User usuario = (User) session.getAttribute("usuarioLogueado");
  if (usuario == null || !"ADMIN".equals(usuario.getRol())) {
    response.sendRedirect("login.jsp");
    return;
  }
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
  <h2 class="mb-4 text-warning">Gestión de la Flota</h2>

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

</div>
</body>
</html>
