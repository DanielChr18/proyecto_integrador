package com.proyectoIntegrador.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.proyectoIntegrador.entity.Marca;

public interface MarcaRepository extends JpaRepository<Marca, Integer> {

	@Query("select e from Marca e where e.nombre like :param_nombre")
	public abstract List<Marca> listaMarcasNombre(@Param("param_nombre") String nombre);
	
}
