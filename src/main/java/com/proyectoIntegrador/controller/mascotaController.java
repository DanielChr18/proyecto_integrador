package com.proyectoIntegrador.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.proyectoIntegrador.entity.Cliente;
import com.proyectoIntegrador.entity.Marca;
import com.proyectoIntegrador.entity.Mascota;
import com.proyectoIntegrador.entity.Producto;
import com.proyectoIntegrador.entity.Servicio;
import com.proyectoIntegrador.service.ClienteService;
import com.proyectoIntegrador.service.MascotaService;

@Controller
public class mascotaController {

	private Path directorioImagenes = Paths.get("src//main//resources//static//images//mascotas");
	private String rutaAbsoluta = directorioImagenes.toFile().getAbsolutePath();

	@Autowired
	private MascotaService service;

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
			System.out.println("Listar Todas las Macotas del Cliente");
			int idCliente = Integer.parseInt(session.getAttribute("objIdCliente").toString());
			// Datos del Cliente
			Cliente cliente = serviceCli.listaClientesId(idCliente);
			model.addAttribute("clientes", cliente);
			// Datos de la Mascota
			List<Mascota> lista = service.listarMascotaCliente(idCliente);
			model.addAttribute("mascotas", lista);
			return "datosMascotas";
		}
	}

	@RequestMapping("/registrarMascota")
	public String agregarMascota(@RequestParam(value = "imagenMascotaRegistrar", required = false) MultipartFile imagen,
			HttpServletRequest request, Mascota obj) {
		try {
			if (obj.getNombre() != null) {
				HttpSession session = request.getSession(true);
				int idCliente = Integer.parseInt(session.getAttribute("objIdCliente").toString());
				System.out.println("|---------- En Registro de Mascota ----------|");
				List<Mascota> lista = service.listarMascotas();
				Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + "MASCOTA" + idCliente + "-"
						+ (lista.get(lista.size() - 1).getIdMascota() + 1) + ".jpeg");
				Files.write(rutaCompleta, imagen.getBytes());
				obj.setImagen("MASCOTA" + idCliente + "-" + (lista.get(lista.size() - 1).getIdMascota() + 1) + ".jpeg");
				Cliente cliente = new Cliente();
				cliente.setIdCliente(idCliente);
				obj.setIdCliente(cliente);
				service.agregarMascota(obj);
				Thread.sleep(2000);
				return "redirect:datosMascotas";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:datosMascotas";
	}

	@RequestMapping("/modificarMascota")
	public String modificarProducto(
			@RequestParam(value = "imagenMascotaModificar", required = false) MultipartFile imagen,
			HttpServletRequest request, Mascota obj) {
		try {
			if (obj.getNombre() != null) {
				HttpSession session = request.getSession(true);
				System.out.println("|---------- En Modificar Mascota ----------|");
				Mascota mascota = service.listarMascotaId(obj.getIdMascota());
				if (!imagen.isEmpty()) {
					Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + mascota.getImagen());
					Files.write(rutaCompleta, imagen.getBytes());
				}
				Cliente cliente = new Cliente();
				cliente.setIdCliente(Integer.parseInt(session.getAttribute("objIdCliente").toString()));
				obj.setIdCliente(cliente);
				obj.setImagen(mascota.getImagen());
				service.modificarMascota(obj);
				Thread.sleep(2000);
				return "redirect:datosMascotas";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:datosMascotas";
	}

	@RequestMapping("/eliminarMascota")
	public String eliminarProducto(Mascota obj) {
		try {
			if (obj.getIdMascota() > 0) {
				System.out.println("|---------- En Eliminar Mascota ----------|");
				service.eliminarMascota(obj.getIdMascota());
				Thread.sleep(2000);
				return "redirect:datosMascotas";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:datosMascotas";
	}

}
