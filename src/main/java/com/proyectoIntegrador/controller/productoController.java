package com.proyectoIntegrador.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.proyectoIntegrador.entity.Marca;
import com.proyectoIntegrador.entity.Producto;
import com.proyectoIntegrador.entity.Proveedor;
import com.proyectoIntegrador.service.MarcaService;
import com.proyectoIntegrador.service.ProductoService;
import com.proyectoIntegrador.service.ProveedorService;

@Controller
public class productoController {

	private Path directorioImagenes = Paths.get("src//main//resources//static//images//productos");
	private String rutaAbsoluta = directorioImagenes.toFile().getAbsolutePath();

	@Autowired
	private ProductoService service;

	@Autowired
	private MarcaService serviceMar;

	@Autowired
	private ProveedorService serviceProv;

	@RequestMapping("/listaProductos")
	public String listaProductos(Model model) {
		System.out.println("Listar Todos los Productos");
		List<Producto> lista = service.listaProductos();
		model.addAttribute("productos", lista);
		return "listaProductos";
	}

	@RequestMapping("/listadoProductoNombre")
	@ResponseBody
	public List<Producto> listadoProductosNombre(String nombreArticulo) {
		System.out.println("Listar Productos por Nombre : Filtro -----> " + nombreArticulo);
		List<Producto> lista = service.ListaProductosNombre(nombreArticulo);
		return lista;
	}

	@RequestMapping("/agregarProducto")
	@ResponseBody
	public Map<String, Object> agregarProducto(HttpServletRequest request, String id) {
		HttpSession session = request.getSession(true);
		Map<String, Object> salida = new HashMap<>();
		int idProducto = Integer.parseInt(id);
		Producto listaProducto = service.listaProductosId(idProducto);
		ArrayList<Producto> listaPro = new ArrayList<Producto>();
		session.setAttribute("objUltimoProducto", id);
		if (session.getAttribute("objContadorProductos") == null
				|| session.getAttribute("objContadorProductos").toString().equals("0")) {
			salida.put("NOMBRE", listaProducto.getNombre());
			salida.put("PRECIO", listaProducto.getPrecio());
			salida.put("ID", listaProducto.getIdProducto());
			salida.put("CONFIRMACION", "SI");
			session.setAttribute("objListaProductosTexto", id);
			session.setAttribute("objContadorProductos", 1);
			listaPro.add(service.listaProductosId(idProducto));
			session.setAttribute("objListaProductosEntidad", listaPro);
			session.setAttribute("objListaProductosBoletaTexto", id);
			return salida;
		} else {
			String confirma = "SI";
			String[] listaAyuda = session.getAttribute("objListaProductosTexto").toString().split(",");
			for (int i = 0; i < listaAyuda.length; i++) {
				if (listaAyuda[i].equals(id)) {
					confirma = "NO";
					break;
				}
			}
			if (confirma.equals("SI")) {
				salida.put("NOMBRE", listaProducto.getNombre());
				salida.put("PRECIO", listaProducto.getPrecio());
				salida.put("ID", listaProducto.getIdProducto());
				String l = "";
				for (int i = 0; i < listaAyuda.length; i++) {
					listaPro.add(service.listaProductosId(Integer.parseInt(listaAyuda[i])));
					if ((listaAyuda.length - 1) == i) {
						l += listaAyuda[i];
					} else {
						l += listaAyuda[i] + ",";
					}
				}
				l += "," + id;
				listaPro.add(service.listaProductosId(idProducto));
				session.setAttribute("objListaProductosTexto", l);
				session.setAttribute("objContadorProductos", listaAyuda.length + 1);
				session.setAttribute("objListaProductosEntidad", listaPro);
				session.setAttribute("objListaProductosBoletaTexto", l);
				salida.put("CONFIRMACION", "SI");
			} else {
				salida.put("CONFIRMACION", "NO");
			}
			return salida;
		}
	}

