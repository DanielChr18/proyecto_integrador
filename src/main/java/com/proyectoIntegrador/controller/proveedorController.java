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

import com.proyectoIntegrador.entity.Producto;
import com.proyectoIntegrador.entity.Proveedor;
import com.proyectoIntegrador.service.ProductoService;
import com.proyectoIntegrador.service.ProveedorService;

@Controller
public class proveedorController {

	@Autowired
	private ProveedorService service;

	@Autowired
	private ProductoService servicePro;

	@RequestMapping("/crudProveedores")
	public String crudProveedores(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") == null) {
			return "redirect:error403";
		} else if (!session.getAttribute("objCargo").toString().equals("Personal de Ventas")) {
			return "redirect:error403";
		} else {
			System.out.println("Listar Todos las Proveedores CRUD");
			List<Proveedor> lista = service.listaProveedores();
			model.addAttribute("proveedores", lista);
			return "crudProveedores";
		}
	}

	@RequestMapping("/registrarProveedor")
	public String registrarProveedor(Proveedor obj) {
		try {
			if (obj.getRazonSocial() != null) {
				service.agregarProveedor(obj);
				Thread.sleep(2000);
				return "redirect:crudProveedores";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:crudProveedores";
	}

	@RequestMapping("/modificarProveedor")
	public String modificarProveedor(Proveedor obj) {
		try {
			if (obj.getRazonSocial() != null) {
				service.modificarProveedor(obj);
				Thread.sleep(2000);
				return "redirect:crudProveedores";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:crudProveedores";
	}

	@RequestMapping("/eliminarProveedor")
	public String eliminarProveedor(Proveedor obj) {
		try {
			if (obj.getIdProveedor() > 0) {
				System.out.println(obj.getIdProveedor());
				service.eliminarProveedor(obj.getIdProveedor());
				Thread.sleep(2000);
				return "redirect:crudProveedores";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:crudProveedores";
	}

	@RequestMapping("/verificarProveedor")
	@ResponseBody
	public Map<String, Object> verificarProveedor(String idProveedor) {
		Map<String, Object> salida = new HashMap<>();
		List<Producto> listaProductos = servicePro.listaProductos();
		String confirmacion = "SI";
		for (Producto p : listaProductos) {
			if (p.getIdProveedor().getIdProveedor() == Integer.parseInt(idProveedor)) {
				confirmacion = "NO";
				break;
			}
		}
		salida.put("CONFIRMACION", confirmacion);
		return salida;
	}
}
