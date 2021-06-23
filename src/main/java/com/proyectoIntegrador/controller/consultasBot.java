package com.proyectoIntegrador.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.proyectoIntegrador.entity.Producto;
import com.proyectoIntegrador.service.ProductoService;

@RestController
public class consultasBot {

	@Autowired
	private ProductoService service;

	@GetMapping(produces = "application/json", value = "/consultaProductoBot")
	public List<Producto> listadoProductosNombre(String nombreArticulo) {
		System.out.println("Listar Productos por Nombre : Filtro -----> " + nombreArticulo);
		List<Producto> lista = service.listaProductosNombre("%" + nombreArticulo + "%");
		return lista;
	}

}
