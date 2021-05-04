package com.proyectoIntegrador.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.proyectoIntegrador.entity.DetalleBoleta;

@Controller
public class boletaController {

	@RequestMapping("/detalleBoleta")
	public String detalleBoleta() {
		return "detalleBoleta";
	}

	@RequestMapping("/agregarBoleta")
	public String agregarBoleta(HttpServletRequest request, DetalleBoleta obj) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") != null) {
			if (session.getAttribute("objCargo").equals("Cliente")) {
				return "redirect:listaProductos";
			} else {
				return "redirect:login";
			}
		} else {
			return "redirect:login";
		}
	}
}
