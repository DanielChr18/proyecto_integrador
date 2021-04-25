package com.proyectoIntegrador.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proyectoIntegrador.entity.Marca;
import com.proyectoIntegrador.service.MarcaService;

@Controller
public class marcaController {

	@Autowired
	private MarcaService service;

	@RequestMapping("/listaMarcas")
	public String listaMarcas(Model model) {
		System.out.println("Listar Todas las Marcas");
		List<Marca> lista = service.listaMarcas();
		model.addAttribute("marcas", lista);
		return "listaMarcas";
	}

	@RequestMapping("/listadoMarcaNombre")
	@ResponseBody
	public List<Marca> listadoMarcasNombre(String nombreMarca) {
		System.out.println("Listar Marcas por Nombre : Filtro -----> " + nombreMarca);
		List<Marca> lista = service.ListaMarcasNombre(nombreMarca);
		return lista;
	}

	@RequestMapping("/crudMarcas")
	public String verMarcas(Model model) {
		System.out.println("Listar Todos las Marcas CRUD");
		List<Marca> lista = service.listaMarcas();
		model.addAttribute("marcas", lista);
		return "crudMarcas";
	}

	@RequestMapping("/registrarMarca")
	public String registrarMarca(Marca obj) {
		if (obj.getNombre() != null) {
			service.agregarMarca(obj);
		} else {
			return "redirect:error404";
		}
		return "redirect:crudMarcas";
	}

	@RequestMapping("/modificarMarca")
	public String modificarMarca(Marca obj) {
		if (obj.getNombre() != null) {
			service.modificarMarca(obj);
		} else {
			return "redirect:error404";
		}
		return "redirect:crudMarcas";
	}

	@RequestMapping("/eliminarMarca")
	public String eliminarMarca(Marca obj) {
		if (obj.getIdMarca() > 0) {
			System.out.println(obj.getIdMarca());
			service.eliminarMarca(obj.getIdMarca());
			return "redirect:crudMarcas";
		} else {
			return "redirect:error404";
		}
	}
}
