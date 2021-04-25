package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.Mascota;

public interface MascotaRepository extends JpaRepository<Mascota, Integer> {

	@Query("select m from Mascota m where m.idCliente.idCliente = :param_cliente")
	public abstract List<Mascota> listarMascotaCliente(@Param("param_cliente") int idCliente);
}
