package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Producto;

public interface ProductoService {

	public abstract List<Producto> listaProductos();

	public abstract Producto listaProductosId(int idProducto);

	public abstract List<Producto> ListaProductosNombre(String nombre);

	public abstract Producto agregarProducto(Producto obj);

	public abstract Producto modificarProducto(Producto obj);

}
