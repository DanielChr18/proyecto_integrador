package com.proyectoIntegrador.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.proyectoIntegrador.entity.HistorialMascota;
import com.proyectoIntegrador.entity.Reserva;
import com.proyectoIntegrador.entity.Trabajador;
import com.proyectoIntegrador.service.HistorialMascotaService;

import com.proyectoIntegrador.service.MascotaService;
import com.proyectoIntegrador.service.ReservaService;
import com.proyectoIntegrador.service.TrabajadorService;

@Controller
public class historialMascotaController {



	@Autowired
	private HistorialMascotaService service;

	@Autowired
	private TrabajadorService serviceTra;
	
	@Autowired
	private MascotaService serviceMas;

	@Autowired
	private ReservaService serviceReser;
	

	@RequestMapping("/registrarHistorialMascota")
	@ResponseBody
	public Map<String, Object> editarReserva(HttpServletRequest request,String descripcionLarga,String idReserva) {
		Map<String, Object> salida = new HashMap<>();
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") != null) {
			if (session.getAttribute("objCargo").equals("Veterinario")) {
				HistorialMascota obj = new HistorialMascota();
				
				int idTrabajador=Integer.parseInt(session.getAttribute("objIdTrabajador").toString());
				
				Trabajador trabajador = new Trabajador();
				
				trabajador.setIdTrabajador(idTrabajador);
				
				
				
				
				obj.setFecha(LocalDate.now().toString().split("T")[0]);
				obj.setHora(LocalDateTime.now().toString());
				obj.setDescripcion(descripcionLarga);
				obj.setIdTrabajador(trabajador);
				
				
			
			
				
				service.registrarHistorialMas(obj);
				
				Reserva reserva = serviceReser.listarReservasId(Integer.parseInt(idReserva));
				reserva.setEstado("realizado");
				serviceReser.actualizaReserva(reserva);
				
				
				
				
				
		
	
		
			
		
				
				salida.put("CONFIRMACION", "SI");
				salida.put("MENSAJE", "Éxito al registrar la cita para historial de mascota.");
				return salida;
			}
		}
		salida.put("CONFIRMACION", "NO");
		salida.put("MENSAJE", "Error al registrar.");
		return salida;
	}
	

	
	
	
}