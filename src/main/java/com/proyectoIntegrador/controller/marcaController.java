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
	@ResponseBody
	public Map<String, Object> registrarMarca(Marca obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			if (obj.getNombre() != null) {
				List<Marca> listaMarcas = service.listaMarcasNombre(obj.getNombre());
				if (listaMarcas.size() == 0) {
					service.agregarModificarMarca(obj);
					salida.put("CONFIRMACION", "SI");
					salida.put("MENSAJE", "Marca registrada correctamente.");
				} else {
					salida.put("MENSAJE", "El nombre de la marca ya existe.");
				}
			} else {
				salida.put("MENSAJE", "Error al registrar la marca.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al registrar la marca.");
			return salida;
		}
	}

	@RequestMapping("/modificarMarca")
	@ResponseBody
	public Map<String, Object> modificarMarca(Marca obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			if (obj.getNombre() != null) {
				List<Marca> listaMarcas = service.listaMarcasNombreDiferenteId(obj.getIdMarca(), obj.getNombre());
				if (listaMarcas.size() == 0) {
					service.agregarModificarMarca(obj);
					salida.put("CONFIRMACION", "SI");
					salida.put("MENSAJE", "Marca modificada correctamente.");
				} else {
					salida.put("MENSAJE", "El nombre de la marca ya existe.");
				}
			} else {
				salida.put("MENSAJE", "Error al modificar la marca.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al modificar la marca.");
			return salida;
		}
	}

	@RequestMapping("/eliminarMarca")
	@ResponseBody
	public Map<String, Object> eliminarMarca(Marca obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			if (obj.getIdMarca() > 0) {
				service.eliminarMarca(obj.getIdMarca());
				salida.put("CONFIRMACION", "SI");
				salida.put("MENSAJE", "Marca eliminada correctamente.");
			} else {
				salida.put("MENSAJE", "Error al eliminar la marca.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al eliminar la marca.");
			return salida;
		}
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
