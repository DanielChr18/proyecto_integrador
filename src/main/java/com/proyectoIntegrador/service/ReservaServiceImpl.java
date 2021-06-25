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
	public List<Reserva> listarReservas() {
		return repository.findAll();
	}

	@Override
	public Reserva listarReservasId(int idReserva) {
		return repository.findById(idReserva).get();
	}

	@Override
	public List<Reserva> listarReservasCliente(int idCliente) {
		return repository.listarReservasCliente(idCliente);
	}

	@Override
	public List<Reserva> listarReservasMascota(int idMascota) {
		return repository.listarReservasMascota(idMascota);
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
