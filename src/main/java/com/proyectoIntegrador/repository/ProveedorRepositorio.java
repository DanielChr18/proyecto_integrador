package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.Proveedor;

public interface ProveedorRepositorio extends JpaRepository<Proveedor, Integer> {

	@Query("select p from Proveedor p where p.razonSocial like :param_razonSocial")
	public abstract List<Proveedor> listaProveedoresNombre(@Param("param_razonSocial") String razonSocial);
}
