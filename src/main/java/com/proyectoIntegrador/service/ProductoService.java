package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.proyectoIntegrador.entity.Producto;

public interface ProductoService {

	public abstract List<Producto> listaProductos();

	public abstract Producto listaProductosId(int idProducto);

	public abstract List<Producto> listaProductosNombre(String nombre);

	public abstract List<Producto> listaProductosNombreDiferenteId(int idProducto, String nombre);

	public abstract List<Producto> consultaProductosChatBot(int mascota, int categoria, String nombre,
			Pageable pageable);

	public abstract Producto agregarModificarProducto(Producto obj);

}
