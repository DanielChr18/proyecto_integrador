package com.proyectoIntegrador.service;



import java.util.List;

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

	@Override
	public List<HistorialMascota> listarHistorialMascotaNombre(String mascotaNombre) {
		return repository.listarHistorialMascotaNombre(mascotaNombre);
	}

	@Override
	public HistorialMascota listarHistorialMascotaId(int idHistorialMascota) {
		return repository.findById(idHistorialMascota).get();
	}

	@Override
	public List<HistorialMascota> listarHistorialClienteNombre(String clienteNombre) {
		return repository.listarHistorialClienteNombre(clienteNombre);
	}

	@Override
	public List<HistorialMascota> listarHistorialClienteNombreId(int clienteNombreId) {
		return repository.listarHistorialClienteNombreId(clienteNombreId);
	}

	

	


}
