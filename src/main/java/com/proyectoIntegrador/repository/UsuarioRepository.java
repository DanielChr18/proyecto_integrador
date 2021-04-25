package com.proyectoIntegrador.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

	@Query("select u from Usuario u where u.nomUsuario like :param_usuario and u.contrasenia like :param_contrasenia")
	public abstract Usuario buscarUsuario(@Param("param_usuario") String usuario,
			@Param("param_contrasenia") String contrasenia);

	public abstract Usuario findByNomUsuario(String nomUsuario);
}
