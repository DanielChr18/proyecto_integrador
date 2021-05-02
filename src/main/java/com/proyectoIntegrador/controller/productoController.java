package com.proyectoIntegrador.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

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
import com.proyectoIntegrador.service.ProveedorServicio;

@Controller
public class productoController {

	private Path directorioImagenes = Paths.get("src//main//resources//static//images//productos");
	private String rutaAbsoluta = directorioImagenes.toFile().getAbsolutePath();

	@Autowired
	private ProductoService service;

	@Autowired
	private MarcaService serviceMar;

	@Autowired
	private ProveedorServicio serviceProv;

	@RequestMapping("/listaProductos")
	public String listaProductos(Model model) {
		System.out.println("Listar Todos los Productos");
		List<Producto> lista = service.listaProductos();
		model.addAttribute("productos", lista);
		return "listaProductos";
	}

	@RequestMapping("/obtenerHtmlProducto")
	@ResponseBody
	public Producto obtenerHtmlProducto(String idProducto) {
		int id = Integer.parseInt(idProducto);
		return service.listaProductosId(id);
	}

	@RequestMapping("/listadoProductoNombre")
	@ResponseBody
	public List<Producto> listadoProductosNombre(String nombreArticulo) {
		System.out.println("Listar Productos por Nombre : Filtro -----> " + nombreArticulo);
		List<Producto> lista = service.ListaProductosNombre(nombreArticulo);
		return lista;
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
				int idProducto = lista.get(lista.size() - 1).getIdProducto() + 1;
				Path rutaCompleta1 = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + idProducto + "-1.jpeg");
				Files.write(rutaCompleta1, imagen1.getBytes());
				Path rutaCompleta2 = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + idProducto + "-2.jpeg");
				Files.write(rutaCompleta2, imagen2.getBytes());
				Path rutaCompleta3 = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + idProducto + "-3.jpeg");
				Files.write(rutaCompleta3, imagen3.getBytes());
				Thread.sleep(2000);
				obj.setEstado("activado");
				obj.setImagen1("PRODUCTO" + idProducto + "-1.jpeg");
				obj.setImagen2("PRODUCTO" + idProducto + "-2.jpeg");
				obj.setImagen3("PRODUCTO" + idProducto + "-3.jpeg");
				service.agregarProducto(obj);
			} else {
				return "redirect:error404";
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
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
				if (!imagen1.isEmpty()) {
					Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + obj.getIdProducto() + "-1.jpeg");
					Files.write(rutaCompleta, imagen1.getBytes());
					obj.setImagen1("PRODUCTO" + obj.getIdProducto() + "-1.jpeg");
				} else {
					Producto producto = service.listaProductosId(obj.getIdProducto());
					obj.setImagen1(producto.getImagen1());
				}
				if (!imagen2.isEmpty()) {
					Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + obj.getIdProducto() + "-2.jpeg");
					Files.write(rutaCompleta, imagen2.getBytes());
					obj.setImagen2("PRODUCTO" + obj.getIdProducto() + "-2.jpeg");
				} else {
					Producto producto = service.listaProductosId(obj.getIdProducto());
					obj.setImagen2(producto.getImagen2());
				}
				if (!imagen3.isEmpty()) {
					Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + obj.getIdProducto() + "-3.jpeg");
					Files.write(rutaCompleta, imagen3.getBytes());
					obj.setImagen3("PRODUCTO" + obj.getIdProducto() + "-3.jpeg");
				} else {
					Producto producto = service.listaProductosId(obj.getIdProducto());
					obj.setImagen3(producto.getImagen3());
				}
				Thread.sleep(2000);
				obj.setEstado("activado");
				service.modificarProducto(obj);
				return "redirect:crudProductos";
			} else {
				return "redirect:error404";
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
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
				Path rutaCompleta1 = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + obj.getIdProducto() + "-1.jpeg");
				Files.delete(rutaCompleta1);
				Path rutaCompleta2 = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + obj.getIdProducto() + "-2.jpeg");
				Files.delete(rutaCompleta2);
				Path rutaCompleta3 = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + obj.getIdProducto() + "-3.jpeg");
				Files.delete(rutaCompleta3);
				return "redirect:crudProductos";
			} else {
				return "redirect:error404";
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		return "redirect:crudProductos";
	}
}
