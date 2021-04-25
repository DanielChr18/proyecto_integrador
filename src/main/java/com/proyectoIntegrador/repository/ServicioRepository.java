package com.proyectoIntegrador.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proyectoIntegrador.entity.Servicio;

public interface ServicioRepository extends JpaRepository<Servicio, Integer> {

	public abstract Servicio findByNombre(String nombre);
}
