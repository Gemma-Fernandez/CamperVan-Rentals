<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 26/3/26
  Time: 17:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.proyectoaa.model.User" %>
<%@ page import="com.proyectoaa.model.Reservation" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  User admin = (User) session.getAttribute("usuarioLogueado");
  if (admin == null || !"ADMIN".equals(admin.getRol())) {
    response.sendRedirect("login.jsp");
    return;
  }

  User cliente = (User) request.getAttribute("cliente");
  List<Reservation> reservas = (List<Reservation>) request.getAttribute("reservasCliente");

  if (cliente == null) {
    response.sendRedirect("adminUsuarios.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ficha de Cliente - <%= cliente.getNombre() %></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
  <div class="container">
    <a class="navbar-brand" href="adminUsuarios.jsp">⬅ Volver al directorio de clientes</a>
  </div>
</nav>

<div class="container">
  <div class="row">
    <div class="col-md-4 mb-4">
      <div class="card shadow-sm border-0">
        <div class="card-header bg-primary text-white fw-bold">
          Ficha del Cliente
        </div>
        <div class="card-body">
          <h4 class="card-title fw-bold"><%= cliente.getNombre() %></h4>
          <p class="text-muted mb-4">ID de sistema: #<%= cliente.getIdUsuario() %></p>

          <ul class="list-group list-group-flush mb-4">
            <li class="list-group-item px-0"><strong>Email:</strong> <%= cliente.getEmail() %></li>
            <li class="list-group-item px-0">
              <strong>Nivel de Acceso:</strong>
              <span class="badge <%= "ADMIN".equals(cliente.getRol()) ? "bg-danger" : "bg-primary" %>">
                                    <%= cliente.getRol() %>
                                </span>
            </li>
          </ul>

          <div class="d-grid gap-2 mt-4">
            <a href="#" class="btn btn-outline-warning fw-bold">Editar Cliente</a>
            <a href="#" class="btn btn-danger fw-bold" onclick="return confirm('¿Estás seguro de que quieres borrar a este usuario? Si tiene reservas, no podrás hacerlo.');"> Borrar Cliente</a>
          </div>
        </div>
      </div>
    </div>

    <div class="col-md-8">
      <div class="card shadow-sm border-0">
        <div class="card-header bg-dark text-white fw-bold">
          Historial de Reservas (<%= (reservas != null) ? reservas.size() : 0 %>)
        </div>
        <div class="card-body p-0">
          <table class="table table-hover mb-0">
            <thead class="table-light">
            <tr>
              <th>Reserva ID</th>
              <th>Inicio</th>
              <th>Fin</th>
              <th>Total</th>
            </tr>
            </thead>
            <tbody>
            <%
              if (reservas != null && !reservas.isEmpty()) {
                for (Reservation r : reservas) {
            %>
            <tr>
              <td class="fw-bold">#<%= r.getIdReserva() %></td>
              <td><%= r.getFechaInicioViaje() %></td>
              <td><%= r.getDiasAlquiler() %></td>
              <td class="text-success fw-bold"><%= r.getCosteTotal() %> €</td>
            </tr>
            <%
              }
            } else {
            %>
            <tr><td colspan="4" class="text-center py-4 text-muted">Este cliente aún no ha hecho ninguna reserva.</td></tr>
            <% } %>
            </tbody>
          </table>
        </div>
      </div>
    </div>

  </div>
</div>
</body>
</html>
