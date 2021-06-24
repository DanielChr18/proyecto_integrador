package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.TipoMascota;
import com.proyectoIntegrador.repository.TipoMascotaRepository;

@Service
public class TipoMascotaServiceImpl implements TipoMascotaService {

	@Autowired
	private TipoMascotaRepository repository;

	@Override
	public List<TipoMascota> listarMascotas() {
		return repository.findAll();
	}
}
