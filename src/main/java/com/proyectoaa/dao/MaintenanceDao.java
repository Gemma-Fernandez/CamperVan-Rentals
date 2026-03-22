package com.proyectoaa.dao;

import com.proyectoaa.model.Maintenance;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

public interface MaintenanceDao {

    // Registrar una visita al taller
    @SqlUpdate("INSERT INTO mantenimientos (id_vehiculo, descripcion_taller, coste_reparacion, fecha_revision, itv_superada) VALUES (:idVehiculo, :descripcionTaller, :costeReparacion, :fechaRevision, :itvSuperada)")
    boolean registrarMantenimiento(@BindBean Maintenance maintenance);

    // Listar todo el historial
    @SqlQuery("SELECT * FROM mantenimientos")
    @RegisterBeanMapper(Maintenance.class)
    List<Maintenance> listarTodos();
}