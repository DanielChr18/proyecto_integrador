package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Proveedor;

public interface ProveedorService {

	public abstract List<Proveedor> listaProveedores();

	public abstract Proveedor listaProveedoresId(int idProveedor);

	public abstract List<Proveedor> listaProveedoresRazonSocial(String razonSocial);

	public abstract List<Proveedor> listaProveedoresRuc(String ruc);

	public abstract List<Proveedor> listaProveedoresRazonSocialDiferenteId(int idProveedor, String razonSocial);

	public abstract List<Proveedor> listaProveedoresRucDiferenteId(int idProveedor, String ruc);

	public abstract Proveedor agregarModificarProveedor(Proveedor obj);

	public abstract void eliminarProveedor(int idProveedor);

}
