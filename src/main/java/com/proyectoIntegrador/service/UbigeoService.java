package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Ubigeo;

public interface UbigeoService {

	public abstract List<Ubigeo> listaDepartamentos();

	public abstract List<Ubigeo> listaProvincia(String departamento);

	public abstract List<Ubigeo> listaDistrito(String departamento, String provincia);

}
