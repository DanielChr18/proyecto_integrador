package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.HistorialMascota;

public interface HistorialMascotaRepository extends JpaRepository<HistorialMascota, Integer> {

	@Query("select r from HistorialMascota r where r.idReserva.idMascota.nombre like :param_nombreMascota and"
			+ " r.idReserva.idCliente.idCliente = :param_cliente")
	public abstract List<HistorialMascota> listarHistorialMascotaNombreCliente(@Param("param_cliente") int idCliente,
			@Param("param_nombreMascota") String mascotaNombre);

	@Query("select r from HistorialMascota r where r.idReserva.idCliente.nombre like :param_nombreCliente")
	public abstract List<HistorialMascota> listarHistorialClienteNombre(
			@Param("param_nombreCliente") String clienteNombre);

}
