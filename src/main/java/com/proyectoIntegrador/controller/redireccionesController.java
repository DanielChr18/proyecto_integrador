package com.proyectoIntegrador.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.proyectoIntegrador.entity.Boleta;
import com.proyectoIntegrador.entity.Reserva;
import com.proyectoIntegrador.service.BoletaService;
import com.proyectoIntegrador.service.ReservaService;

@Controller
public class redireccionesController {

	@Autowired
	private BoletaService serviceBoleta;

	@Autowired
	private ReservaService serviceReserva;

	@RequestMapping("/error404")
	public String error404() {
		return "error404";
	}

	@RequestMapping("/principal")
	public String principal() {
		return "principal";
	}

	@RequestMapping("/nosotros")
	public String nosotros() {
		return "nosotros";
	}

	@RequestMapping("/trackingCliente")
	public String trackingCliente(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objIdCliente") != null) {
			List<Boleta> listaPedidos = serviceBoleta
					.listarBoletasCliente(session.getAttribute("objIdCliente").toString());
			model.addAttribute("pedidos", listaPedidos);
			List<Reserva> listaServicios = serviceReserva
					.listarReservasCliente(session.getAttribute("objIdCliente").toString());
			model.addAttribute("servicios", listaServicios);
		}
		return "trackingCliente";
	}
}
