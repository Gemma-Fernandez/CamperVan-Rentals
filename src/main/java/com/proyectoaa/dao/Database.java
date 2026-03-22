package com.proyectoaa.dao;


import lombok.Getter;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;



public class Database {
    @Getter

    private static Connection connection;
    public static void connect() throws ClassNotFoundException, SQLException {
        if (connection == null) {
            try {
                Class.forName("org.mariadb.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/campervan_rentals", "root", "1234");
                System.out.println("Conexión exitosa a la base de datos.");
            }catch (Exception e){
                System.out.println("Error al conectar: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }

    public static void close() throws SQLException{
        connection.close();

    }
}
