package com.proyectoIntegrador.service;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.HistorialMascota;

import com.proyectoIntegrador.repository.HistorialMascotaRepository;

@Service
public class HistorialMascotaServiceImpl implements HistorialMascotaService {

	@Autowired
	private HistorialMascotaRepository repository;



	@Override
	public HistorialMascota registrarHistorialMas(HistorialMascota obj) {
		return repository.save(obj);
	}



}
