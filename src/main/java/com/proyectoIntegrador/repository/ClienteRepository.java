package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.Cliente;

public interface ClienteRepository extends JpaRepository<Cliente, Integer> {

	@Query("select c from Cliente c where c.idUsuario.idUsuario like :param_usuario")
	public abstract Cliente listaClienteUsuario(@Param("param_usuario") int usuario);

	public abstract List<Cliente> findByDni(String dni);

	public abstract List<Cliente> findByEmail(String email);

	@Query("select c from Cliente c where c.idCliente != :param_cliente and c.dni like :param_dni")
	public abstract List<Cliente> listaClientesDniDiferenteId(@Param("param_cliente") int idCliente,
			@Param("param_dni") String dni);

	@Query("select c from Cliente c where c.idCliente != :param_cliente and c.email like :param_email")
	public abstract List<Cliente> listaClientesEmailDiferenteId(@Param("param_cliente") int idCliente,
			@Param("param_email") String email);

}
