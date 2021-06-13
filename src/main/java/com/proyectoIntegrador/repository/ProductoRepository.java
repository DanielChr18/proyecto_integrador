package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.Producto;

public interface ProductoRepository extends JpaRepository<Producto, Integer> {

	@Query("select p from Producto p where p.nombre like :param_nombre and p.estado = 'activado'")
	public abstract List<Producto> findByNombre(@Param("param_nombre") String nombre);

	@Query("select p from Producto p where p.idProducto != :param_producto and p.nombre like :param_nombre and p.estado = 'activado'")
	public abstract List<Producto> listaProductosNombreDiferenteId(@Param("param_producto") int idProducto,
			@Param("param_nombre") String nombre);

}
