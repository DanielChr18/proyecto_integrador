package com.proyectoIntegrador.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proyectoIntegrador.entity.FechasServicios;
import com.proyectoIntegrador.service.FechasServiciosService;
import com.proyectoIntegrador.service.HorariosServiciosService;
import com.proyectoIntegrador.service.ServicioService;

@Controller
public class detalleServicioController {

	@Autowired
	private FechasServiciosService service;

	@RequestMapping("/detalleServicios")
	public String detalleServicios(@RequestParam(value = "idServicio", required = false) String idServicio,
			@RequestParam(value = "dia", required = false) String dia, HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		if (idServicio == null) {
			return "redirect:error404";
		}
		session.setAttribute("objIdServicio", idServicio);
		int numSemana = 0;
		switch (dia) {
		case "Lunes":
			numSemana = 1;
			break;
		case "Martes":
			numSemana = 2;
			break;
		case "Miércoles":
			numSemana = 3;
			break;
		case "Jueves":
			numSemana = 4;
			break;
		case "Viernes":
			numSemana = 5;
		}
		session.setAttribute("objNumeroDia", numSemana);
		return "detalleServicios";
	}

	@RequestMapping("/fechas")
	@ResponseBody
	public List<FechasServicios> fechas(String idServicio, String fecha) throws ParseException {
		int id = Integer.parseInt(idServicio);
		String fechaNueva = fecha.split("/")[2] + "-" + fecha.split("/")[1] + "-" + fecha.split("/")[0];
		List<FechasServicios> lista = service.findByFechaServicio(fechaNueva, id);
		List<FechasServicios> fechas = new ArrayList<FechasServicios>();
		for (FechasServicios x : lista) {
			if (!x.getEstado().equals("inactivo")) {
				fechas.add(x);
			}
		}
		return fechas;
	}
}
