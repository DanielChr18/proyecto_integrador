package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.Reserva;
import com.proyectoIntegrador.repository.ReservaRepository;

@Service
public class ReservaServiceImpl implements ReservaService {

	@Autowired
	private ReservaRepository repository;

	@Override
	public List<Reserva> listarReservasCliente(String idCliente) {
		return repository.listarReservasCliente(idCliente);
	}

	@Override
	public Reserva registrarReserva(Reserva obj) {
		return repository.save(obj);
	}

	@Override
	public Reserva actualizaReserva(Reserva obj) {
		return repository.save(obj);
	}

}
