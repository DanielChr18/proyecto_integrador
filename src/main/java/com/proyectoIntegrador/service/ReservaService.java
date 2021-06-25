package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Reserva;

public interface ReservaService {

	public abstract List<Reserva> listarReservas();

	public abstract Reserva listarReservasId(int idReserva);

	public abstract List<Reserva> listarReservasCliente(int idCliente);

	public abstract List<Reserva> listarReservasClienteNombre(String clienteNombre);

	public abstract List<Reserva> listarReservasMascota(int idMascota);

	public abstract Reserva registrarReserva(Reserva obj);

	public abstract Reserva actualizaReserva(Reserva obj);

}
