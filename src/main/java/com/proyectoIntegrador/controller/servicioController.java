package com.proyectoIntegrador.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.proyectoIntegrador.entity.FechasServicios;
import com.proyectoIntegrador.entity.HorariosServicios;
import com.proyectoIntegrador.entity.Servicio;
import com.proyectoIntegrador.service.FechasServiciosService;
import com.proyectoIntegrador.service.HorariosServiciosService;
import com.proyectoIntegrador.service.ServicioService;

@Controller
public class servicioController {

	private Path directorioImagenes = Paths.get("src//main//resources//static//images//servicios");
	private String rutaAbsoluta = directorioImagenes.toFile().getAbsolutePath();

	@Autowired
	private ServicioService service;

	@Autowired
	private HorariosServiciosService serviceHorSer;

	@Autowired
	private FechasServiciosService serviceFecSer;

	@RequestMapping("/listaServicios")
	public String listaServicios(Model model) {
		System.out.println("Listar Todos los Servicios");
		List<Servicio> servicios = service.listaServicios();
		List<Servicio> listaServicios = new ArrayList<>();
		for (Servicio x : servicios) {
			if (!x.getEstado().equals("desactivado")) {
				listaServicios.add(x);
			}
		}
		model.addAttribute("servicios", listaServicios);
		return "listaServicios";
	}

	@RequestMapping("/listadoHorariosServicios")
	@ResponseBody
	public List<HorariosServicios> listadoHorariosServicios(String idServicio) {
		System.out.println("Listar Servicios : ID -----> " + idServicio);
		int id = Integer.parseInt(idServicio);
		List<HorariosServicios> lista = serviceHorSer.listarHorariosServicios(id);
		List<HorariosServicios> horarios = new ArrayList<>();
		for (HorariosServicios x : lista) {
			if (!x.getEstado().equals("desactivado")) {
				x.setHorario(x.getHorario().substring(0, (x.getHorario().length() - 3)));
				horarios.add(x);
			}
		}
		return horarios;
	}

	@RequestMapping("/crudServicios")
	public String crudServicios(Model model) {
		System.out.println("Listar Todos los Servicios CRUD");
		List<Servicio> servicios = service.listaServicios();
		List<Servicio> listaServicios = new ArrayList<>();
		List<HorariosServicios> horarios = serviceHorSer.listarHorarios();
		List<HorariosServicios> listaHorarios = new ArrayList<>();
		for (HorariosServicios x : horarios) {
			if (!x.getEstado().equals("desactivado")) {
				listaHorarios.add(x);
			}
		}
		for (Servicio x : servicios) {
			if (!x.getEstado().equals("desactivado")) {
				listaServicios.add(x);
			}
		}
		model.addAttribute("horarios", listaHorarios);
		model.addAttribute("servicios", listaServicios);
		return "crudServicios";
	}

