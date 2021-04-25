package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.Distrito;
import com.proyectoIntegrador.repository.DistritoRepository;

@Service
public class DistritoServiceImpl implements DistritoService {

	@Autowired
	private DistritoRepository repository;

	@Override
	public List<Distrito> listarDistritos() {
		return repository.listarDistritos();
	}

}
