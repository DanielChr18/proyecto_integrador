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
	public Mascota agregarModificarMascota(Mascota obj) {
		return repository.save(obj);
	}

	@Override
	public void eliminarMascota(int idMascota) {
		repository.deleteById(idMascota);
	}

	@Override
	public List<Mascota> listarMascotas() {
		return repository.findAll();
	}

	@Override
	public Mascota listarMascotaId(int idMascota) {
		return repository.findById(idMascota).get();
	}

}