	@RequestMapping("/registrarServicio")
	public String registrarServicio(
			@RequestParam(value = "imagenServicioRegistrar", required = false) MultipartFile imagen,
			@RequestParam(value = "horarios", required = false) String horarios, Servicio obj) {
		try {
			if (obj.getNombre() != null) {
				System.out.println(obj);
				List<Servicio> lista = service.listaServicios();
				Path rutaCompleta = Paths.get(
						rutaAbsoluta + "//" + "SERVICIO" + (lista.get(lista.size() - 1).getIdServicio() + 1) + ".jpeg");
				Files.write(rutaCompleta, imagen.getBytes());
				obj.setImagen("SERVICIO" + (lista.get(lista.size() - 1).getIdServicio() + 1) + ".jpeg");
				obj.setEstado("activado");
				service.agregarServicio(obj);
				for (int i = 10; i < 21; i++) {
					HorariosServicios horSer = new HorariosServicios();
					horSer.setHorario(i + ":00");
					horSer.setIdServicio(obj);
					horSer.setEstado("desactivado");
					serviceHorSer.agregarHorario(horSer);
				}
				String[] horas = horarios.split(",");
				for (int h = 0; h < horas.length; h++) {
					String hora = horas[h] + ":00";
					metodo_agregarFechas(hora, obj.getIdServicio(), obj.getDia());
				}
				Thread.sleep(2000);
				return "redirect:crudServicios";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:crudServicios";
	}

	@RequestMapping("/modificarServicio")
	public String modificarServicio(
			@RequestParam(value = "imagenServicioModificar", required = false) MultipartFile imagen,
			@RequestParam(value = "horarios", required = false) String horarios, Servicio obj) {
		try {
			if (obj.getNombre() != null) {
				System.out.println(obj.getDia());
				Servicio servicio = service.listaServiciosId(obj.getIdServicio());
				if (!imagen.isEmpty()) {
					Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + servicio.getImagen());
					Files.write(rutaCompleta, imagen.getBytes());
				}
				List<String> horasAgregar = new ArrayList<String>();
				List<String> horasEliminar = new ArrayList<String>();
				List<String> horasMantener = new ArrayList<String>();
				String[] horas = horarios.split(",");
				for (int h = 0; h < horas.length; h++) {
					HorariosServicios horarioServicio = serviceHorSer.listarHoraServicio(obj.getIdServicio(),
							horas[h] + ":00");
					if (horarioServicio.getEstado().equals("desactivado")) {
						horasAgregar.add(horarioServicio.getHorario());
					} else if (horarioServicio.getEstado().equals("activado")) {
						horasMantener.add(horarioServicio.getHorario());
					}
				}
				Servicio ser = service.listaServiciosId(obj.getIdServicio());
				if (!ser.getDia().equals(obj.getDia())) {
					// serviceFecSer.eliminarFechaServicioXServicio(obj.getIdServicio());
					List<FechasServicios> listaFechas = serviceFecSer.findByServicio(obj.getIdServicio());
					for (FechasServicios f : listaFechas) {
						serviceFecSer.eliminarFechaServicio(f.getIdFechasServicios());
					}
					int cont = obtener_numeroSermana(obj.getDia());
					List<HorariosServicios> listaHoras = serviceHorSer.listarHorariosServicios(obj.getIdServicio());
					for (HorariosServicios x : listaHoras) {
						// Solo 3 horarios del servicio
						if (x.getEstado().equals("activado")) {
							LocalDateTime hoy = LocalDateTime.now();
							LocalDateTime fechaSiguiente = hoy.plusDays(cont);
							FechasServicios fecha = new FechasServicios();
							fecha.setEstado("libre");
							fecha.setFecha(fechaSiguiente.toString().split("T")[0]);
							fecha.setIdHorariosServicios(x);
							serviceFecSer.agregarFechaServicio(fecha);
						}
					}
				}
				List<HorariosServicios> listaHorarios = serviceHorSer.listarHorariosServicios(obj.getIdServicio());
				for (HorariosServicios x : listaHorarios) {
					if (x.getEstado().equals("activado"))
						horasEliminar.add(x.getHorario());
				}
				for (int e = 0; e < horasEliminar.size(); e++) {
					for (int m = 0; m < horasMantener.size(); m++) {
						if (horasEliminar.get(e).equals(horasMantener.get(m))) {
							horasEliminar.remove(e);
						}
					}
				}
				if (horasAgregar.size() == horasEliminar.size()) {
					for (int i = 0; i < horasAgregar.size(); i++) {
						metodo_reemplazarFechas(horasEliminar.get(i), horasAgregar.get(i), obj.getIdServicio());
					}
				} else if (horasAgregar.size() == 0 && (horasEliminar.size() > 0)) {
					for (int i = 0; i < horasEliminar.size(); i++) {
						metodo_eliminarFechas(horasEliminar.get(i), obj.getIdServicio());
					}
				} else if (horasAgregar.size() < horasEliminar.size()) {
					int contAgregar = 0;
					for (int i = 0; i < horasEliminar.size(); i++) {
						if (horasAgregar.size() > contAgregar) {
							metodo_reemplazarFechas(horasEliminar.get(i), horasAgregar.get(contAgregar),
									obj.getIdServicio());
							contAgregar++;
						} else {
							metodo_eliminarFechas(horasEliminar.get(i), obj.getIdServicio());
						}
					}
				} else if (horasAgregar.size() > 0 && (horasEliminar.size() == 0)) {
					for (int i = 0; i < horasAgregar.size(); i++) {
						metodo_agregarFechas(horasAgregar.get(i), obj.getIdServicio(), obj.getDia());
					}
				} else if (horasAgregar.size() > horasEliminar.size()) {
					int contEliminar = 0;
					for (int i = 0; i < horasAgregar.size(); i++) {
						if (horasEliminar.size() > contEliminar) {
							metodo_reemplazarFechas(horasEliminar.get(contEliminar), horasAgregar.get(i),
									obj.getIdServicio());
							contEliminar++;
						} else {
							metodo_agregarFechas(horasAgregar.get(i), obj.getIdServicio(), obj.getDia());
						}
					}
				}
				obj.setEstado("activado");
				obj.setImagen(servicio.getImagen());
				service.modificarServicio(obj);
				Thread.sleep(2000);
				return "redirect:crudServicios";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return "redirect:crudServicios";
	}

	@RequestMapping("/eliminarServicio")
	public String eliminarServicio(Servicio obj) {
		try {
			if (obj.getIdServicio() > 0) {
				String confirmar = "SI";
				List<HorariosServicios> listaHorarios = serviceHorSer.listarHorariosServicios(obj.getIdServicio());
				for (HorariosServicios x : listaHorarios) {
					List<FechasServicios> listaFechas = serviceFecSer.findByHoraServicio(x.getHorario(),
							obj.getIdServicio());
					if ((listaFechas.size() > 0) && (!x.getEstado().equals("activado"))) {
						confirmar = "NO";
						break;
					}
				}
				if (confirmar.equals("SI")) {
					for (HorariosServicios h : listaHorarios) {
						List<FechasServicios> fec = serviceFecSer.findByHoraServicio(h.getHorario(),
								obj.getIdServicio());
						if (fec != null) {
							for (FechasServicios f : fec) {
								f.setEstado("desactivado");
								serviceFecSer.agregarFechaServicio(f);
							}
						}
						h.setEstado("desactivado");
						serviceHorSer.agregarHorario(h);
					}
					Servicio ser = service.listaServiciosId(obj.getIdServicio());
					ser.setEstado("desactivado");
					service.modificarServicio(ser);
					System.out.println("El servicio se desactivó satisfactoriamente");
				} else if (confirmar.equals("NO")) {
					System.out.println("No se pudo desactivar el servicio porque tiene citas pendientes");
				}
				Thread.sleep(2000);
				return "redirect:crudServicios";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:crudServicios";
	}

	@RequestMapping("/validarFechas")
	@ResponseBody
	public Map<String, Object> validarFechas() throws ParseException {
		Map<String, Object> salida = new HashMap<>();
		LocalDateTime hoy = LocalDateTime.now();
		SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
		Date fechaActual = formatoFecha.parse(hoy.toString().split("T")[0]);
		Date fechaInicioDate = new Date();
		List<Servicio> listaServicios = service.listaServicios();
		List<FechasServicios> listaFechasServicios = serviceFecSer.findAll();
		salida.put("CONFIRMACION", "NO");
		salida.put("MENSAJE", "Las fechas están actualizadas.");
		for (FechasServicios lf : listaFechasServicios) {
			fechaInicioDate = formatoFecha.parse(lf.getFecha());
			if(fechaInicioDate.before(fechaActual) && lf.getEstado().equals("libre")) {
				serviceFecSer.eliminarFechaServicio(lf.getIdFechasServicios());
			}
		}
		for (Servicio s : listaServicios) {
			if (s.getEstado().equals("activado")) {
				System.out.println("ID SERVICIO --------------------------------> " + s.getIdServicio());
				List<HorariosServicios> listaHoras = serviceHorSer.listarHorariosServicios(s.getIdServicio());
				String ultimaFecha = "";
				for (HorariosServicios h : listaHoras) {
					if (!h.getEstado().equals("desactivado")) {
						System.out.println(
								"ID HORA SERVICIO --------------------------------> " + h.getIdHorariosServicios());
						System.out.println("HORA SERVICIO --------------------------------> " + h.getHorario());
						List<FechasServicios> listaFechas = serviceFecSer.findByHoraServicio(h.getHorario(),
								s.getIdServicio());
						if (listaFechas.size() == 1) {
							fechaInicioDate = formatoFecha.parse(listaFechas.get(0).getFecha().toString());
							ultimaFecha = listaFechas.get(0).getFecha().toString();
						} else {
							for (int i = 1; i < listaFechas.size(); i++) {
								Date fecha1 = formatoFecha.parse(listaFechas.get(i - 1).getFecha().toString());
								Date fecha2 = formatoFecha.parse(listaFechas.get(i).getFecha().toString());
								if (fecha1.after(fecha2)) {
									fechaInicioDate = formatoFecha.parse(listaFechas.get(i - 1).getFecha().toString());
									ultimaFecha = listaFechas.get(i - 1).getFecha().toString();
								} else {
									fechaInicioDate = formatoFecha.parse(listaFechas.get(i).getFecha().toString());
									ultimaFecha = listaFechas.get(i).getFecha().toString();
								}
							}
						}
						long diffTime = fechaInicioDate.getTime() - fechaActual.getTime();
						int diasssss = (int) TimeUnit.DAYS.convert(diffTime, TimeUnit.MILLISECONDS);
						System.out.println("ID Hora : " + h.getIdHorariosServicios());
						for (int i = diasssss; i < 35; i = i + 7) {
							if (i < 35) {
								System.out.println("Última fecha : " + ultimaFecha);
								LocalDateTime fechaAgregar = hoy.plusDays(i + 7);
								FechasServicios fechas = new FechasServicios();
								fechas.setEstado("libre");
								fechas.setFecha(fechaAgregar.toString().split("T")[0]);
								fechas.setIdHorariosServicios(h);
								serviceFecSer.agregarFechaServicio(fechas);
								salida.put("CONFIRMACION", "SI");
								salida.put("MENSAJE", "Las fechas se actualizaron exitosamente.");
							}
						}
					}
				}
			}
		}
		return salida;
	}

	@SuppressWarnings("deprecation")
	private int obtener_numeroSermana(String dia) {
		GregorianCalendar c = new GregorianCalendar();
		Date f = new Date();
		int numD = 0;
		int cont = 0;
		int numSemana = 0;
		switch (dia) {
		case "Lunes":
			numSemana = 2;
			break;
		case "Martes":
			numSemana = 3;
			break;
		case "Miércoles":
			numSemana = 4;
			break;
		case "Jueves":
			numSemana = 5;
			break;
		case "Viernes":
			numSemana = 6;
			break;
		}
		for (int i = 0; i < 7; i++) {
			c.set(f.getYear(), f.getMonth() - 1, f.getDay() + i);
			numD = c.get(Calendar.DAY_OF_WEEK);
			if (numD == numSemana) {
				break;
			}
			cont++;
		}
		return cont;
	}

	private void metodo_agregarFechas(String hora, int idServicio, String dia) {
		HorariosServicios horario = serviceHorSer.listarHoraServicio(idServicio, hora);
		horario.setEstado("activado");
		serviceHorSer.agregarHorario(horario);
		int adicionarDias = obtener_numeroSermana(dia);
		LocalDateTime today = LocalDateTime.now();
		FechasServicios fechaServicios = new FechasServicios();
		fechaServicios.setEstado("libre");
		fechaServicios.setIdHorariosServicios(horario);
		LocalDateTime tomorrow = today.plusDays(adicionarDias);
		fechaServicios.setFecha(tomorrow.toString().split("T")[0]);
		serviceFecSer.agregarFechaServicio(fechaServicios);
	}

	private void metodo_reemplazarFechas(String horaEliminar, String horaAgregar, int idServicio) {
		HorariosServicios horarioServicioAgregar = null;
		List<FechasServicios> fechasServicios = serviceFecSer.findByHoraServicio(horaEliminar, idServicio);
		for (FechasServicios x : fechasServicios) {
			horarioServicioAgregar = serviceHorSer.listarHoraServicio(idServicio, horaAgregar);
			x.setEstado("libre");
			x.setIdHorariosServicios(horarioServicioAgregar);
			serviceFecSer.agregarFechaServicio(x);
		}
		HorariosServicios horarioServicioEliminar = serviceHorSer.listarHoraServicio(idServicio, horaEliminar);
		horarioServicioAgregar.setEstado("activado");
		serviceHorSer.agregarHorario(horarioServicioAgregar);
		horarioServicioEliminar.setEstado("desactivado");
		serviceHorSer.agregarHorario(horarioServicioEliminar);
	}

	private void metodo_eliminarFechas(String horaEliminar, int idServicio) {
		List<FechasServicios> fechasServicios = serviceFecSer.findByHoraServicio(horaEliminar, idServicio);
		for (FechasServicios x : fechasServicios) {
			serviceFecSer.eliminarFechaServicio(x.getIdFechasServicios());
		}
		HorariosServicios horarioServicioEliminar = serviceHorSer.listarHoraServicio(idServicio, horaEliminar);
		horarioServicioEliminar.setEstado("desactivado");
		serviceHorSer.agregarHorario(horarioServicioEliminar);
	}
}
