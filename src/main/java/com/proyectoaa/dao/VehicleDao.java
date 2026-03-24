package com.proyectoaa.dao;

import com.proyectoaa.model.Vehicle;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

public interface VehicleDao {


    // Listado disponibles
    @SqlQuery("SELECT * FROM vehiculos WHERE disponible = true")
    @RegisterBeanMapper(Vehicle.class)
    List<Vehicle> obtenerDisponibles();


}
