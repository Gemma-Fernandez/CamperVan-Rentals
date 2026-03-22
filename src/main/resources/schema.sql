
CREATE DATABASE IF NOT EXISTS campervan_rentals;
USE campervan_rentals;

-- 1. Tabla Usuarios
CREATE TABLE usuarios (
                          id_usuario INT AUTO_INCREMENT PRIMARY KEY,
                          nombre VARCHAR(100) NOT NULL,
                          email VARCHAR(100) NOT NULL UNIQUE,
                          password VARCHAR(255) NOT NULL,
                          rol VARCHAR(20) DEFAULT 'CLIENTE',
                          saldo_monedero DECIMAL(10, 2) DEFAULT 0.00,
                          fecha_registro DATE NOT NULL,
                          cuenta_activa BOOLEAN DEFAULT TRUE
);

-- 2. Tabla Vehículos
CREATE TABLE vehiculos (
                           id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
                           modelo VARCHAR(100) NOT NULL,
                           matricula VARCHAR(20) NOT NULL UNIQUE,
                           imagen_url VARCHAR(255),
                           capacidad_pasajeros INT NOT NULL,
                           precio_por_dia DECIMAL(10, 2) NOT NULL,
                           fecha_alta_flota DATE NOT NULL,
                           disponible BOOLEAN DEFAULT TRUE
);

-- 3. Tabla Reservas
CREATE TABLE reservas (
                          id_reserva INT AUTO_INCREMENT PRIMARY KEY,
                          id_usuario INT NOT NULL,
                          id_vehiculo INT NOT NULL,
                          observaciones_cliente TEXT,
                          dias_alquiler INT NOT NULL,
                          coste_total DECIMAL(10, 2) NOT NULL,
                          fecha_inicio_viaje DATE NOT NULL,
                          pagada_por_completo BOOLEAN DEFAULT FALSE,
                          FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
                          FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo) ON DELETE CASCADE
);

-- 4. Tabla Mantenimientos
CREATE TABLE mantenimientos (
                                id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
                                id_vehiculo INT NOT NULL,
                                descripcion_taller TEXT,
                                coste_reparacion DECIMAL(10, 2) NOT NULL,
                                fecha_revision DATE NOT NULL,
                                itv_superada BOOLEAN DEFAULT TRUE,
                                FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo) ON DELETE CASCADE
);