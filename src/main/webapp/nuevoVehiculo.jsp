<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 25/3/26
  Time: 16:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.proyectoaa.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // Seguridad nivel Admin
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
  <title>Añadir Vehículo - Campervan Rentals</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-8">
      <div class="card shadow-lg border-0">
        <div class="card-header bg-warning text-dark fw-bold text-center fs-4">
          Dar de alta una nueva furgoneta
        </div>
        <div class="card-body p-5">

          <form action="guardarVehiculo" method="POST" enctype="multipart/form-data">

            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label fw-bold">Modelo</label>
                <input type="text" name="modelo" class="form-control" required placeholder="Ej: VW California">
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label fw-bold">Matrícula</label>
                <input type="text" name="matricula" class="form-control" required maxlength="10" placeholder="Ej: 1234 ABC">
              </div>
            </div>

            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label fw-bold">Plazas</label>
                <input type="number" name="capacidadPasajeros" class="form-control" required min="1" max="9">
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label fw-bold">Precio por día (€)</label>
                <input type="number" name="precioPorDia" class="form-control" step="0.01" min="10" required>
              </div>
            </div>

            <div class="mb-4 mt-3">
              <label class="form-label fw-bold text-primary">Subir foto</label>
              <input type="file" name="imagen" class="form-control border-primary" accept="image/png, image/jpeg, image/jpg" required>
              <div class="form-text">Solo se permiten imágenes en formato JPG o PNG.</div>
            </div>

            <div class="d-grid gap-2 d-md-flex justify-content-md-between">
              <a href="adminDashboard.jsp" class="btn btn-outline-secondary">Cancelar y Volver</a>
              <button type="submit" class="btn btn-warning px-5 fw-bold">💾 Guardar Vehículo</button>
            </div>
          </form>

        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>