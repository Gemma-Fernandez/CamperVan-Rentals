package com.proyectoaa.dao;

import  com.proyectoaa.model.User;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

public interface UserDao {

    //Método para DAR DE ALTA
    @SqlUpdate("INSERT INTO usuarios (nombre, email, password, rol, saldo_monedero, fecha_registro, cuenta_activa) VALUES (:nombre, :email, :password, :rol, :saldoMonedero, :fechaRegistro, :cuentaActiva)")
    boolean registrarUsuario(@BindBean User user);

    //Método para el LOGIN
    @SqlQuery("SELECT * FROM usuarios WHERE email = :email")
    @RegisterBeanMapper(User.class)
    User obtenerUsuarioPorEmail(@Bind("email") String email);
}
