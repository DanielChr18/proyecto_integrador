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
				List<Distrito> distritos = new ArrayList<Distrito>();
				distritos = serviceDis.listarDistritos();
				model.addAttribute("distritos", distritos);
				return "datosClientes";
			}
		}
		return "datosClientes";
	}

	@RequestMapping("/registrarCliente")
	public String registrarCliente(HttpServletRequest request, Cliente obj) {
		try {
			HttpSession session = request.getSession(true);
			if (obj.getNombre() != null) {
				System.out.println("|---------- En Registro de Cliente ----------|");
				obj.getIdUsuario().setContrasenia(encoder.encode(obj.getIdUsuario().getContrasenia()));
				serviceUsu.agregarUsuario(obj.getIdUsuario());
				service.agregarCliente(obj);
				Cliente cliente = service.buscarClienteUsuario(obj.getIdUsuario().getIdUsuario());
				session.setAttribute("objIdCliente", cliente.getIdCliente());
				session.setAttribute("objCargo", "Cliente");
				Thread.sleep(2000);
				return "redirect:datosMascotas";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:datosClientes";
	}

	@RequestMapping("/validacionUsuario")
	@ResponseBody
	public Map<String, Object> validacionUsuario(String nom_usuario) {
		Map<String, Object> salida = new HashMap<>();
		Usuario usu = serviceUsu.findByNomUsuario(nom_usuario);
		if (usu == null) {
			salida.put("CONFIRMACION", "SI");
			salida.put("MENSAJE", "Usuario creado satisfactoriamente.");
			return salida;
		} else {
			salida.put("CONFIRMACION", "NO");
			salida.put("MENSAJE", "El usuario ya existe.");
			return salida;
		}
	}

	@RequestMapping("/validacionContrasenia")
	@ResponseBody
	public Map<String, Object> validacionContrasenia(HttpServletRequest request, String con_usuario) {
		HttpSession session = request.getSession(true);
		Map<String, Object> salida = new HashMap<>();
		Usuario usu = serviceUsu.findByNomUsuario(session.getAttribute("objUsuario").toString());
		PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		boolean confirmar = passwordEncoder.matches(con_usuario, usu.getContrasenia());
		if (confirmar) {
			salida.put("CONFIRMACION", "SI");
			salida.put("MENSAJE", "Tus datos se cambiaron satisfactoriamente.");
			return salida;
		} else {
			salida.put("CONFIRMACION", "NO");
			salida.put("MENSAJE", "Contreña Incorrecta.");
			return salida;
		}
	}

	@RequestMapping("/modificarCliente")
	public String modificarCliente(HttpServletRequest request, Cliente obj) {
		try {
			System.out.println("-- Modificar Cliente --");
			HttpSession session = request.getSession(true);
			if (obj.getNombre() != null) {
				System.out.println("id ---------> " + obj.getIdCliente());
				Usuario usu = serviceUsu.findByNomUsuario(session.getAttribute("objUsuario").toString());
				obj.setIdUsuario(usu);
				service.modificarCliente(obj);
				Thread.sleep(2000);
				return "redirect:datosClientes";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:datosClientes";
	}

	@RequestMapping("/eliminarCliente")
	public String eliminarCliente(Cliente obj) {
		try {
			if (obj.getIdCliente() > 0) {
				System.out.println(obj.getIdCliente());
				Cliente cliente = service.listaClientesId(obj.getIdCliente());
				service.eliminarCliente(obj.getIdCliente());
				serviceUsu.eliminarUsuario(cliente.getIdUsuario().getIdUsuario());
				Thread.sleep(2000);
				return "redirect:datosClientes";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:datosClientes";
	}

}
