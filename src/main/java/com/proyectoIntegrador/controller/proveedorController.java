package com.proyectoIntegrador.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proyectoIntegrador.entity.Proveedor;
import com.proyectoIntegrador.service.ProveedorServicio;

@Controller
public class proveedorController {

	@Autowired
	private ProveedorServicio service;

	@RequestMapping("/listaProveedores")
	public String listaProveedores(Model model) {
		System.out.println("Listar Todas las Proveedores");
		List<Proveedor> lista = service.listaProveedores();
		model.addAttribute("proveedores", lista);
		return "listaProveedores";
	}

	@RequestMapping("/listadoProveedorNombre")
	@ResponseBody
	public List<Proveedor> listadoProveedoresNombre(String nombreProveedor) {
		System.out.println("Listar Proveedores por Nombre : Filtro -----> " + nombreProveedor);
		List<Proveedor> lista = service.ListaProveedoresNombre(nombreProveedor);
		return lista;
	}

	@RequestMapping("/crudProveedores")
	public String verProveedores(Model model) {
		System.out.println("Listar Todos las Proveedores CRUD");
		List<Proveedor> lista = service.listaProveedores();
		model.addAttribute("proveedores", lista);
		return "crudProveedores";
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
}