	@RequestMapping("/crudProductos")
	public String verProducto(Model model) {
		System.out.println("Listar Todos los Productos CRUD");
		List<Producto> listaProductos = service.listaProductos();
		List<Marca> listaMarcas = serviceMar.listaMarcas();
		List<Proveedor> listaProveedores = serviceProv.listaProveedores();
		model.addAttribute("productos", listaProductos);
		model.addAttribute("marcas", listaMarcas);
		model.addAttribute("proveedores", listaProveedores);
		return "crudProductos";
	}

	@RequestMapping("/registrarProducto")
	public String registrarProducto(
			@RequestParam(value = "imagen1ProductoRegistrar", required = false) MultipartFile imagen1,
			@RequestParam(value = "imagen2ProductoRegistrar", required = false) MultipartFile imagen2,
			@RequestParam(value = "imagen3ProductoRegistrar", required = false) MultipartFile imagen3, Producto obj) {
		try {
			if (obj.getNombre() != null) {
				List<Producto> lista = service.listaProductos();
				int idProducto = 0;
				if (lista == null)
					idProducto = 1;
				else
					idProducto = lista.get(lista.size() - 1).getIdProducto() + 1;
				Path rutaCompleta1 = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + idProducto + "-1.jpeg");
				Files.write(rutaCompleta1, imagen1.getBytes());
				Path rutaCompleta2 = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + idProducto + "-2.jpeg");
				Files.write(rutaCompleta2, imagen2.getBytes());
				Path rutaCompleta3 = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + idProducto + "-3.jpeg");
				Files.write(rutaCompleta3, imagen3.getBytes());
				obj.setEstado("activado");
				obj.setImagen1("PRODUCTO" + idProducto + "-1.jpeg");
				obj.setImagen2("PRODUCTO" + idProducto + "-2.jpeg");
				obj.setImagen3("PRODUCTO" + idProducto + "-3.jpeg");
				service.agregarProducto(obj);
				Thread.sleep(2000);
				return "redirect:crudProductos";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:crudProductos";
	}

	@RequestMapping("/modificarProducto")
	public String modificarProducto(
			@RequestParam(value = "imagen1ProductoModificar", required = false) MultipartFile imagen1,
			@RequestParam(value = "imagen2ProductoModificar", required = false) MultipartFile imagen2,
			@RequestParam(value = "imagen3ProductoModificar", required = false) MultipartFile imagen3, Producto obj) {
		try {
			if (obj.getNombre() != null) {
				Producto producto = service.listaProductosId(obj.getIdProducto());
				if (!imagen1.isEmpty()) {
					Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + producto.getImagen1());
					Files.write(rutaCompleta, imagen1.getBytes());
				}
				if (!imagen2.isEmpty()) {
					Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + producto.getImagen2());
					Files.write(rutaCompleta, imagen2.getBytes());
				}
				if (!imagen3.isEmpty()) {
					Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + producto.getImagen3());
					Files.write(rutaCompleta, imagen3.getBytes());
				}
				obj.setEstado("activado");
				obj.setImagen1(producto.getImagen1());
				obj.setImagen2(producto.getImagen2());
				obj.setImagen3(producto.getImagen3());
				service.modificarProducto(obj);
				Thread.sleep(2000);
				return "redirect:crudProductos";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:crudProductos";
	}

	@RequestMapping("/eliminarProducto")
	public String eliminarProducto(Producto obj) {
		try {
			if (obj.getIdProducto() > 0) {
				System.out.println(obj.getIdProducto());
				Producto p = service.listaProductosId(obj.getIdProducto());
				p.setEstado("desactivado");
				service.modificarProducto(p);
				Thread.sleep(2000);
				return "redirect:crudProductos";
			} else {
				return "redirect:error404";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:crudProductos";
	}

	@RequestMapping("/obtenerHtmlProducto")
	@ResponseBody
	public Producto obtenerHtmlProducto(String idProducto) {
		int id = Integer.parseInt(idProducto);
		return service.listaProductosId(id);
	}
}
