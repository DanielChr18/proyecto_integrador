package com.proyectoIntegrador.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.proyectoIntegrador.entity.Cliente;
import com.proyectoIntegrador.entity.Mascota;
import com.proyectoIntegrador.entity.TipoMascota;
import com.proyectoIntegrador.service.ClienteService;
import com.proyectoIntegrador.service.MascotaService;
import com.proyectoIntegrador.service.TipoMascotaService;

@Controller
public class mascotaController {

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

	@Autowired
	private MascotaService service;

	@Autowired
	private TipoMascotaService serviceTipo;

	private AmazonS3 s3Cliente;

	@Autowired
	private ClienteService serviceCli;

	@RequestMapping("/datosMascotas")
	public String listaServicios(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") == null) {
			return "redirect:error403";
		} else if (!session.getAttribute("objCargo").toString().equals("Cliente")) {
			return "redirect:error403";
		} else {
			int idCliente = Integer.parseInt(session.getAttribute("objIdCliente").toString());
			Cliente cliente = serviceCli.listaClientesId(idCliente);
			model.addAttribute("clientes", cliente);
			List<Mascota> lista = service.listarMascotaCliente(idCliente);
			model.addAttribute("mascotas", lista);
			List<TipoMascota> tipos = serviceTipo.listarMascotas();
			model.addAttribute("tipos", tipos);
			return "datosMascotas";
		}
	}

	@RequestMapping("/registrarMascota")
	@ResponseBody
	public Map<String, Object> agregarMascota(
			@RequestParam(value = "imagenMascotaRegistrar", required = false) MultipartFile imagen,
			HttpServletRequest request, Mascota obj) {
		Map<String, Object> salida = new HashMap<>();

		try {
			BasicAWSCredentials credentials = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
			s3Cliente = AmazonS3ClientBuilder.standard().withCredentials(new AWSStaticCredentialsProvider(credentials))
					.withRegion(REGION_NAME).build();
			if (obj.getNombre() != null) {

				HttpSession session = request.getSession(true);
				int idCliente = Integer.parseInt(session.getAttribute("objIdCliente").toString());

				String fileUrl = "";

				String fileName = new Date().getTime() + "-" + imagen.getOriginalFilename().replace(" ", "_");
				ObjectMetadata metadata = new ObjectMetadata();

				if (imagen.getSize() > 0) {
					metadata.setContentLength(imagen.getSize());
					fileUrl = ENDPOINT_URL + fileName;

					s3Cliente.putObject(new PutObjectRequest(BUCKET_NAME, fileName, imagen.getInputStream(), metadata));
					obj.setImagen(fileUrl);
				}

				Cliente cliente = new Cliente();
				cliente.setIdCliente(idCliente);
				obj.setIdCliente(cliente);
				service.agregarModificarMascota(obj);
				salida.put("CONFIRMACION", "SI");
				salida.put("MENSAJE", "Mascota registrada correctamente.");
			} else {
				salida.put("MENSAJE", "Error al registrar la mascota.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al registrar la mascota.");
			return salida;
		}
	}

	@RequestMapping("/modificarMascota")
	@ResponseBody
	public Map<String, Object> modificarProducto(
			@RequestParam(value = "imagenMascotaModificar", required = false) MultipartFile imagen,
			HttpServletRequest request, Mascota obj) {
		BasicAWSCredentials credentials = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
		s3Cliente = AmazonS3ClientBuilder.standard().withCredentials(new AWSStaticCredentialsProvider(credentials))
				.withRegion(REGION_NAME).build();
		Map<String, Object> salida = new HashMap<>();
		try {
			if (obj.getNombre() != null) {
				HttpSession session = request.getSession(true);
				ObjectMetadata metadata = new ObjectMetadata();
				Mascota mascota = service.listarMascotaId(obj.getIdMascota());
				obj.setImagen(mascota.getImagen());
				if (imagen.getSize() > 0) {
					metadata.setContentLength(imagen.getSize());
					s3Cliente.putObject(new PutObjectRequest(BUCKET_NAME, mascota.getImagen().split(".com/")[1],
							imagen.getInputStream(), metadata));
				}
				Cliente cliente = new Cliente();
				cliente.setIdCliente(Integer.parseInt(session.getAttribute("objIdCliente").toString()));
				obj.setIdCliente(cliente);
				service.agregarModificarMascota(obj);
				salida.put("CONFIRMACION", "SI");
				salida.put("MENSAJE", "Mascota modificada correctamente.");
			} else {
				salida.put("MENSAJE", "Error al modificar la mascota.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al modificar la mascota.");
			return salida;
		}
	}

	@RequestMapping("/eliminarMascota")
	@ResponseBody
	public Map<String, Object> eliminarProducto(Mascota obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			if (obj.getIdMascota() > 0) {
				service.eliminarMascota(obj.getIdMascota());
				salida.put("CONFIRMACION", "SI");
				salida.put("MENSAJE", "Mascota eliminada correctamente.");
			} else {
				salida.put("MENSAJE", "Error al eliminar la mascota.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al eliminar la mascota.");
			return salida;
		}
	}

}
