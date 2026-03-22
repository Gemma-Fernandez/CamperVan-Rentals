package com.proyectoaa.dao;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;



public class Database {

    private static Jdbi jdbi;

    public static void connect() {
        if (jdbi == null) {
            try {
                Class.forName("org.mariadb.jdbc.Driver");

                String url = "jdbc:mariadb://localhost:3306/campervan_rentals";
                String usuario = "root";
                String contrasena = "1234";

                jdbi = Jdbi.create(url, usuario, contrasena);
                jdbi.installPlugin(new SqlObjectPlugin());

                System.out.println("Conexión exitosa a la base de datos con JDBI.");

            } catch (Exception e) {
                System.out.println("Error al conectar: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }

    public static Jdbi getJdbi() {
        if (jdbi == null) {
            connect();
        }
        return jdbi;
    }
}
