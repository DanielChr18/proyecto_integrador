package com.proyectoIntegrador.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.proyectoIntegrador.entity.FechasServicios;
import com.proyectoIntegrador.entity.HorariosServicios;
import com.proyectoIntegrador.entity.Servicio;
import com.proyectoIntegrador.service.FechasServiciosService;
import com.proyectoIntegrador.service.HorariosServiciosService;
import com.proyectoIntegrador.service.ServicioService;

@Controller
public class servicioController {

	@Value("${resourcesDir}")
	private String uploadFolder;

	@Value("${awsAccess}")
	private String ACCESS_KEY;

	@Value("${awsSecret}")
	private String SECRET_KEY;

	@Value("${awsRegion}")
	private String REGION_NAME;

	@Value("${awsBucket}")
	private String BUCKET_NAME;

	@Value("${awsEndpoint}")
	private String ENDPOINT_URL;

	private AmazonS3 s3Cliente;

	@Autowired
	private ServicioService service;

	@Autowired
	private HorariosServiciosService serviceHorSer;

	@Autowired
	private FechasServiciosService serviceFecSer;

	@RequestMapping("/listaServicios")
	public String listaServicios(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") != null) {
			if (session.getAttribute("objCargo").equals("Personal de Ventas")) {
				return "redirect:error403";
			}
		}
		List<Servicio> servicios = service.listaServicios();
		List<Servicio> listaServicios = new ArrayList<>();
		for (Servicio x : servicios) {
			if (x.getEstado().equals("activado")) {
				listaServicios.add(x);
			}
		}
		model.addAttribute("servicios", listaServicios);
		return "listaServicios";
	}

	@RequestMapping("/crudServicios")
	public String crudServicios(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") == null) {
			return "redirect:error403";
		} else if (!session.getAttribute("objCargo").toString().equals("Personal de Ventas")) {
			return "redirect:error403";
		} else {
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
				if (x.getEstado().equals("activado")) {
					listaServicios.add(x);
				}
			}
			model.addAttribute("horarios", listaHorarios);
			model.addAttribute("servicios", listaServicios);
			return "crudServicios";
		}
	}

	@RequestMapping("/listadoHorariosServicios")
	@ResponseBody
	public List<HorariosServicios> listadoHorariosServicios(String idServicio) {
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

	@RequestMapping("/registrarServicio")
	@ResponseBody
	public Map<String, Object> registrarServicio(
			@RequestParam(value = "imagenServicioRegistrar", required = false) MultipartFile imagen,
			@RequestParam(value = "horarios", required = false) String horarios, Servicio obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			BasicAWSCredentials credentials = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
			s3Cliente = AmazonS3ClientBuilder.standard().withCredentials(new AWSStaticCredentialsProvider(credentials))
					.withRegion(REGION_NAME).build();
			if (obj.getNombre() != null) {
				List<Servicio> listaServiciosNombres = service.listaServiciosNombre(obj.getNombre());
				if (listaServiciosNombres.size() == 0) {
					List<Servicio> lista = service.listaServicios();
					ObjectMetadata metadata = new ObjectMetadata();

					int idServicio = 0;
					if (lista == null)
						idServicio = 1;
					else
						idServicio = lista.get(lista.size() - 1).getIdServicio() + 1;

					metadata.setContentLength(imagen.getSize());
					s3Cliente.putObject(new PutObjectRequest(BUCKET_NAME, "SERVICIO" + idServicio + ".jpeg",
							imagen.getInputStream(), metadata));

					obj.setImagen(ENDPOINT_URL + "SERVICIO" + idServicio + ".jpeg");
					obj.setEstado("activado");
					service.agregarModificarServicio(obj);
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
					validarFechas();
					salida.put("CONFIRMACION", "SI");
					salida.put("MENSAJE", "Servicio registrado correctamente.");
				} else {
					salida.put("MENSAJE", "El nombre del servicio ya existe.");
				}
			} else {
				salida.put("MENSAJE", "Error al registrar el servicio.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al registrar el servicio.");
			return salida;
		}
	}

	@RequestMapping("/modificarServicio")
	@ResponseBody
	public Map<String, Object> modificarServicio(
			@RequestParam(value = "imagenServicioModificar", required = false) MultipartFile imagen,
			@RequestParam(value = "horarios", required = false) String horarios, Servicio obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			BasicAWSCredentials credentials = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
			s3Cliente = AmazonS3ClientBuilder.standard().withCredentials(new AWSStaticCredentialsProvider(credentials))
					.withRegion(REGION_NAME).build();
			if (obj.getNombre() != null) {
				List<Servicio> listaServiciosNombres = service.listaNombreDiferenteId(obj.getIdServicio(),
						obj.getNombre());
				if (listaServiciosNombres.size() == 0) {
					Servicio servicio = service.listaServiciosId(obj.getIdServicio());
					ObjectMetadata metadata = new ObjectMetadata();
					if (!imagen.isEmpty()) {
						metadata.setContentLength(imagen.getSize());
						s3Cliente.putObject(new PutObjectRequest(BUCKET_NAME, servicio.getImagen().split(".com/")[1],
								imagen.getInputStream(), metadata));
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
						List<FechasServicios> listaFechas = serviceFecSer.findByServicio(obj.getIdServicio());
						for (FechasServicios f : listaFechas) {
							serviceFecSer.eliminarFechaServicio(f.getIdFechasServicios());
						}
						int cont = obtener_numeroSermana(obj.getDia());
						List<HorariosServicios> listaHoras = serviceHorSer.listarHorariosServicios(obj.getIdServicio());
						for (HorariosServicios x : listaHoras) {
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
					service.agregarModificarServicio(obj);
					validarFechas();
					salida.put("CONFIRMACION", "SI");
					salida.put("MENSAJE", "Servicio modificado correctamente.");
				} else {
					salida.put("MENSAJE", "El nombre del servicio ya existe.");
				}
			} else {
				salida.put("MENSAJE", "Error al modificar el servicio.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al modificar el servicio.");
			return salida;
		}
	}

	@RequestMapping("/eliminarServicio")
	@ResponseBody
	public Map<String, Object> eliminarServicio(Servicio obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			if (obj.getIdServicio() > 0) {
				Servicio ser = service.listaServiciosId(obj.getIdServicio());
				ser.setEstado("desactivado");
				service.agregarModificarServicio(ser);
				List<HorariosServicios> listaHorarios = serviceHorSer.listarHorariosServicios(obj.getIdServicio());
				for (HorariosServicios h : listaHorarios) {
					if (!h.getEstado().equals("ocupado")) {
						h.setEstado("desactivado");
						serviceHorSer.agregarHorario(h);
					}
					if (!h.getEstado().equals("desactivado")) {
						List<FechasServicios> listaFechasHorarios = serviceFecSer.findByHoraServicio(h.getHorario(),
								obj.getIdServicio());
						for (FechasServicios f : listaFechasHorarios) {
							if (f.getEstado().equals("reservado")) {
								f.setEstado("desactivado");
								serviceFecSer.agregarFechaServicio(f);
							}
						}
					}
				}
				salida.put("CONFIRMACION", "SI");
				salida.put("MENSAJE", "Servicio eliminado correctamente.");
			} else {
				salida.put("MENSAJE", "Error al eliminar el servicio.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al eliminar el servicio.");
			return salida;
		}
	}

	@RequestMapping("/verificarServicio")
	@ResponseBody
	public Map<String, Object> verificarServicio(String idServicio) {
		Map<String, Object> salida = new HashMap<>();
		List<HorariosServicios> listaHorariosServicios = serviceHorSer
				.listarHorariosServicios(Integer.parseInt(idServicio));
		for (HorariosServicios h : listaHorariosServicios) {
			if (h.getEstado().equals("ocupado")) {
				salida.put("CONFIRMACION", "NO");
				return salida;
			}
		}
		salida.put("CONFIRMACION", "SI");
		return salida;
	}

	@RequestMapping("/validarFechas")
	@ResponseBody
	public Map<String, Object> validarFechas() {
		Map<String, Object> salida = new HashMap<>();
		try {
			LocalDateTime hoy = LocalDateTime.now();
			SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
			Date fechaActual = formatoFecha.parse(hoy.toString().split("T")[0]);
			Date fechaInicioDate = new Date();
			List<Servicio> listaServicios = service.listaServicios();
			List<FechasServicios> listaFechasServicios = serviceFecSer.findAll();
			salida.put("MENSAJE", "Las fechas están actualizadas.");
			for (FechasServicios lf : listaFechasServicios) {
				fechaInicioDate = formatoFecha.parse(lf.getFecha());
				if (fechaInicioDate.before(fechaActual) && lf.getEstado().equals("libre")) {
					serviceFecSer.eliminarFechaServicio(lf.getIdFechasServicios());
				}
			}
			for (Servicio s : listaServicios) {
				if (s.getEstado().equals("activado")) {
					List<HorariosServicios> listaHoras = serviceHorSer.listarHorariosServicios(s.getIdServicio());
					for (HorariosServicios h : listaHoras) {
						if (!h.getEstado().equals("desactivado")) {
							List<FechasServicios> listaFechas = serviceFecSer.findByHoraServicio(h.getHorario(),
									s.getIdServicio());
							if (listaFechas.size() == 1) {
								fechaInicioDate = formatoFecha.parse(listaFechas.get(0).getFecha().toString());
							} else {
								for (int i = 1; i < listaFechas.size(); i++) {
									Date fecha1 = formatoFecha.parse(listaFechas.get(i - 1).getFecha().toString());
									Date fecha2 = formatoFecha.parse(listaFechas.get(i).getFecha().toString());
									if (fecha1.after(fecha2)) {
										fechaInicioDate = formatoFecha
												.parse(listaFechas.get(i - 1).getFecha().toString());
									} else {
										fechaInicioDate = formatoFecha.parse(listaFechas.get(i).getFecha().toString());
									}
								}
							}
							long diffTime = fechaInicioDate.getTime() - fechaActual.getTime();
							int diasssss = (int) TimeUnit.DAYS.convert(diffTime, TimeUnit.MILLISECONDS);
							for (int i = diasssss; i < 35; i = i + 7) {
								if (i < 35) {
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
		} catch (Exception e) {
			e.printStackTrace();
			return salida;
		}
	}

	private int obtener_numeroSermana(String dia) {
		GregorianCalendar c = new GregorianCalendar();
		LocalDateTime hoy = LocalDateTime.now();
		String f = hoy.toString().split("T")[0];
		String diaF = f.split("-")[2];
		String mesF = f.split("-")[1];
		String anioF = f.split("-")[0];
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
			c.set(Integer.parseInt(anioF), Integer.parseInt(mesF) - 1, Integer.parseInt(diaF) + i);
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
