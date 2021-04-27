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
			@RequestParam(value = "imagenProductoRegistrar", required = false) MultipartFile imagen, Producto obj) {
		try {
			if (obj.getNombre() != null) {
				System.out.println(imagen.getOriginalFilename());
				List<Producto> lista = service.listaProductos();
				Path rutaCompleta = Paths.get(
						rutaAbsoluta + "//" + "PRODUCTO" + (lista.get(lista.size() - 1).getIdProducto() + 1) + ".jpeg");
				Files.write(rutaCompleta, imagen.getBytes());
				Thread.sleep(2000);
				obj.setImagen("PRODUCTO" + (lista.get(lista.size() - 1).getIdProducto() + 1) + ".jpeg");
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
			@RequestParam(value = "imagenProductoModificar", required = false) MultipartFile imagen, Producto obj) {
		try {
			if (obj.getNombre() != null) {
				if (!imagen.isEmpty()) {
					System.out.println("id con imagen ---------> " + obj.getIdProducto());
					Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + obj.getIdProducto() + ".jpeg");
					Files.write(rutaCompleta, imagen.getBytes());
					obj.setImagen("PRODUCTO" + obj.getIdProducto() + ".jpeg");
				} else {
					System.out.println("id sin imagen ---------> " + obj.getIdProducto());
					Producto producto = service.listaProductosId(obj.getIdProducto());
					obj.setImagen(producto.getImagen());
				}
				Thread.sleep(2000);
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
				service.eliminarProducto(obj.getIdProducto());
				Thread.sleep(2000);
				Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + "PRODUCTO" + obj.getIdProducto() + ".jpeg");
				Files.delete(rutaCompleta);
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
