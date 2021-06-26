package com.proyectoIntegrador.controller;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proyectoIntegrador.entity.FechasServicios;
import com.proyectoIntegrador.entity.HistorialMascota;
import com.proyectoIntegrador.entity.HorariosServicios;
import com.proyectoIntegrador.entity.Reserva;
import com.proyectoIntegrador.entity.Trabajador;
import com.proyectoIntegrador.service.FechasServiciosService;
import com.proyectoIntegrador.service.HistorialMascotaService;
import com.proyectoIntegrador.service.HorariosServiciosService;
import com.proyectoIntegrador.service.ReservaService;

@Controller
public class historialMascotaController {

	@Autowired
	private HistorialMascotaService service;

	@Autowired
	private HorariosServiciosService serviceHorSer;

	@Autowired
	private FechasServiciosService serviceFecSer;

	@Autowired
	private ReservaService serviceReser;

	@RequestMapping("/registrarHistorialMascota")
	@Transactional
	@ResponseBody
	public Map<String, Object> editarReserva(HttpServletRequest request, String descripcionLarga, String idReserva) {
		Map<String, Object> salida = new HashMap<>();
		try {
			HttpSession session = request.getSession(true);
			if (session.getAttribute("objCargo") != null) {
				if (session.getAttribute("objCargo").equals("Veterinario")) {
					HistorialMascota obj = new HistorialMascota();

					int idTrabajador = Integer.parseInt(session.getAttribute("objIdTrabajador").toString());

					Trabajador trabajador = new Trabajador();

					trabajador.setIdTrabajador(idTrabajador);

					Reserva reser = new Reserva();
					reser.setIdReserva(Integer.parseInt(idReserva));

					obj.setFecha(LocalDateTime.now().toString().split("T")[0]);
					obj.setHora(LocalTime.now().toString().substring(0, 8));
					obj.setDescripcion(descripcionLarga);
					obj.setIdTrabajador(trabajador);
					obj.setIdReserva(reser);

					service.registrarHistorialMas(obj);

					Reserva reserva = serviceReser.listarReservasId(Integer.parseInt(idReserva));
					reserva.setEstado("realizado");
					serviceReser.actualizaReserva(reserva);

					HorariosServicios horarioServicio = serviceHorSer
							.listarHoraServicio(reserva.getIdServicio().getIdServicio(), reserva.getHorario());

					FechasServicios fechaServicio = serviceFecSer
							.findByHoraFechaServicio(horarioServicio.getIdHorariosServicios(), reserva.getFecha());

					serviceFecSer.eliminarFechaServicio(fechaServicio.getIdFechasServicios());

					List<FechasServicios> listaFechasServicio = serviceFecSer
							.findByServicio(reserva.getIdServicio().getIdServicio());
					String confirmar = "SI";
					for (FechasServicios f : listaFechasServicio) {
						if (f.getEstado().equals("ocupado")) {
							confirmar = "NO";
							break;
						}
					}

					if (confirmar.equals("SI")) {
						horarioServicio.setEstado("activado");
						serviceHorSer.agregarHorario(horarioServicio);
					}
					salida.put("CONFIRMACION", "SI");
					salida.put("MENSAJE", "Éxito al registrar la cita para historial de mascota.");
					return salida;
				}
			}
			salida.put("MENSAJE", "Error al registrar.");
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al registrar.");
			return salida;
		}
	}

	@RequestMapping("/obtenerHtmlHistorialMascota")
	@ResponseBody
	public HistorialMascota obtenerHtmlHistorialMascota(String idHistorialMascota) {
		int id = Integer.parseInt(idHistorialMascota);
		return service.listarHistorialMascotaId(id);
	}

	@RequestMapping("/listarHistorialMascotaNombre")
	@ResponseBody
	public List<HistorialMascota> listarHistorialMascotaNombre(String nombreMascotaP, HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		List<HistorialMascota> lista = service.listarHistorialMascotaNombreCliente(
				Integer.parseInt(session.getAttribute("objIdCliente").toString()), "%" + nombreMascotaP + "%");
		return lista;
	}

	@RequestMapping("/listarHistorialClienteNombre")
	@ResponseBody
	public List<HistorialMascota> listarHistorialClienteNombre(String nombreClienteHistorial) {
		System.out.println("Listar Cliente por Nombre : Filtro -----> " + nombreClienteHistorial);
		List<HistorialMascota> lista = service.listarHistorialClienteNombre("%" + nombreClienteHistorial + "%");
		return lista;
	}
}
