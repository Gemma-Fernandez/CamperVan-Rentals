package com.proyectoaa.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor


public class Maintenance {
    private Integer idMantenimiento;
    private Integer idVehiculo;
    private String descripcionTaller;
    private Double costeReparacion;
    private LocalDate fechaRevision;
    private Boolean itvSuperada;
}
