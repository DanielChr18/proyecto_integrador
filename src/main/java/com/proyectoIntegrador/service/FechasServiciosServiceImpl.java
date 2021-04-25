package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.FechasServicios;
import com.proyectoIntegrador.repository.FechasServiciosRepository;

@Service
public class FechasServiciosServiceImpl implements FechasServiciosService {

	@Autowired
	private FechasServiciosRepository repository;

	@Override
	public List<FechasServicios> findByFechaServicio(String fecha, int idServicio) {
		return repository.findByFechaServicio(fecha, idServicio);
	}

	@Override
	public List<FechasServicios> findByHoraServicio(String hora, int idServicio) {
		return repository.findByHoraServicio(hora, idServicio);
	}

	@Override
	public List<FechasServicios> findByServicio(int idServicio) {
		return repository.findByServicio(idServicio);
	}

	@Override
	public FechasServicios agregarFechaServicio(FechasServicios obj) {
		return repository.save(obj);
	}

	@Override
	public void eliminarFechaServicio(int idFechaServicio) {
		repository.deleteById(idFechaServicio);
	}

}
