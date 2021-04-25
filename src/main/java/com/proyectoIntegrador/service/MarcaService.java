package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Marca;

public interface MarcaService {
	
	public abstract List<Marca> listaMarcas();

	public abstract Marca listaMarcasId(int idMarca);

	public abstract List<Marca> ListaMarcasNombre(String nombre);

	public abstract Marca agregarMarca(Marca obj);

	public abstract Marca modificarMarca(Marca obj);

	public abstract void eliminarMarca(int idMarca);
	

}
