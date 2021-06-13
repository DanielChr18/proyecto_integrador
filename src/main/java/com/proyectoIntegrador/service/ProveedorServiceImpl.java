package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.Proveedor;
import com.proyectoIntegrador.repository.ProveedorRepository;

@Service
public class ProveedorServiceImpl implements ProveedorService {

	@Autowired
	ProveedorRepository repositorio;

	@Override
	public List<Proveedor> listaProveedores() {
		return repositorio.findAll();
	}

	@Override
	public Proveedor listaProveedoresId(int idProveedor) {
		return repositorio.findById(idProveedor).get();
	}

	@Override
	public List<Proveedor> listaProveedoresRazonSocial(String razonSocial) {
		return repositorio.findByRazonSocial(razonSocial);
	}

	@Override
	public List<Proveedor> listaProveedoresRuc(String ruc) {
		return repositorio.findByRuc(ruc);
	}

	@Override
	public List<Proveedor> listaProveedoresRazonSocialDiferenteId(int idProveedor, String razonSocial) {
		return repositorio.listaProveedoresRazonSocialDiferenteId(idProveedor, razonSocial);
	}

	@Override
	public List<Proveedor> listaProveedoresRucDiferenteId(int idProveedor, String ruc) {
		return repositorio.listaProveedoresRucDiferenteId(idProveedor, ruc);
	}

	@Override
	public Proveedor agregarModificarProveedor(Proveedor obj) {
		return repositorio.save(obj);
	}

	@Override
	public void eliminarProveedor(int idProveedor) {
		repositorio.deleteById(idProveedor);
	}

}
