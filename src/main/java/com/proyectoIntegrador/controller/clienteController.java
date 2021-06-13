package com.proyectoIntegrador.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proyectoIntegrador.entity.Cliente;
import com.proyectoIntegrador.entity.Distrito;
import com.proyectoIntegrador.entity.Usuario;
import com.proyectoIntegrador.service.ClienteService;
import com.proyectoIntegrador.service.DistritoService;
import com.proyectoIntegrador.service.UsuarioService;

@Controller
public class clienteController {

	@Autowired
	private ClienteService service;

	@Autowired
	private UsuarioService serviceUsu;

	@Autowired
	private DistritoService serviceDis;

	@Autowired
	private BCryptPasswordEncoder encoder;

	@RequestMapping("/datosClientes")
	public String datosClientes(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") != null) {
			if (session.getAttribute("objCargo").equals("Personal de Ventas")) {
				return "redirect:error403";
			} else {
				if (session.getAttribute("objIdCliente") != null) {
					int idCliente = Integer.parseInt(session.getAttribute("objIdCliente").toString());
					Cliente cliente = service.listaClientesId(idCliente);
					model.addAttribute("clientes", cliente);
				}
			}
		}
		List<Distrito> distritos = new ArrayList<Distrito>();
		distritos = serviceDis.listarDistritos();
		model.addAttribute("distritos", distritos);
		return "datosClientes";
	}

	@RequestMapping("/registrarCliente")
	@ResponseBody
	public Map<String, Object> registrarCliente(HttpServletRequest request, Cliente obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			HttpSession session = request.getSession(true);
			if (obj.getNombre() != null) {
				List<Cliente> listaClientesDni = service.listaClientesDni(obj.getDni());
				List<Cliente> listaClientesEmail = service.listaClientesEmail(obj.getEmail());
				Usuario listaUsuarioNombre = serviceUsu.findByNomUsuario(obj.getIdUsuario().getNomUsuario());
				if (listaClientesDni.size() != 0) {
					salida.put("MENSAJE", "El Dni ingresado ya está registrado a otro Cliente.");
				} else if (listaClientesEmail.size() != 0) {
					salida.put("MENSAJE", "El Email ingresado ya está registrado a otro Cliente.");
				} else if (listaUsuarioNombre != null) {
					salida.put("MENSAJE", "El Usuario ingresado ya está registrado a otro Cliente.");
				} else {
					obj.getIdUsuario().setContrasenia(encoder.encode(obj.getIdUsuario().getContrasenia()));
					serviceUsu.agregarUsuario(obj.getIdUsuario());
					service.agregarModificarCliente(obj);
					Cliente cliente = service.listaClienteUsuario(obj.getIdUsuario().getIdUsuario());
					session.setAttribute("objIdCliente", cliente.getIdCliente());
					session.setAttribute("objCargo", "Cliente");
					session.setAttribute("objUsuario", cliente.getIdUsuario().getNomUsuario());
					salida.put("CONFIRMACION", "SI");
					salida.put("MENSAJE", "Cliente registrado correctamente.");
				}
			} else {
				salida.put("MENSAJE", "Error al registrar el cliente.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al registrar el cliente.");
			return salida;
		}
	}

	@RequestMapping("/modificarCliente")
	@ResponseBody
	public Map<String, Object> modificarCliente(HttpServletRequest request, Cliente obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			HttpSession session = request.getSession(true);
			if (obj.getNombre() != null) {
				List<Cliente> listaClientesDni = service.listaClientesDniDiferenteId(obj.getIdCliente(), obj.getDni());
				List<Cliente> listaClientesEmail = service.listaClientesEmailDiferenteId(obj.getIdCliente(),
						obj.getEmail());
				if (listaClientesDni.size() != 0) {
					salida.put("MENSAJE", "El Dni ingresado ya está registrado a otro Cliente.");
				} else if (listaClientesEmail.size() != 0) {
					salida.put("MENSAJE", "El Email ingresado ya está registrado a otro Cliente.");
				} else {
					Usuario usu = serviceUsu.findByNomUsuario(session.getAttribute("objUsuario").toString());
					PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
					boolean confirmar = passwordEncoder.matches(obj.getIdUsuario().getContrasenia(),
							usu.getContrasenia());
					if (confirmar) {
						obj.setIdUsuario(usu);
						service.agregarModificarCliente(obj);
						salida.put("CONFIRMACION", "SI");
						salida.put("MENSAJE", "Cliente modificado correctamente.");
					} else {
						salida.put("MENSAJE", "Contreña Incorrecta.");
					}
				}
			} else {
				salida.put("MENSAJE", "Error al modificar el cliente.");
			}
			return salida;
		} catch (

		Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al modificar el cliente.");
			return salida;
		}
	}

	@RequestMapping("/eliminarCliente")
	@ResponseBody
	public Map<String, Object> eliminarCliente(Cliente obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			if (obj.getIdCliente() > 0) {
				System.out.println(obj.getIdCliente());
				Cliente cliente = service.listaClientesId(obj.getIdCliente());
				service.eliminarCliente(obj.getIdCliente());
				serviceUsu.eliminarUsuario(cliente.getIdUsuario().getIdUsuario());
				salida.put("CONFIRMACION", "SI");
				salida.put("MENSAJE", "Cliente eliminado correctamente.");
			} else {
				salida.put("MENSAJE", "Error al eliminar el cliente.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al eliminar el cliente.");
			return salida;
		}
	}

}
