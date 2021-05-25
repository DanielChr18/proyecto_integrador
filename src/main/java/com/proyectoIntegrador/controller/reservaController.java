package com.proyectoIntegrador.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


import com.proyectoIntegrador.entity.Reserva;
import com.proyectoIntegrador.service.ReservaService;

@Controller
public class reservaController {
	
	@Autowired
	private ReservaService service;
	
	
	@RequestMapping("/registrarReserva")
	public String registrarReserva(Reserva obj) {
		try {
			obj.setFecha("2021-05-26");
			if (obj.getFecha() != null) {
				obj.setEstado("aea");			
				service.registrarReserva(obj);
				Thread.sleep(2000);
				return "redirect:listaProductos";
			} else {
				return "redirect:error404";
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		return "redirect:crudMarcas";
	}

	
	

}
