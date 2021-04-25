package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.Servicio;
import com.proyectoIntegrador.repository.ServicioRepository;

@Service
public class ServicioServiceImpl implements ServicioService {

	@Autowired
	private ServicioRepository repository;

	@Override
	public List<Servicio> listaServicios() {
		return repository.findAll();
	}

	@Override
	public Servicio listaServiciosNombre(String nombre) {
		return repository.findByNombre(nombre);
	}

	@Override
	public Servicio listaServiciosId(int idServicio) {
		return repository.findById(idServicio).get();
	}

	@Override
	public Servicio agregarServicio(Servicio obj) {
		return repository.save(obj);
	}

	@Override
	public Servicio modificarServicio(Servicio obj) {
		return repository.save(obj);
	}

	@Override
	public void eliminarServicio(int idServicio) {
		repository.deleteById(idServicio);
	}

}
