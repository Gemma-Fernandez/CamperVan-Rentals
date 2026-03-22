package com.proyectoaa.dao;

import com.proyectoaa.model.Vehicle;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

public interface VehicleDao {

    // Dar de alta un vehículo
    @SqlUpdate("INSERT INTO vehiculos (modelo, matricula, imagen_url, capacidad_pasajeros, precio_por_dia, fecha_alta_flota, disponible) VALUES (:modelo, :matricula, :imagenUrl, :capacidadPasajeros, :precioPorDia, :fechaAltaFlota, :disponible)")
    boolean registrarVehiculo(@BindBean Vehicle vehicle);

    // Listado completo para el catálogo
    @SqlQuery("SELECT * FROM vehiculos")
    @RegisterBeanMapper(Vehicle.class)
    List<Vehicle> listarTodos();

    // Buscar uno solo por su ID
    @SqlQuery("SELECT * FROM vehiculos WHERE id_vehiculo = :id")
    @RegisterBeanMapper(Vehicle.class)
    Vehicle obtenerPorId(@Bind("id") int id);

    // Dar de baja
    @SqlUpdate("UPDATE vehiculos SET disponible = false WHERE id_vehiculo = :id")
    boolean darDeBaja(@Bind("id") int id);
}
