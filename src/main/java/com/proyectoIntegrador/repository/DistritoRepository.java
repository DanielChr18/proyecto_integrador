package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.proyectoIntegrador.entity.Distrito;

public interface DistritoRepository extends JpaRepository<Distrito, Integer> {

	@Query("select e from Distrito e order by e.nombre")
	public abstract List<Distrito> listarDistritos();

}
