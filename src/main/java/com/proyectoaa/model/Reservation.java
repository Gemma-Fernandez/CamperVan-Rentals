package com.proyectoaa.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class Reservation {
    private Integer idReserva;
    private Integer idUsuario;
    private Integer idVehiculo;
    private String observacionesCliente;
    private Integer diasAlquiler;
    private Double costeTotal;
    private LocalDate fechaInicioViaje;
    private Boolean pagadaPorCompleto;
    private String nombreUsuario;
    private String modeloVehiculo;
}
