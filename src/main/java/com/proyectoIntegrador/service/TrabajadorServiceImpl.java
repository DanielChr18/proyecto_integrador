package com.proyectoIntegrador.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.Trabajador;
import com.proyectoIntegrador.repository.TrabajadorRepository;

@Service
public class TrabajadorServiceImpl implements TrabajadorService {

	@Autowired
	private TrabajadorRepository repository;

	@Override
	public Trabajador buscarTrabajadorUsuario(int idUsuario) {
		return repository.buscarTrabajadorUsuario(idUsuario);
	}

}
