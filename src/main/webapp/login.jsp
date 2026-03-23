<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 23/3/26
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Iniciar Sesión - Campervan Rentals</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-4">
      <div class="card shadow-sm border-0">
        <div class="card-body p-4">
          <h3 class="text-center mb-4">Bienvenido de nuevo</h3>

          <% if ("1".equals(request.getParameter("error"))) { %>
          <div class="alert alert-danger p-2 text-center small">Email o contraseña incorrectos.</div>
          <% } %>

          <form action="login" method="POST">
            <div class="mb-3">
              <label class="form-label text-muted">Correo electrónico</label>
              <input type="email" name="email" class="form-control" required>
            </div>
            <div class="mb-4">
              <label class="form-label text-muted">Contraseña</label>
              <input type="password" name="password" class="form-control" required>
            </div>
            <div class="d-grid">
              <button type="submit" class="btn btn-success btn-lg">Entrar</button>
            </div>
          </form>
        </div>
      </div>
      <p class="text-center mt-3 text-muted small">¿No tienes cuenta? <a href="index.jsp">Regístrate aquí</a></p>
    </div>
  </div>
</div>
</body>
</html>
