package com.proyectoIntegrador.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.proyectoIntegrador.entity.Producto;
import com.proyectoIntegrador.service.ProductoService;

@RestController
public class consultasBot {

	@Autowired
	private ProductoService service;

	@GetMapping(produces = "application/json;charset=UTF-8", value = "/consultaProductoBot")
	public Map<String, Object> listadoProductosNombre() {
		Map<String, Object> json = new HashMap<>();
		List<Producto> lista = service.listaProductosNombre("%" + "r" + "%");
		String nombres = "";
		for (Producto x : lista) {
			nombres += x.getDescripcion() + ",";
		}

		if (nombres.length() != 0)
			json.put("nombres", nombres.substring(0, nombres.length() - 1));
		System.out.println(json);
		return json;
	}

}
