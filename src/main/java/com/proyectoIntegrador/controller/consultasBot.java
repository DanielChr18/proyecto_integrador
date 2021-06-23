package com.proyectoIntegrador.controller;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.proyectoIntegrador.entity.Producto;
import com.proyectoIntegrador.service.ProductoService;

@RestController
public class consultasBot {

	@Autowired
	private ProductoService service;

	@GetMapping(produces = "application/json;charset=UTF-8", value = "/consultaProductoBot")
	public String listadoProductosNombre() {
		List<Producto> lista = service.listaProductosNombre("%" + "r" + "%");
		Gson gson = new Gson();
		JSONObject jsonObject = new JSONObject();
		String nombres = "";
		for (Producto x : lista) {
			nombres += x.getDescripcion() + ",";
		}

		if (nombres.length() != 0)
			jsonObject.put("nombres", nombres.substring(0, nombres.length() - 1));
		String jsonInString = gson.toJson(jsonObject);
		return jsonInString;
	}

}
