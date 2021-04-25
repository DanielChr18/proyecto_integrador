package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.Mascota;
import com.proyectoIntegrador.repository.MascotaRepository;

@Service
public class MascotaServiceImpl implements MascotaService {

	@Autowired
	private MascotaRepository repository;

	@Override
	public List<Mascota> listarMascotaCliente(int idCliente) {
		return repository.listarMascotaCliente(idCliente);
	}

	@Override
	public Mascota agregarMascota(Mascota obj) {
		return repository.save(obj);
	}

	@Override
	public Mascota modificarMascota(Mascota obj) {
		return repository.save(obj);
	}

	@Override
	public void eliminarMascota(int idMascota) {
		repository.deleteById(idMascota);
	}

}
