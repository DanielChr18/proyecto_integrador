package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.Ubigeo;
import com.proyectoIntegrador.repository.UbigeoRepositorio;

@Service
public class UbigeoServicioImpl implements UbigeoServicio {

	@Autowired
	UbigeoRepositorio repositorio;

	@Override
	public List<Ubigeo> listaDepartamentos() {
		return repositorio.listaDepartamentos();
	}

	@Override
	public List<Ubigeo> listaProvincia(String departamento) {
		return repositorio.listaProvincia(departamento);
	}

	@Override
	public List<Ubigeo> listaDistrito(String departamento, String provincia) {
		return repositorio.listaDistrito(departamento, provincia);
	}

}
