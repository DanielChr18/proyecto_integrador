package com.proyectoIntegrador.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proyectoIntegrador.entity.Marca;
import com.proyectoIntegrador.entity.Producto;
import com.proyectoIntegrador.service.MarcaService;
import com.proyectoIntegrador.service.ProductoService;

@Controller
public class marcaController {

	@Autowired
	private MarcaService service;

	@Autowired
	private ProductoService servicePro;

	@RequestMapping("/crudMarcas")
	public String crudMarcas(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") == null) {
			return "redirect:error403";
		} else if (!session.getAttribute("objCargo").toString().equals("Personal de Ventas")) {
			return "redirect:error403";
		} else {
			System.out.println("Listar Todos las Marcas CRUD");
			List<Marca> lista = service.listaMarcas();
			model.addAttribute("marcas", lista);
			return "crudMarcas";
		}
	}

	@RequestMapping("/registrarMarca")
	public String registrarMarca(Marca obj) {
		try {
			if (obj.getNombre() != null) {
				service.agregarMarca(obj);
				Thread.sleep(2000);
				return "redirect:crudMarcas";
			} else {
				return "redirect:error404";
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		return "redirect:crudMarcas";
	}

	@RequestMapping("/modificarMarca")
	public String modificarMarca(Marca obj) {
		try {
			if (obj.getNombre() != null) {
				service.modificarMarca(obj);
				Thread.sleep(2000);
				return "redirect:crudMarcas";
			} else {
				return "redirect:error404";
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		return "redirect:crudMarcas";
	}

	@RequestMapping("/eliminarMarca")
	public String eliminarMarca(Marca obj) {
		try {
			if (obj.getIdMarca() > 0) {
				System.out.println(obj.getIdMarca());
				service.eliminarMarca(obj.getIdMarca());
				Thread.sleep(2000);
				return "redirect:crudMarcas";
			} else {
				return "redirect:error404";
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		return "redirect:crudMarcas";
	}

	@RequestMapping("/verificarMarca")
	@ResponseBody
	public Map<String, Object> verificarMarca(String idMarca) {
		Map<String, Object> salida = new HashMap<>();
		List<Producto> listaProductos = servicePro.listaProductos();
		String confirmacion = "SI";
		for (Producto p : listaProductos) {
			if (p.getIdMarca().getIdMarca() == Integer.parseInt(idMarca)) {
				confirmacion = "NO";
				break;
			}
		}
		salida.put("CONFIRMACION", confirmacion);
		return salida;
	}
}
