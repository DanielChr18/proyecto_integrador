package com.proyectoIntegrador.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.Trabajador;

public interface TrabajadorRepository extends JpaRepository<Trabajador, Integer> {

	@Query("select t from Trabajador t where t.idUsuario.idUsuario like :param_usuario")
	public abstract Trabajador buscarTrabajadorUsuario(@Param("param_usuario") int usuario);
}
