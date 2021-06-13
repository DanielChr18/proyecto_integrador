package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Marca;

public interface MarcaService {

	public abstract List<Marca> listaMarcas();

	public abstract Marca listaMarcasId(int idMarca);

	public abstract List<Marca> listaMarcasNombre(String nombre);

	public abstract List<Marca> listaMarcasNombreDiferenteId(int idMarca, String nombre);

	public abstract Marca agregarModificarMarca(Marca obj);

	public abstract void eliminarMarca(int idMarca);

}
