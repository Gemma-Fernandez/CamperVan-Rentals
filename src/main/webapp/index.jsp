<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campervan Rentals - Inicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">🚐 Campervan Rentals</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-sm border-0">
                <div class="card-body p-4">
                    <h3 class="text-center mb-4">Únete a la aventura</h3>

                    <form action="registro" method="POST">

                        <div class="mb-3">
                            <label for="nombre" class="form-label text-muted">Nombre completo</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ej: Gemma Fernández" required>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label text-muted">Correo electrónico</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="tu@email.com" required>
                        </div>

                        <div class="mb-4">
                            <label for="password" class="form-label text-muted">Contraseña</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="******" required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">Crear cuenta</button>
                        </div>

                    </form>

                </div>
            </div>
            <p class="text-center mt-3 text-muted small">¿Ya tienes cuenta? <a href="login.jsp" class="text-decoration-none">Inicia sesión aquí</a>.</p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>