package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.DetalleBoleta;

public interface DetalleBoletaRepository extends JpaRepository<DetalleBoleta, Integer> {

	@Query("select d from DetalleBoleta d where d.idBoleta.idBoleta = :param_boleta")
	public abstract List<DetalleBoleta> listarDetallesPorBoleta(@Param("param_boleta") int idBoleta);
}
