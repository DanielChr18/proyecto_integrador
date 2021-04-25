package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.proyectoIntegrador.entity.FechasServicios;

public interface FechasServiciosRepository extends JpaRepository<FechasServicios, Integer> {

	@Query("select f from FechasServicios f where f.fecha = :param_fecha and f.idHorariosServicios.idServicio.idServicio = :param_servicio")
	public abstract List<FechasServicios> findByFechaServicio(@Param("param_fecha") String fecha,
			@Param("param_servicio") int idServicio);

	@Query("select f from FechasServicios f where f.idHorariosServicios.horario = :param_hora"
			+ " and f.idHorariosServicios.idServicio.idServicio = :param_servicio")
	public abstract List<FechasServicios> findByHoraServicio(@Param("param_hora") String hora,
			@Param("param_servicio") int idServicio);

	@Query("select f from FechasServicios f where f.idHorariosServicios.idServicio.idServicio = :param_servicio")
	public abstract List<FechasServicios> findByServicio(@Param("param_servicio") int idServicio);

}
