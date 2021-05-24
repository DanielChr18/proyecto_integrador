package com.proyectoIntegrador.service;

import java.util.List;


import com.proyectoIntegrador.entity.Proveedor;

public interface ProveedorService {

	public abstract Proveedor agregarProveedor(Proveedor obj);
	
	public abstract List<Proveedor> listaProveedores();

	public abstract Proveedor listaProveedoresId(int idProveedor);

	public abstract List<Proveedor> ListaProveedoresNombre(String nombre);
	
	public abstract Proveedor modificarProveedor(Proveedor obj);

	public abstract void eliminarProveedor(int idProveedor);
	
}
