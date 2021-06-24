package com.proyectoIntegrador.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.proyectoIntegrador.entity.HorariosServicios;
import com.proyectoIntegrador.entity.Producto;
import com.proyectoIntegrador.entity.Servicio;
import com.proyectoIntegrador.service.HorariosServiciosService;
import com.proyectoIntegrador.service.ProductoService;
import com.proyectoIntegrador.service.ServicioService;

@RestController
public class consultasBotController {

	@Autowired
	private ProductoService serviceProducto;

	@Autowired
	private ServicioService serviceServicio;

	@Autowired
	private HorariosServiciosService serviceServicioHorario;

	@GetMapping(produces = "application/json;charset=UTF-8", value = "/consultaProductoBot")
	public ResponseEntity<?> listadoProductosNombre(String opcion,
			@RequestParam(value = "categoria", required = false) String categoria,
			@RequestParam(value = "mascota", required = false) String mascota,
			@RequestParam(value = "nombreServicio", required = false) String nombreServicio,
			@RequestParam(value = "nombreProducto", required = false) String nombreProducto) {

		Map<String, Object> json = new HashMap<>();
		Pageable pageable = PageRequest.of(0, 5);
		String nombres = "";
		try {
			if (opcion.equals("producto")) {
				List<Producto> lista = serviceProducto.consultaProductosChatBot(
						Integer.parseInt((mascota == null ? "-1" : mascota)), (categoria == null ? "" : categoria),
						"%" + (nombreProducto == null ? "" : nombreProducto) + "%", pageable);
				for (Producto x : lista) {
					nombres += x.getNombre() + " con un costo de S/. " + x.getPrecio() + ", ";
				}
			} else if (opcion.equals("servicio")) {
				List<Servicio> lista = serviceServicio
						.consultaServiciosChatBot("%" + (nombreServicio == null ? "" : nombreServicio) + "%", pageable);
				for (Servicio x : lista) {
					if (nombreServicio == null || nombreServicio.equals("")) {
						nombres += x.getNombre() + " con un costo de S/. " + x.getPrecio() + ", ";
					} else {
						nombres += x.getNombre() + " con un costo de S/. " + x.getPrecio()
								+ " donde atendemos los días " + x.getDia() + " en los siguientes horarios : ";
						List<HorariosServicios> listaHorarios = serviceServicioHorario
								.listarHorariosServicios(x.getIdServicio());
						for (HorariosServicios h : listaHorarios) {
							if (!h.getEstado().equals("desactivado")) {
								nombres += h.getHorario() + ", ";
							}
						}
						nombres += "; ";
					}

				}
				nombres = nombres.substring(0, nombres.length() - 2);
			}
			if (nombres.length() != 0)
				json.put("nombres", nombres.substring(0, nombres.length() - 2) + " .");
		} catch (Exception e) {
			e.printStackTrace();
			json.put("nombres", "Error al realizar la consulta, intentelo más tarde.");
		}
		return ResponseEntity.status(HttpStatus.OK).body(json);
	}

}
