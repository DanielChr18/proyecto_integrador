package com.proyectoIntegrador.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proyectoIntegrador.entity.Cliente;
import com.proyectoIntegrador.entity.FechasServicios;
import com.proyectoIntegrador.entity.Mascota;
import com.proyectoIntegrador.entity.Servicio;
import com.proyectoIntegrador.service.ClienteService;
import com.proyectoIntegrador.service.FechasServiciosService;
import com.proyectoIntegrador.service.MascotaService;
import com.proyectoIntegrador.service.ServicioService;

@Controller
public class detalleServicioController {

	@Autowired
	private FechasServiciosService service;

	@Autowired
	private ServicioService serviceSer;
	
	@Autowired
	private MascotaService serviceMasc;

	@Autowired
	private ClienteService serviceCli;

	@RequestMapping("/detalleServicios")
	public String detalleServicios(@RequestParam(value = "idServicio", required = false) String idServicio,
			Model modal, HttpServletRequest request) {
		
		HttpSession session = request.getSession(true);
		if (idServicio == null) {
			return "redirect:error404";
		} else {
			int idSer = Integer.parseInt(idServicio);
			Servicio servicio = serviceSer.listaServiciosId(idSer);
			servicio.setNombre(servicio.getNombre().toUpperCase());
			modal.addAttribute("servicio", servicio);
			int numSemana = 0;
			switch (servicio.getDia()) {
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
			 if (session.getAttribute("objIdCliente") != null) {
				System.out.println("Listar Todas las Macotas del Cliente");
				int idCliente = Integer.parseInt(session.getAttribute("objIdCliente").toString());
				// Datos del Cliente
				Cliente cliente = serviceCli.listaClientesId(idCliente);
				modal.addAttribute("clientes", cliente);
				// Datos de la Mascota
				List<Mascota> lista = serviceMasc.listarMascotaCliente(idCliente);
				modal.addAttribute("mascotas", lista);
			}
			modal.addAttribute("objNumeroDia", numSemana);
			return "detalleServicios";
		}
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
