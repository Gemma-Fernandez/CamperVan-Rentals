package com.proyectoaa.model;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Vehicle {
    private Integer idVehiculo;
    private String modelo;
    private String matricula;
    private String imagenUrl;
    private Integer capacidadPasajeros;
    private Double precioPorDia;
    private LocalDate fechaAltaFlota;
    private Boolean disponible;
}
