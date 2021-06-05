package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Boleta;

public interface BoletaService {

	public abstract List<Boleta> listarBoletas();

	public abstract Boleta listarBoletasId(int idBoleta);

	public abstract List<Boleta> listarBoletasCliente(int idCliente);

	public abstract Boleta agregarBoleta(Boleta obj);
}
