package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.Marca;
import com.proyectoIntegrador.repository.MarcaRepository;

@Service
public class MarcaServicelmpl implements MarcaService {

	@Autowired
	private MarcaRepository repository;
	
	@Override
	public List<Marca> listaMarcas() {
		return repository.findAll();
	}

	@Override
	public Marca listaMarcasId(int idMarca) {
		return repository.findById(idMarca).get();
	}

	@Override
	public List<Marca> ListaMarcasNombre(String nombre) {
		return repository.listaMarcasNombre(nombre + "%");
	}

	@Override
	public Marca agregarMarca(Marca obj) {
		return repository.save(obj);
	}

	@Override
	public Marca modificarMarca(Marca obj) {
		return repository.save(obj);
	}

	@Override
	public void eliminarMarca(int idMarca) {
		repository.deleteById(idMarca);
		
	}

}
