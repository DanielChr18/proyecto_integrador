package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.Categoria;
import com.proyectoIntegrador.repository.CategoriaRepository;

@Service
public class CategoriaServiceImpl implements CategoriaService {

	@Autowired
	private CategoriaRepository repository;

	@Override
	public List<Categoria> listarCategorias() {
		return repository.findAll();
	}

}
