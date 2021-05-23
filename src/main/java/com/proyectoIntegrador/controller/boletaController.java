package com.proyectoIntegrador.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proyectoIntegrador.entity.Boleta;
import com.proyectoIntegrador.service.BoletaService;
import com.proyectoIntegrador.service.ProductoService;

@Controller
public class boletaController {

	@Autowired
	private BoletaService service;

	@Autowired
	private ProductoService servicePro;

	@RequestMapping("/detalleBoleta")
	@ResponseBody
	public Map<String, Object> detalleBoleta(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		Map<String, Object> salida = new HashMap<>();
		if (session.getAttribute("objListaProductosTexto") != null) {
			String[] listaAyuda = session.getAttribute("objListaProductosTexto").toString().split(",");
			double totalPagar = 0;
			for (int i = 0; i < listaAyuda.length; i++) {
				totalPagar += servicePro.listaProductosId(Integer.parseInt(listaAyuda[i])).getPrecio();
			}
			salida.put("TOTAL", totalPagar);
			salida.put("FECHA", LocalDateTime.now().toString().split("T")[0]);
			return salida;
		} else {
			return salida;
		}
	}

	@RequestMapping("/agregarQuitarCantidad")
	@ResponseBody
	public Map<String, Object> agregarCantidad(HttpServletRequest request, String idProducto, String cantidad) {
		HttpSession session = request.getSession(true);
		Map<String, Object> salida = new HashMap<>();
		String[] listaProductos = session.getAttribute("objListaProductosBoletaTexto").toString().split(",");
		String listaAyuda = "";
		int contador = 0;
		int cant = Integer.parseInt(cantidad);
		int id = Integer.parseInt(idProducto);
		double totalPagar = 0;
		for (int i = 0; i < listaProductos.length; i++) {
			int idProd = Integer.parseInt(listaProductos[i].toString());
			if ((contador < cant) && (idProd == id)) {
				listaAyuda += String.valueOf(idProd) + ",";
				contador++;
			} else if (idProd != id) {
				listaAyuda += String.valueOf(idProd) + ",";
			}
		}
		if (contador < cant) {
			for (int i = contador; i < cant; i++) {
				listaAyuda += String.valueOf(idProducto) + ",";
			}
		}
		listaAyuda = listaAyuda.substring(0, listaAyuda.length() - 1);
		String[] listaProd = listaAyuda.split(",");
		for (int i = 0; i < listaProd.length; i++) {
			totalPagar += servicePro.listaProductosId(Integer.parseInt(listaProd[i])).getPrecio();
		}
		session.setAttribute("objListaProductosBoletaTexto", listaAyuda);
		salida.put("TOTAL", totalPagar);
		return salida;
	}

	@RequestMapping("/eliminarProductoBoleta")
	@ResponseBody
	public Map<String, Object> eliminarProductoBoleta(HttpServletRequest request, String idProducto) {
		HttpSession session = request.getSession(true);
		Map<String, Object> salida = new HashMap<>();
		String[] listaProductosCarrito = session.getAttribute("objListaProductosTexto").toString().split(",");
		String[] listaProductos = session.getAttribute("objListaProductosBoletaTexto").toString().split(",");
		String ayuda = "";
		double totalPagar = 0;
		for (int i = 0; i < listaProductos.length; i++) {
			if (listaProductos[i] != idProducto) {
				ayuda += listaProductos[i] + ",";
			}
		}
		session.setAttribute("objListaProductosBoletaTexto", ayuda.substring(0, ayuda.length() - 1));
		ayuda = "";
		for (int i = 0; i < listaProductosCarrito.length; i++) {
			if (listaProductosCarrito[i] != idProducto) {
				ayuda += listaProductosCarrito[i] + ",";
			}
		}
		session.setAttribute("objListaProductosTexto", ayuda.substring(0, ayuda.length() - 1));
		String ultimoProducto = ayuda.split(",")[ayuda.split(",").length - 1];
		session.setAttribute("objContadorProductos",
				Integer.parseInt(session.getAttribute("objContadorProductos").toString()) - 1);
		session.setAttribute("objUltimoProducto", ultimoProducto);
		salida.put("TOTAL", totalPagar);
		return salida;
	}

	@RequestMapping("/agregarBoleta")
	public String agregarBoleta(HttpServletRequest request, Boleta obj) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") != null) {
			if (session.getAttribute("objCargo").equals("Cliente")) {
				service.agregarBoleta(obj);
				String[] listaProductosCarrito = session.getAttribute("objListaProductosTexto").toString().split(",");
				String[] listaProductos = session.getAttribute("objListaProductosBoletaTexto").toString().split(",");
				for (int i = 0; i < listaProductos.length; i++) {
					int contador = 0;
					double costo = 0;
					// for (Producto pr : listaProductos) {
					// if (p.getIdProducto() == pr.getIdProducto()) {
					// contador++;
					// costo += pr.getPrecio();
					// }
					// }
					// DetalleBoleta detalleBoleta = new DetalleBoleta();
					// detalleBoleta.setCantidad(contador);
					// detalleBoleta.setCosto(costo);
					// detalleBoleta.setIdProducto(p);
					// detalleBoleta.setIdBoleta(obj);
					// serviceDetBol.agregarDetalleBoleta(detalleBoleta);
				}
				return "redirect:listaProductos";
			} else {
				return "redirect:login";
			}
		} else {
			return "redirect:login";
		}
	}
}
