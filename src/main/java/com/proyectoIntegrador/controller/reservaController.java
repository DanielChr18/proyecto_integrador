package com.proyectoIntegrador.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proyectoIntegrador.entity.FechasServicios;
import com.proyectoIntegrador.entity.HorariosServicios;
import com.proyectoIntegrador.entity.Reserva;
import com.proyectoIntegrador.service.ClienteService;
import com.proyectoIntegrador.service.FechasServiciosService;
import com.proyectoIntegrador.service.HorariosServiciosService;
import com.proyectoIntegrador.service.ReservaService;

@Controller
public class reservaController {



	@Autowired
	private ReservaService service;

	@Autowired
	private ClienteService serviceCli;

	@Autowired
	private HorariosServiciosService serviceHor;

	@Autowired
	private FechasServiciosService serviceFec;

	@RequestMapping("/registrarReserva")
	public String registrarReserva(HttpServletRequest request, Reserva obj) {
		HttpSession session = request.getSession(true);
		try {
			if (session.getAttribute("objIdCliente") != null) {
				int idCliente = Integer.parseInt(session.getAttribute("objIdCliente").toString());
				String fec = obj.getFecha().substring(6, 10) + "-" + obj.getFecha().substring(3, 5) + "-"
						+ obj.getFecha().substring(0, 2);
				obj.setFecha(fec);
				obj.setEstado("pendiente de pago");
				obj.setIdCliente(serviceCli.listaClientesId(idCliente));
				service.registrarReserva(obj);
				HorariosServicios horario = serviceHor.listarHoraServicio(obj.getIdServicio().getIdServicio(),
						obj.getHorario());
				horario.setEstado("reservado");
				serviceHor.agregarHorario(horario);
				List<FechasServicios> fechas = serviceFec.findByFechaServicio(obj.getFecha(),
						obj.getIdServicio().getIdServicio());
				for (FechasServicios f : fechas) {
					if (f.getIdHorariosServicios().getIdHorariosServicios() == horario.getIdHorariosServicios()) {
						f.setEstado("reservado");
						serviceFec.agregarFechaServicio(f);
						break;
					}
				}
				Thread.sleep(2000);
				return "redirect:listaServicios";
			} else {
				return "redirect:error404";
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
			return "redirect:error404";
		}
	}

	@RequestMapping("/editarReserva")
	@ResponseBody
	public Map<String, Object> editarReserva(HttpServletRequest request, String idReserva, String estado) {
		Map<String, Object> salida = new HashMap<>();
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") != null) {
			if (session.getAttribute("objCargo").equals("Personal de Ventas")) {
				Reserva reserva = service.listarReservasId(Integer.parseInt(idReserva));
				reserva.setEstado(estado);
				service.actualizaReserva(reserva);
				salida.put("CONFIRMACION", "SI");
				salida.put("MENSAJE", "Éxito al editar la Reserva.");
				return salida;
			}
		}
		salida.put("CONFIRMACION", "NO");
		salida.put("MENSAJE", "Error al editar la Reserva.");
		return salida;
	}
	
	@RequestMapping("/pagarReserva")
	@ResponseBody
	public Map<String, Object> pagarReserva(HttpServletRequest request, String idReserva) {
		Map<String, Object> salida = new HashMap<>();
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") != null) {
			if (session.getAttribute("objCargo").equals("Cliente")) {
				Reserva reserva = service.listarReservasId(Integer.parseInt(idReserva));
				reserva.setEstado("pagado");
				service.actualizaReserva(reserva);
				salida.put("CONFIRMACION", "SI");
				salida.put("MENSAJE", "Éxito al editar la Reserva.");
				return salida;
			}
		}
		salida.put("CONFIRMACION", "NO");
		salida.put("MENSAJE", "Error al editar la Reserva.");
		return salida;
	}

	@RequestMapping("/validacionReservaServicio")
	@ResponseBody
	public Map<String, Object> validacionReservaServicio(String idMascota, String idServicio, String fecha,
			String horario) {
		Map<String, Object> salida = new HashMap<>();
		int id = Integer.parseInt(idMascota);
		String f = fecha.substring(6, 10) + "-" + fecha.substring(3, 5) + "-" + fecha.substring(0, 2);
		List<Reserva> reservasMascota = service.listarReservasMascota(id);
		for (Reserva r : reservasMascota) {
			if (r.getIdServicio().getIdServicio() == Integer.parseInt(idServicio)) {
				salida.put("CONFIRMACION", "NO");
				salida.put("MENSAJE", "La mascota ya tiene una reserva del mismo servicio.");
				return salida;
			} else if (r.getFecha().equals(f) && r.getHorario().equals(horario)) {
				salida.put("CONFIRMACION", "NO");
				salida.put("MENSAJE", "La mascota tiene una reserva el mismo día y hora que se seleccionó.");
				return salida;
			}
		}
		salida.put("CONFIRMACION", "SI");
		salida.put("MENSAJE", "Reserva realizada con éxito.");
		return salida;
	}
}
