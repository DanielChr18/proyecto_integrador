package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.DetalleBoleta;
import com.proyectoIntegrador.repository.DetalleBoletaRepository;

@Service
public class DetalleBoletaServiceImpl implements DetalleBoletaService {

	@Autowired
	private DetalleBoletaRepository repository;

	@Override
	public List<DetalleBoleta> listarDetallesPorBoleta(String idBoleta) {
		return repository.listarDetallesPorBoleta(idBoleta);
	}

	@Override
	public DetalleBoleta agregarDetalleBoleta(DetalleBoleta obj) {
		return repository.save(obj);
	}
	
	
}
