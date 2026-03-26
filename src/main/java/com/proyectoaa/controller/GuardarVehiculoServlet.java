package com.proyectoaa.controller;

import com.proyectoaa.dao.Database;
import com.proyectoaa.dao.VehicleDao;
import com.proyectoaa.model.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;

    @WebServlet("/guardarVehiculo")
    @MultipartConfig(
            fileSizeThreshold = 1024 * 1024 * 2,  // 2MB (Si es más pequeño, lo guarda en memoria RAM)
            maxFileSize = 1024 * 1024 * 10,       // 10MB (Tamaño máximo)
            maxRequestSize = 1024 * 1024 * 50     // 50MB (Tamaño máximo de toda la petición)
    )
    public class GuardarVehiculoServlet extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            //Recogemos los textos del formulario
            String modelo = request.getParameter("modelo");
            String matricula = request.getParameter("matricula");
            Integer capacidad = Integer.parseInt(request.getParameter("capacidadPasajeros"));
            Double precio = Double.parseDouble(request.getParameter("precioPorDia"));

            //PREPARAMOS LA CARPETA PARA LA FOTO
            // Buscamos dónde está corriendo Tomcat y creamos una carpeta "uploads"
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir(); // Si carpeta no existe, la creamos
            }

            //RECOGEMOS LA FOTO
            Part filePart = request.getPart("imagen");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // No puede haber dos fotos que se llamen igual
            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;

            //Guardamos la foto en el disco duro
            filePart.write(uploadPath + File.separator + uniqueFileName);

            //Creamos el objeto Vehículo para la base de datos
            Vehicle nuevoVehiculo = new Vehicle();
            nuevoVehiculo.setModelo(modelo);
            nuevoVehiculo.setMatricula(matricula);
            nuevoVehiculo.setCapacidadPasajeros(capacidad);
            nuevoVehiculo.setPrecioPorDia(precio);
            nuevoVehiculo.setFechaAltaFlota(LocalDate.now());
            nuevoVehiculo.setDisponible(true);

            //Guardamos la ruta para que la web sepa dónde buscar
            nuevoVehiculo.setImagenUrl("uploads/" + uniqueFileName);

            //Lo metemos en la Base de Datos
            VehicleDao vehicleDao = Database.getJdbi().onDemand(VehicleDao.class);
            vehicleDao.insertarVehiculo(nuevoVehiculo);

            //Volvemos al panel del admin
            response.sendRedirect("adminDashboard.jsp?vehiculoOk=true");
        }
    }


