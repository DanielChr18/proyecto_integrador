package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.HorariosServicios;

public interface HorariosServiciosRepository extends JpaRepository<HorariosServicios, Integer> {

	@Query("select h from HorariosServicios h where h.idServicio.idServicio = :param_servicio")
	public abstract List<HorariosServicios> listarHorasServicios(@Param("param_servicio") int idServicio);

	@Query("select h from HorariosServicios h where h.idServicio.idServicio = :param_servicio and h.horario = :param_horario")
	public abstract HorariosServicios listarHoraServicio(@Param("param_servicio") int idServicio,
			@Param("param_horario") String horario);

}
