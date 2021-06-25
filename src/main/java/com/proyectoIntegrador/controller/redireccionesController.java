package com.proyectoIntegrador.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.proyectoIntegrador.entity.Boleta;
import com.proyectoIntegrador.entity.Cliente;
import com.proyectoIntegrador.entity.HistorialMascota;
import com.proyectoIntegrador.entity.Reserva;
import com.proyectoIntegrador.service.BoletaService;
import com.proyectoIntegrador.service.ClienteService;
import com.proyectoIntegrador.service.HistorialMascotaService;
import com.proyectoIntegrador.service.ReservaService;

@Controller
public class redireccionesController {

	@Autowired
	private BoletaService serviceBoleta;

	@Autowired
	private ReservaService serviceReserva;

	@Autowired
	private ClienteService serviceCliente;

	@Autowired
	private HistorialMascotaService serviceHistorialMascota;

	@RequestMapping("/error403")
	public String error403() {
		return "error403";
	}

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

	@RequestMapping("/historialMascotas")
	public String historialMascotas(HttpServletRequest request, Model model) {
		try {
			HttpSession session = request.getSession(true);
			if (session.getAttribute("objCargo") != null) {
				if (session.getAttribute("objCargo").equals("Veterinario")) {
					List<Reserva> listaServicios = serviceReserva.listarReservas();
					List<HistorialMascota> listaHistorialMascota = serviceHistorialMascota
							.listarHistorialMascotaNombre("%");
					model.addAttribute("reservas", listaServicios == null ? null : listaServicios);
					model.addAttribute("historiales", listaHistorialMascota == null ? null : listaHistorialMascota);
					return "historialMascotas";
				} else if (session.getAttribute("objCargo").equals("Cliente")) {
					List<HistorialMascota> listaHistorialMascota = serviceHistorialMascota
							.listarHistorialMascotaNombre("%");
					model.addAttribute("historiales", listaHistorialMascota == null ? null : listaHistorialMascota);
					return "historialMascotas";
				}
			}
			return "redirect:error403";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:error404";
		}
	}

	@RequestMapping("/trackingCliente")
	public String trackingCliente(HttpServletRequest request, Model model) {
		try {
			HttpSession session = request.getSession(true);
			if (session.getAttribute("objCargo") != null) {
				if (session.getAttribute("objCargo").equals("Personal de Ventas")) {
					List<Boleta> listaPedidos = serviceBoleta.listarBoletas();
					List<Reserva> listaServicios = serviceReserva.listarReservas();
					model.addAttribute("pedidos", listaPedidos == null ? null : listaPedidos);
					model.addAttribute("servicios", listaServicios == null ? null : listaPedidos);
					return "trackingCliente";
				} else if (session.getAttribute("objCargo").equals("Cliente")) {
					int idCliente = Integer.parseInt(session.getAttribute("objIdCliente").toString());
					List<Boleta> listaPedidos = serviceBoleta.listarBoletasCliente(idCliente);
					List<Reserva> listaServicios = serviceReserva.listarReservasCliente(idCliente);
					model.addAttribute("pedidos", listaPedidos == null ? null : listaPedidos);
					model.addAttribute("servicios", listaServicios == null ? null : listaServicios);
					return "trackingCliente";
				}
			}
			return "redirect:error403";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:error404";
		}
	}
}
