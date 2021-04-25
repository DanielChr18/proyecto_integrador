package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.Producto;

public interface ProductoRepository extends JpaRepository<Producto, Integer> {

	@Query("select e from Producto e where e.nombre like :param_nombre")
	public abstract List<Producto> listaProductosNombre(@Param("param_nombre") String nombre);

}
