package com.proyectoIntegrador.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.proyectoIntegrador.entity.Cliente;
import com.proyectoIntegrador.entity.Mascota;
import com.proyectoIntegrador.service.ClienteService;
import com.proyectoIntegrador.service.MascotaService;

@Controller
public class mascotaController {

	@Autowired
	private MascotaService service;

	@Autowired
	private ClienteService serviceCli;

	@RequestMapping("/datosMascotas")
	public String listaServicios(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objIdCliente") != null) {
			System.out.println("Listar Todas las Macotas del Cliente");
			int idCliente = Integer.parseInt(session.getAttribute("objIdCliente").toString());
			// Datos del Cliente
			Cliente cliente = serviceCli.listaClientesId(idCliente);
			model.addAttribute("clientes", cliente);
			// Datos de la Mascota
			List<Mascota> lista = service.listarMascotaCliente(idCliente);
			model.addAttribute("mascotas", lista);
		}
		return "datosMascotas";
	}

	@RequestMapping("/registrarMascota")
	public String agregarMascota(HttpServletRequest request, Mascota obj) {
		if (obj.getNombre() != null) {
			System.out.println("|---------- En Registro de Mascota ----------|");
			service.agregarMascota(obj);
			return "redirect:datosMascotas";
		} else {
			return "redirect:error404";
		}
	}

	@RequestMapping("/modificarMascota")
	public String modificarProducto(Mascota obj) {
		if (obj.getNombre() != null) {
			System.out.println("id ---------> " + obj.getIdMascota());
			service.modificarMascota(obj);
			return "redirect:datosMascotas";
		} else {
			return "redirect:error404";
		}

	}

	@RequestMapping("/eliminarMascota")
	public String eliminarProducto(Mascota obj) {
		if (obj.getIdMascota() > 0) {
			System.out.println(obj.getIdMascota());
			service.eliminarMascota(obj.getIdMascota());
			return "redirect:datosMascotas";
		} else {
			return "redirect:error404";
		}
	}

}
