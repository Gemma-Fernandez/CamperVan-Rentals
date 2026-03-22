package com.proyectoaa.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private Integer idUsuario;
    private String nombre;
    private String email;
    private String password;
    private String rol;
    private Double saldoMonedero;
    private LocalDate fechaRegistro;
    private Boolean cuentaActiva;
}
