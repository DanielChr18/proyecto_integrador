package com.proyectoIntegrador.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proyectoIntegrador.entity.Boleta;
import com.proyectoIntegrador.entity.DetalleBoleta;
import com.proyectoIntegrador.entity.Producto;
import com.proyectoIntegrador.service.BoletaService;
import com.proyectoIntegrador.service.DetalleBoletaService;
import com.proyectoIntegrador.service.ProductoService;

@Controller
public class boletaController {

	@Autowired
	private BoletaService service;

	@Autowired
	private DetalleBoletaService serviceDetBol;

	@Autowired
	private ProductoService servicePro;

	@SuppressWarnings("unchecked")
	@RequestMapping("/detalleBoleta")
	public String detalleBoleta(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objListaProductosBoleta") != null) {
			List<Producto> listaProductos = (ArrayList<Producto>) session.getAttribute("objListaProductosBoleta");
			List<Producto> listaProductosBoleta = new ArrayList<Producto>();
			double totalPagar = 0;
			for (Producto p : listaProductos) {
				listaProductosBoleta.add(p);
				totalPagar += p.getPrecio();
			}
			model.addAttribute("total", totalPagar);
			model.addAttribute("fecha", LocalDateTime.now().toString().split("T")[0]);
			return "detalleBoleta";
		} else {
			model.addAttribute("conf", "NO");
			return "detalleBoleta";
		}
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/agregarQuitarCantidad")
	@ResponseBody
	public Map<String, Object> agregarCantidad(HttpServletRequest request, String idProducto, String cantidad) {
		HttpSession session = request.getSession(true);
		Map<String, Object> salida = new HashMap<>();
		List<Producto> listaProductos = (ArrayList<Producto>) session.getAttribute("objListaProductosBoleta");
		int contador = 0, cant = Integer.parseInt(cantidad);
		int id = Integer.parseInt(idProducto);
		double totalPagar = 0;
		for (int i = 0; i < listaProductos.size(); i++) {
			if ((contador < cant) && (listaProductos.get(i).getIdProducto() == id)) {
				contador++;
			} else if ((contador >= cant) && (listaProductos.get(i).getIdProducto() == id)) {
				listaProductos.remove(i);
			}
		}
		if (contador < cant) {
			for (int i = contador; i < cant; i++) {
				Producto p = servicePro.listaProductosId(id);
				listaProductos.add(p);
			}
		}
		for (Producto p : listaProductos) {
			totalPagar += p.getPrecio();
		}
		session.setAttribute("objListaProductosBoleta", listaProductos);
		salida.put("TOTAL", totalPagar);
		return salida;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/eliminarProductoBoleta")
	@ResponseBody
	public Map<String, Object> eliminarProductoBoleta(HttpServletRequest request, String idProducto) {
		HttpSession session = request.getSession(true);
		Map<String, Object> salida = new HashMap<>();
		List<Producto> listaProductos = (ArrayList<Producto>) session.getAttribute("objListaProductosBoleta");
		List<Producto> listaProductosCarrito = (ArrayList<Producto>) session.getAttribute("objListaProductosEntidad");
		int id = Integer.parseInt(idProducto);
		double totalPagar = 0;
		for (int i = 0; i < listaProductos.size(); i++) {
			if (listaProductos.get(i).getIdProducto() == id) {
				listaProductos.remove(i);
			} else {
				totalPagar += listaProductos.get(i).getPrecio();
			}
		}
		for (int i = 0; i < listaProductosCarrito.size(); i++) {
			if (listaProductosCarrito.get(i).getIdProducto() == id) {
				listaProductosCarrito.remove(i);
				break;
			}
		}
		String[] listaProductosTexto = session.getAttribute("objListaProductosTexto").toString().split(",");
		String nuevaListaProductosTexto = "";
		String ultimoProducto = "";
		for (int i = 0; i < listaProductosTexto.length; i++) {
			if (Integer.parseInt(listaProductosTexto[i]) != id) {
				nuevaListaProductosTexto += listaProductosTexto[i] + ",";
				ultimoProducto = listaProductosTexto[i];
			}
		}
		session.setAttribute("objListaProductosBoleta", listaProductos);
		session.setAttribute("objListaProductosEntidad", listaProductosCarrito);
		session.setAttribute("objContadorProductos",
				Integer.parseInt(session.getAttribute("objContadorProductos").toString()) - 1);
		session.setAttribute("objListaProductosTexto",
				nuevaListaProductosTexto.substring(0, nuevaListaProductosTexto.length() - 1));
		session.setAttribute("objUltimoProducto", ultimoProducto);
		salida.put("TOTAL", totalPagar);
		return salida;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/agregarBoleta")
	public String agregarBoleta(HttpServletRequest request, Boleta obj) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") != null) {
			if (session.getAttribute("objCargo").equals("Cliente")) {
				service.agregarBoleta(obj);
				List<Producto> listaProductos = (ArrayList<Producto>) session.getAttribute("objListaProductosBoleta");
				List<Producto> listaProductosCarrito = (ArrayList<Producto>) session
						.getAttribute("objListaProductosEntidad");
				for (Producto p : listaProductosCarrito) {
					int contador = 0;
					double costo = 0;
					for (Producto pr : listaProductos) {
						if (p.getIdProducto() == pr.getIdProducto()) {
							contador++;
							costo += pr.getPrecio();
						}
					}
					DetalleBoleta detalleBoleta = new DetalleBoleta();
					detalleBoleta.setCantidad(contador);
					detalleBoleta.setCosto(costo);
					detalleBoleta.setIdProducto(p);
					detalleBoleta.setIdBoleta(obj);
					serviceDetBol.agregarDetalleBoleta(detalleBoleta);
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
