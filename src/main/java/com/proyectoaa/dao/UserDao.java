package com.proyectoaa.dao;

import  com.proyectoaa.model.User;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.customizer.BindBean;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;

import java.util.List;

public interface UserDao {

    //Para dar de alta
    @SqlUpdate("INSERT INTO usuarios (nombre, email, password, rol, saldo_monedero, fecha_registro, cuenta_activa) VALUES (:nombre, :email, :password, :rol, :saldoMonedero, :fechaRegistro, :cuentaActiva)")
    boolean registrarUsuario(@BindBean User user);

    //Para el login
    @SqlQuery("SELECT * FROM usuarios WHERE email = :email")
    @RegisterBeanMapper(User.class)
    User obtenerUsuarioPorEmail(@Bind("email") String email);

    // Listar todos users registrados (panel de Admin)
    @SqlQuery("SELECT * FROM usuarios ORDER BY id_usuario DESC")
    @RegisterBeanMapper(User.class)
    List<User> obtenerTodos();

    // Buscar un único usuario por su ID
    @SqlQuery("SELECT * FROM usuarios WHERE id_usuario = :id")
    @RegisterBeanMapper(User.class)
    User obtenerPorId(@Bind("id") Integer id);

    // Eliminar un usuario de la base de datos
    @SqlUpdate("DELETE FROM usuarios WHERE id_usuario = :id")
    int borrarUsuario(@Bind("id") Integer id);

    // Modificar los datos de un usuario
    @SqlUpdate("UPDATE usuarios SET nombre = :nombre, email = :email, rol = :rol WHERE id_usuario = :id")
    int modificarUsuario(@Bind("id") Integer id, @Bind("nombre") String nombre, @Bind("email") String email, @Bind("rol") String rol);

    // Buscador doble de Usuarios: Nombre Y Rol
    @SqlQuery("SELECT * FROM usuarios WHERE nombre LIKE CONCAT('%', :nombre, '%') AND rol LIKE CONCAT('%', :rol, '%')")
    @RegisterBeanMapper(User.class)
    List<User> buscarUsuariosDoble(@Bind("nombre") String nombre, @Bind("rol") String rol);
}
