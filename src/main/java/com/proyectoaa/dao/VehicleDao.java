package com.proyectoaa.dao;

import com.proyectoaa.model.Vehicle;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.GetGeneratedKeys;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

public interface VehicleDao {


    // Listado campers disponibles
    @SqlQuery("SELECT * FROM vehiculos WHERE disponible = true")
    @RegisterBeanMapper(Vehicle.class)
    List<Vehicle> obtenerDisponibles();

    // Guardar un vehículo nuevo en la base de datos
    @SqlUpdate("INSERT INTO vehiculos (modelo, matricula, imagen_url, capacidad_pasajeros, precio_por_dia, fecha_alta_flota, disponible) " +
            "VALUES (:modelo, :matricula, :imagenUrl, :capacidadPasajeros, :precioPorDia, :fechaAltaFlota, :disponible)")
    @GetGeneratedKeys
    int insertarVehiculo(@BindBean Vehicle vehicle);

    // Buscar un único vehículo por su ID
    @SqlQuery("SELECT * FROM vehiculos WHERE id_vehiculo = :id")
    @RegisterBeanMapper(Vehicle.class)
    Vehicle obtenerPorId(@Bind("id") Integer id);

    // Eliminar un vehículo de la base de datos
    @SqlUpdate("DELETE FROM vehiculos WHERE id_vehiculo = :id")
    int borrarVehiculo(@Bind("id") Integer id);

    // Modificar los datos de un vehículo existente
    @SqlUpdate("UPDATE vehiculos SET modelo = :modelo, matricula = :matricula, capacidad_pasajeros = :capacidadPasajeros, precio_por_dia = :precioPorDia, disponible = :disponible WHERE id_vehiculo = :idVehiculo")
    int modificarVehiculo(@BindBean Vehicle vehicle);

    // Obtener absolutamente TODOS los vehículos (Para Admin)
    @SqlQuery("SELECT * FROM vehiculos ORDER BY id_vehiculo DESC")
    @RegisterBeanMapper(Vehicle.class)
    List<Vehicle> obtenerTodos();
}
