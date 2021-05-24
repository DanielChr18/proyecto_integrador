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
	public Proveedor agregarProveedor(Proveedor obj) {
		// TODO Auto-generated method stub
		return repositorio.save(obj);
	}

	@Override
	public List<Proveedor> listaProveedores() {
		// TODO Auto-generated method stub
		return repositorio.findAll();
	}

	@Override
	public Proveedor listaProveedoresId(int idProveedor) {
		// TODO Auto-generated method stub
		return repositorio.findById(idProveedor).get();
	}

	@Override
	public List<Proveedor> ListaProveedoresNombre(String nombre) {
		// TODO Auto-generated method stub
		return repositorio.listaProveedoresNombre(nombre + "%");
	}

	@Override
	public Proveedor modificarProveedor(Proveedor obj) {
		// TODO Auto-generated method stub
		return repositorio.save(obj);
	}

	@Override
	public void eliminarProveedor(int idProveedor) {
		// TODO Auto-generated method stub
		repositorio.deleteById(idProveedor);
	}

}
