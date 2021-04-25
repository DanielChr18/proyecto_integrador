package com.proyectoIntegrador.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.Cliente;

public interface ClienteRepository extends JpaRepository<Cliente, Integer> {

	@Query("select c from Cliente c where c.idUsuario.idUsuario like :param_usuario")
	public abstract Cliente buscarClienteUsuario(@Param("param_usuario") int usuario);
}
