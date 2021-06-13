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
	@ResponseBody
	public Map<String, Object> registrarProveedor(Proveedor obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			if (obj.getRazonSocial() != null) {
				List<Proveedor> listaProvRaz = service.listaProveedoresRazonSocial(obj.getRazonSocial());
				List<Proveedor> listaProvRuc = service.listaProveedoresRuc(obj.getRuc());
				if (listaProvRaz.size() == 0 && listaProvRuc.size() == 0) {
					service.agregarModificarProveedor(obj);
					salida.put("CONFIRMACION", "SI");
					salida.put("MENSAJE", "Proveedor registrado correctamente.");
				} else if (listaProvRaz.size() > 0) {
					salida.put("MENSAJE", "La razón social del proveedor ya existe.");
				} else if (listaProvRuc.size() > 0) {
					salida.put("MENSAJE", "El R.U.C. del proveedor ya existe.");
				}
			} else {
				salida.put("MENSAJE", "Error al registrar el proveedor.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al registrar el proveedor.");
			return salida;
		}
	}

	@RequestMapping("/modificarProveedor")
	@ResponseBody
	public Map<String, Object> modificarProveedor(Proveedor obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			if (obj.getRazonSocial() != null) {
				List<Proveedor> listaProvRaz = service.listaProveedoresRazonSocialDiferenteId(obj.getIdProveedor(),
						obj.getRazonSocial());
				List<Proveedor> listaProvRuc = service.listaProveedoresRucDiferenteId(obj.getIdProveedor(),
						obj.getRuc());
				if (listaProvRaz.size() == 0 && listaProvRuc.size() == 0) {
					service.agregarModificarProveedor(obj);
					salida.put("CONFIRMACION", "SI");
					salida.put("MENSAJE", "Proveedor modificado correctamente.");
				} else if (listaProvRaz.size() > 0) {
					salida.put("MENSAJE", "La razón social del proveedor ya existe.");
				} else if (listaProvRuc.size() > 0) {
					salida.put("MENSAJE", "El R.U.C. del proveedor ya existe.");
				}
			} else {
				salida.put("MENSAJE", "Error al modificar el proveedor.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al modificar el proveedor.");
			return salida;
		}
	}

	@RequestMapping("/eliminarProveedor")
	@ResponseBody
	public Map<String, Object> eliminarProveedor(Proveedor obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			if (obj.getIdProveedor() > 0) {
				service.eliminarProveedor(obj.getIdProveedor());
				salida.put("CONFIRMACION", "SI");
				salida.put("MENSAJE", "Proveedor eliminado correctamente.");
			} else {
				salida.put("MENSAJE", "Error al eliminar el proveedor.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al eliminar el proveedor.");
			return salida;
		}
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
