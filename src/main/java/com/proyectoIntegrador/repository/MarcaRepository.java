package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.proyectoIntegrador.entity.Marca;

public interface MarcaRepository extends JpaRepository<Marca, Integer> {

	public abstract List<Marca> findByNombre(String nombre);

	@Query("select m from Marca m where m.idMarca != :param_marca and m.nombre like :param_nombre")
	public abstract List<Marca> listaMarcasNombreDiferenteId(@Param("param_marca") int idMarca,
			@Param("param_nombre") String nombre);

}
