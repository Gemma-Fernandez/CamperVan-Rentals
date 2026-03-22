package com.proyectoaa;

import com.proyectoaa.dao.Database;
import com.proyectoaa.dao.UserDao;
import com.proyectoaa.model.User;

import java.time.LocalDate;

public class Maintest {
    public static void main(String[] args) {
        System.out.println("Iniciando prueba de base de datos...");

        // Creamos un usuario falso con datos de prueba
        User usuarioPrueba = new User();
        usuarioPrueba.setNombre("Gemma Tester");
        usuarioPrueba.setEmail("gemma@prueba.com");
        usuarioPrueba.setPassword("123456"); // Más adelante la encriptaremos
        usuarioPrueba.setRol("CLIENTE");
        usuarioPrueba.setSaldoMonedero(150.50);
        usuarioPrueba.setFechaRegistro(LocalDate.now());
        usuarioPrueba.setCuentaActiva(true);

        try {
            // Le pedimos a JDBI que nos prepare el UserDao
            UserDao userDao = Database.getJdbi().onDemand(UserDao.class);

            // Intentamos guardarlo en MariaDB
            boolean exito = userDao.registrarUsuario(usuarioPrueba);

            if (exito) {
                System.out.println("¡ÉXITO! El usuario se ha guardado correctamente en MariaDB.");

                // vamos a buscarlo por su email para confirmar el Login
                User usuarioRecuperado = userDao.obtenerUsuarioPorEmail("gemma@prueba.com");
                System.out.println("🔍 Datos recuperados de la BD: " + usuarioRecuperado.getNombre() + " - " + usuarioRecuperado.getRol());

            } else {
                System.out.println("Vaya, parece que no se ha guardado.");
            }

        } catch (Exception e) {
            System.err.println("Error durante la prueba: " + e.getMessage());
            e.printStackTrace();
        }
    }
}