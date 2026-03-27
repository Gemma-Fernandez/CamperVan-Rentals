<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 26/3/26
  Time: 17:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.proyectoaa.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.proyectoaa.dao.Database" %>
<%@ page import="com.proyectoaa.dao.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // Seguridad ADMIN
  User admin = (User) session.getAttribute("usuarioLogueado");
  if (admin == null || !"ADMIN".equals(admin.getRol())) {
    response.sendRedirect("login.jsp");
    return;
  }

  // Traemos a todos los usuarios de la base de datos
  UserDao userDao = Database.getJdbi().onDemand(UserDao.class);

  //Recogemos lo que ha escrito
  String filtroNombre = request.getParameter("nombreBusqueda");
  String filtroRol = request.getParameter("rolBusqueda");

  // preparamos la lista vacía
  List<User> listaUsuarios;

  //Si ha usado el buscador, filtramos
  if (filtroNombre != null || filtroRol != null) {
    String nom = (filtroNombre != null) ? filtroNombre : "";
    String r = (filtroRol != null) ? filtroRol : "";
    listaUsuarios = userDao.buscarUsuariosDoble(nom, r);
  } else {
    listaUsuarios = userDao.obtenerTodos();
  }

%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Gestión de Clientes - Admin</title>
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
      <a class="nav-link active bg-warning text-dark fw-bold border-warning" href="adminUsuarios.jsp">Clientes</a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-light border-secondary" href="adminReservas.jsp">Reservas</a>
    </li>
  </ul>

  <h2 class="mb-4 text-warning">Directorio de Clientes</h2>
  <div class="card bg-secondary text-white mb-4 shadow-sm border-0">
    <div class="card-body">
      <form action="adminUsuarios.jsp" method="GET" class="row g-3 align-items-end">
        <div class="col-md-5">
          <label class="form-label fw-bold">Buscar por Nombre:</label>
          <input type="text" name="nombreBusqueda" class="form-control" placeholder="Ej: Gemma..." value="<%= (filtroNombre != null) ? filtroNombre : "" %>">
        </div>
        <div class="col-md-4">
          <label class="form-label fw-bold">iltrar por Rol:</label>
          <select name="rolBusqueda" class="form-select">
            <option value="">Todos los roles</option>
            <option value="ADMIN" <%= "ADMIN".equals(filtroRol) ? "selected" : "" %>>Administradores</option>
            <option value="CLIENTE" <%= "CLIENTE".equals(filtroRol) ? "selected" : "" %>>Clientes</option>
          </select>
        </div>
        <div class="col-md-3">
          <button type="submit" class="btn btn-warning fw-bold w-100">Aplicar Filtros</button>
        </div>
      </form>
    </div>
  </div>
  <% if ("true".equals(request.getParameter("borradoOk"))) { %>
  <div class="alert alert-success border-0 shadow-sm alert-dismissible fade show" role="alert">
     <strong>¡Usuario eliminado!</strong> Sus datos han sido borrados del sistema correctamente.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <% } %>

  <% if ("borrado".equals(request.getParameter("error"))) { %>
  <div class="alert alert-danger border-0 shadow-sm alert-dismissible fade show" role="alert">
    <strong>¡Operación bloqueada por seguridad!</strong><br>
    No puedes eliminar a este cliente porque tiene <strong>reservas asociadas</strong>.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <% } %>

  <% if ("propiaCuenta".equals(request.getParameter("error"))) { %>
  <div class="alert alert-warning border-0 shadow-sm alert-dismissible fade show" role="alert">
    No puedes borrar tu propia cuenta de Administrador mientras estás dentro.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <% } %>
  <div class="card bg-dark border border-secondary shadow-sm">
    <div class="card-body p-0">
      <table class="table table-dark table-striped table-hover mb-0">
        <thead>
        <tr>
          <th>ID</th>
          <th>Nombre</th>
          <th>Email</th>
          <th>Rol</th>
          <th class="text-end">Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
          if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
            for (User u : listaUsuarios) {
        %>
        <tr>
          <td>#<%= u.getIdUsuario() %></td>
          <td class="fw-bold"><%= u.getNombre() %></td>
          <td><%= u.getEmail() %></td>
          <td>
            <span class="badge <%= "ADMIN".equals(u.getRol()) ? "bg-danger" : "bg-primary" %>">
                                            <%= u.getRol() %>
            </span>
          </td>
          <td class="text-end">
            <a href="detalleUsuario?id=<%= u.getIdUsuario() %>" class="btn btn-sm btn-outline-warning fw-bold">Ver Detalles</a>
          </td>
        </tr>
        <%
          }
        } else {
        %>
        <tr><td colspan="5" class="text-center py-4 text-muted">No hay usuarios registrados.</td></tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>

</div>
</body>
</html>
