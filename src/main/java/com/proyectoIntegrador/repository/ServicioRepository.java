package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.Servicio;

public interface ServicioRepository extends JpaRepository<Servicio, Integer> {

	@Query("select s from Servicio s where s.nombre like :param_nombre and s.estado = 'activado'")
	public abstract List<Servicio> findByNombre(@Param("param_nombre") String nombre);

	@Query("select s from Servicio s where s.idServicio != :param_servicio and s.nombre like :param_nombre and s.estado = 'activado'")
	public abstract List<Servicio> listaNombreDiferenteId(@Param("param_servicio") int idServicio,
			@Param("param_nombre") String nombre);

	@Query("select s from Servicio s where s.nombre like :param_nombre and s.estado = 'activado'")
	public abstract List<Servicio> consultaServiciosChatBot(@Param("param_nombre") String nombre, Pageable pageable);
}
