package com.proyectoIntegrador.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.proyectoIntegrador.service.ProductoService;

@RestController
public class consultasBot {

	@Autowired
	private ProductoService service;

	@GetMapping(produces = "application/json;charset=UTF-8", value = "/consultaProductoBot")
	public String listadoProductosNombre() {
		return "";
	}
}
