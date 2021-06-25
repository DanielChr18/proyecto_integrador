package com.proyectoIntegrador.controller;

import java.util.ArrayList;
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
import com.proyectoIntegrador.entity.Categoria;
import com.proyectoIntegrador.entity.Marca;
import com.proyectoIntegrador.entity.Producto;
import com.proyectoIntegrador.entity.Proveedor;
import com.proyectoIntegrador.entity.TipoMascota;
import com.proyectoIntegrador.service.CategoriaService;
import com.proyectoIntegrador.service.MarcaService;
import com.proyectoIntegrador.service.ProductoService;
import com.proyectoIntegrador.service.ProveedorService;
import com.proyectoIntegrador.service.TipoMascotaService;

@Controller
public class productoController {

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
	private ProductoService service;

	@Autowired
	private MarcaService serviceMar;

	@Autowired
	private ProveedorService serviceProv;

	@Autowired
	private TipoMascotaService serviceTipoMas;

	@Autowired
	private CategoriaService serviceCat;

	@RequestMapping("/listaProductos")
	public String listaProductos(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") != null) {
			if (session.getAttribute("objCargo").equals("Personal de Ventas")) {
				return "redirect:error403";
			}
		}
		System.out.println("Listar Todos los Productos");
		List<Producto> lista = service.listaProductos();
		model.addAttribute("productos", lista);
		return "listaProductos";
	}

	@RequestMapping("/listadoProductoNombre")
	@ResponseBody
	public List<Producto> listadoProductosNombre(String nombreArticulo) {
		System.out.println("Listar Productos por Nombre : Filtro -----> " + nombreArticulo);
		List<Producto> lista = service.listaProductosNombre("%" + nombreArticulo + "%");
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
	public String crudProductos(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") == null) {
			return "redirect:error403";
		} else if (!session.getAttribute("objCargo").toString().equals("Personal de Ventas")) {
			return "redirect:error403";
		} else {
			System.out.println("Listar Todos los Productos CRUD");
			List<Producto> listaProductos = service.listaProductos();
			List<Marca> listaMarcas = serviceMar.listaMarcas();
			List<Proveedor> listaProveedores = serviceProv.listaProveedores();
			List<TipoMascota> listaTipoMascotas = serviceTipoMas.listarMascotas();
			List<Categoria> listaCategorias = serviceCat.listarCategorias();
			model.addAttribute("productos", listaProductos);
			model.addAttribute("marcas", listaMarcas);
			model.addAttribute("proveedores", listaProveedores);
			model.addAttribute("tipos", listaTipoMascotas);
			model.addAttribute("categorias", listaCategorias);
			return "crudProductos";
		}
	}

	@RequestMapping("/registrarProducto")
	@ResponseBody
	public Map<String, Object> registrarProducto(
			@RequestParam(value = "imagen1ProductoRegistrar", required = false) MultipartFile imagen1,
			@RequestParam(value = "imagen2ProductoRegistrar", required = false) MultipartFile imagen2,
			@RequestParam(value = "imagen3ProductoRegistrar", required = false) MultipartFile imagen3,
			@RequestParam(value = "descripcionLargaProducto", required = false) String descripcionLargaProducto,
			Producto obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			BasicAWSCredentials credentials = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
			s3Cliente = AmazonS3ClientBuilder.standard().withCredentials(new AWSStaticCredentialsProvider(credentials))
					.withRegion(REGION_NAME).build();
			if (obj.getNombre() != null) {
				List<Producto> listaProductosNombres = service.listaProductosNombre(obj.getNombre());
				if (listaProductosNombres.size() == 0) {
					List<Producto> lista = service.listaProductos();
					int idProducto = 0;
					if (lista == null)
						idProducto = 1;
					else
						idProducto = lista.get(lista.size() - 1).getIdProducto() + 1;
					ObjectMetadata metadata = new ObjectMetadata();
					metadata.setContentLength(imagen1.getSize());
					s3Cliente.putObject(new PutObjectRequest(BUCKET_NAME, "PRODUCTO" + idProducto + "-1.jpeg",
							imagen1.getInputStream(), metadata));
					metadata.setContentLength(imagen2.getSize());
					s3Cliente.putObject(new PutObjectRequest(BUCKET_NAME, "PRODUCTO" + idProducto + "-2.jpeg",
							imagen2.getInputStream(), metadata));
					metadata.setContentLength(imagen3.getSize());
					s3Cliente.putObject(new PutObjectRequest(BUCKET_NAME, "PRODUCTO" + idProducto + "-3.jpeg",
							imagen3.getInputStream(), metadata));
					obj.setDescripcionLarga(descripcionLargaProducto);
					obj.setEstado("activado");
					obj.setImagen1(ENDPOINT_URL + "PRODUCTO" + idProducto + "-1.jpeg");
					obj.setImagen2(ENDPOINT_URL + "PRODUCTO" + idProducto + "-2.jpeg");
					obj.setImagen3(ENDPOINT_URL + "PRODUCTO" + idProducto + "-3.jpeg");
					service.agregarModificarProducto(obj);
					salida.put("CONFIRMACION", "SI");
					salida.put("MENSAJE", "Producto registrado correctamente.");
				} else {
					salida.put("MENSAJE", "El nombre del producto ya existe.");
				}
			} else {
				salida.put("MENSAJE", "Error al registrar el producto.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al registrar el producto.");
			return salida;
		}
	}

	@RequestMapping("/modificarProducto")
	@ResponseBody
	public Map<String, Object> modificarProducto(
			@RequestParam(value = "imagen1ProductoModificar", required = false) MultipartFile imagen1,
			@RequestParam(value = "imagen2ProductoModificar", required = false) MultipartFile imagen2,
			@RequestParam(value = "imagen3ProductoModificar", required = false) MultipartFile imagen3,
			@RequestParam(value = "descripcionLargaProducto", required = false) String descripcionLargaProducto,
			Producto obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			BasicAWSCredentials credentials = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
			s3Cliente = AmazonS3ClientBuilder.standard().withCredentials(new AWSStaticCredentialsProvider(credentials))
					.withRegion(REGION_NAME).build();
			if (obj.getNombre() != null) {
				List<Producto> listaProductosNombres = service.listaProductosNombreDiferenteId(obj.getIdProducto(),
						obj.getNombre());
				if (listaProductosNombres.size() == 0) {
					Producto producto = service.listaProductosId(obj.getIdProducto());
					ObjectMetadata metadata = new ObjectMetadata();
					if (!imagen1.isEmpty()) {
						metadata.setContentLength(imagen1.getSize());
						s3Cliente.putObject(new PutObjectRequest(BUCKET_NAME, producto.getImagen1().split(".com/")[1],
								imagen1.getInputStream(), metadata));
					}
					if (!imagen2.isEmpty()) {
						metadata.setContentLength(imagen2.getSize());
						s3Cliente.putObject(new PutObjectRequest(BUCKET_NAME, producto.getImagen2().split(".com/")[1],
								imagen2.getInputStream(), metadata));
					}
					if (!imagen3.isEmpty()) {
						metadata.setContentLength(imagen3.getSize());
						s3Cliente.putObject(new PutObjectRequest(BUCKET_NAME, producto.getImagen3().split(".com/")[1],
								imagen3.getInputStream(), metadata));
					}
					obj.setDescripcionLarga(descripcionLargaProducto);
					obj.setEstado("activado");
					obj.setImagen1(producto.getImagen1());
					obj.setImagen2(producto.getImagen2());
					obj.setImagen3(producto.getImagen3());
					service.agregarModificarProducto(obj);
					salida.put("CONFIRMACION", "SI");
					salida.put("MENSAJE", "Producto modificado correctamente.");
				} else {
					salida.put("MENSAJE", "El nombre del producto ya existe.");
				}
			} else {
				salida.put("MENSAJE", "Error al modificar el producto.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al modificar el producto.");
			return salida;
		}
	}

	@RequestMapping("/eliminarProducto")
	@ResponseBody
	public Map<String, Object> eliminarProducto(Producto obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			if (obj.getIdProducto() > 0) {
				System.out.println(obj.getIdProducto());
				Producto p = service.listaProductosId(obj.getIdProducto());
				p.setEstado("desactivado");
				service.agregarModificarProducto(p);
				salida.put("CONFIRMACION", "SI");
				salida.put("MENSAJE", "Producto eliminado correctamente.");
			} else {
				salida.put("MENSAJE", "Error al eliminar el producto.");
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al eliminar el producto.");
			return salida;
		}
	}

	@RequestMapping("/obtenerHtmlProducto")
	@ResponseBody
	public Producto obtenerHtmlProducto(String idProducto) {
		int id = Integer.parseInt(idProducto);
		return service.listaProductosId(id);
	}
}
