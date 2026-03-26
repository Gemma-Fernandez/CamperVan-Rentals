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


    // Listado disponibles
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

}
