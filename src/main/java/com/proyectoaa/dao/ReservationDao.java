package com.proyectoaa.dao;

import com.proyectoaa.model.Reservation;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

public interface ReservationDao {

    // Crear una nueva reserva
    @SqlUpdate("INSERT INTO reservas (id_usuario, id_vehiculo, observaciones_cliente, dias_alquiler, coste_total, fecha_inicio_viaje, pagada_por_completo) VALUES (:idUsuario, :idVehiculo, :observacionesCliente, :diasAlquiler, :costeTotal, :fechaInicioViaje, :pagadaPorCompleto)")
    boolean crearReserva(@BindBean Reservation reservation);

    // Listar todas las reservas de un usuario
    @SqlQuery("SELECT * FROM reservas WHERE id_usuario = :idUsuario ORDER BY fecha_inicio_viaje ASC")
    @RegisterBeanMapper(Reservation.class)
    List<Reservation> obtenerPorUsuario(@Bind("idUsuario") Integer idUsuario);

    // Obtener todas las reservas (admin)
    @SqlQuery("SELECT r.*, u.nombre AS nombreUsuario, v.modelo AS modeloVehiculo " +
            "FROM reservas r " +
            "JOIN usuarios u ON r.id_usuario = u.id_usuario " +
            "JOIN vehiculos v ON r.id_vehiculo = v.id_vehiculo " +
            "ORDER BY r.id_reserva DESC")
    @RegisterBeanMapper(Reservation.class)
    List<Reservation> obtenerTodas();

    // Obtener detalles de UNA sola reserva
    @SqlQuery("SELECT r.*, u.nombre AS nombreUsuario, v.modelo AS modeloVehiculo " +
            "FROM reservas r " +
            "JOIN usuarios u ON r.id_usuario = u.id_usuario " +
            "JOIN vehiculos v ON r.id_vehiculo = v.id_vehiculo " +
            "WHERE r.id_reserva = :id")
    @RegisterBeanMapper(Reservation.class)
    Reservation obtenerPorId(@Bind("id") Integer id);

    // Eliminar una reserva
    @SqlUpdate("DELETE FROM reservas WHERE id_reserva = :id")
    int borrarReserva(@Bind("id") Integer id);

    // Modificar los datos de una reserva existente
    @SqlUpdate("UPDATE reservas SET fecha_inicio_viaje = :fechaInicioViaje, dias_alquiler = :diasAlquiler, coste_total = :costeTotal, pagada_por_completo = :pagadaPorCompleto, observaciones_cliente = :observacionesCliente WHERE id_reserva = :idReserva")
    int modificarReserva(@BindBean Reservation reserva);

}