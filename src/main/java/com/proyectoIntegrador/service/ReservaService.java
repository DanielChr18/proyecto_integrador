package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Reserva;

public interface ReservaService {

	public abstract List<Reserva> listarReservasCliente(String idCliente);

	public abstract Reserva registrarReserva(Reserva obj);

	public abstract Reserva actualizaReserva(Reserva obj);
	
}
