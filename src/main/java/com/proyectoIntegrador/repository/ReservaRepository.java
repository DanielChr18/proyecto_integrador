package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.Reserva;

public interface ReservaRepository extends JpaRepository<Reserva, Integer> {

	@Query("select r from Reserva r where r.idCliente.idCliente like :param_cliente")
	public abstract List<Reserva> listarReservasCliente(@Param("param_cliente") int idCliente);

	@Query("select r from Reserva r where r.idMascota.idMascota like :param_mascota")
	public abstract List<Reserva> listarReservasMascota(@Param("param_mascota") int idMascota);
}
