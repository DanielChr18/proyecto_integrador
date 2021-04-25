package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.Ubigeo;

public interface UbigeoRepositorio extends JpaRepository<Ubigeo, Integer> {

	@Query("select u from Ubigeo u group by u.departamento")
	public abstract List<Ubigeo> listaDepartamentos();

	@Query("select u from Ubigeo u where u.departamento = :param_departamento group by u.provincia")
	public abstract List<Ubigeo> listaProvincia(@Param("param_departamento") String departamento);

	@Query("select u from Ubigeo u where u.departamento = :param_departamento and u.provincia = :param_provincia")
	public abstract List<Ubigeo> listaDistrito(@Param("param_departamento") String departamento,
			@Param("param_provincia") String provincia);
}
