<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 26/3/26
  Time: 18:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.proyectoaa.model.User" %>
<%@ page import="com.proyectoaa.dao.Database" %>
<%@ page import="com.proyectoaa.dao.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  //Seguridad Admin
  User admin = (User) session.getAttribute("usuarioLogueado");
  if (admin == null || !"ADMIN".equals(admin.getRol())) {
    response.sendRedirect("login.jsp");
    return;
  }

  //Buscar los datos del cliente
  Integer id = Integer.parseInt(request.getParameter("id"));
  UserDao userDao = Database.getJdbi().onDemand(UserDao.class);
  User cliente = userDao.obtenerPorId(id);
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Editar Cliente - <%= cliente.getNombre() %></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow border-0">
        <div class="card-header bg-warning text-dark fw-bold text-center fs-5">
          ✏️ Editando Perfil: <%= cliente.getNombre() %>
        </div>
        <div class="card-body p-4">
          <form action="modificarUsuario" method="POST">

            <input type="hidden" name="id" value="<%= cliente.getIdUsuario() %>">

            <div class="mb-3">
              <label class="form-label fw-bold">Nombre Completo</label>
              <input type="text" name="nombre" class="form-control" value="<%= cliente.getNombre() %>" required>
            </div>

            <div class="mb-3">
              <label class="form-label fw-bold">Correo Electrónico</label>
              <input type="email" name="email" class="form-control" value="<%= cliente.getEmail() %>" required>
            </div>

            <div class="mb-4">
              <label class="form-label fw-bold">Nivel de Acceso (Rol)</label>
              <select name="rol" class="form-select">
                <option value="CLIENTE" <%= "CLIENTE".equals(cliente.getRol()) ? "selected" : "" %>>Usuario Estándar (CLIENTE)</option>
                <option value="ADMIN" <%= "ADMIN".equals(cliente.getRol()) ? "selected" : "" %>>Administrador (ADMIN)</option>
              </select>
            </div>

            <div class="d-grid gap-2 d-md-flex justify-content-md-between">
              <a href="detalleUsuario?id=<%= cliente.getIdUsuario() %>" class="btn btn-outline-secondary">Cancelar</a>
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