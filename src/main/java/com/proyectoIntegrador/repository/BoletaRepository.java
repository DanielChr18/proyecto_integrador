package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.Boleta;

public interface BoletaRepository extends JpaRepository<Boleta, Integer> {

	@Query("select b from Boleta b where b.idCliente.idCliente like :param_cliente")
	public abstract List<Boleta> listarBoletasCliente(@Param("param_cliente") int idCliente);
}
