package com.proyectoaa.dao;

import com.proyectoaa.model.Reservation;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

public interface ReservationDao {

    // Crear una nueva reserva
    @SqlUpdate("INSERT INTO reservas (id_usuario, id_vehiculo, observaciones_cliente, dias_alquiler, coste_total, fecha_inicio_viaje, pagada_por_completo) VALUES (:idUsuario, :idVehiculo, :observacionesCliente, :diasAlquiler, :costeTotal, :fechaInicioViaje, :pagadaPorCompleto)")
    boolean crearReserva(@BindBean Reservation reservation);

    // Listar todas las reservas
    @SqlQuery("SELECT * FROM reservas")
    @RegisterBeanMapper(Reservation.class)
    List<Reservation> listarTodas();
}