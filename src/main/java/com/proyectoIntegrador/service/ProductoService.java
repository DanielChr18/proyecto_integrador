package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Producto;

public interface ProductoService {

	public abstract List<Producto> listaProductos();

	public abstract Producto listaProductosId(int idProducto);

	public abstract List<Producto> listaProductosNombre(String nombre);

	public abstract List<Producto> listaProductosNombreDiferenteId(int idProducto, String nombre);

	public abstract Producto agregarModificarProducto(Producto obj);

}
