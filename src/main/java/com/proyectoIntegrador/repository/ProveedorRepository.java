package com.proyectoIntegrador.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoIntegrador.entity.Proveedor;

public interface ProveedorRepository extends JpaRepository<Proveedor, Integer> {

	public abstract List<Proveedor> findByRazonSocial(String razonSocial);

	public abstract List<Proveedor> findByRuc(String ruc);

	@Query("select p from Proveedor p where p.idProveedor != :param_proveedor and p.razonSocial like :param_razonSocial")
	public abstract List<Proveedor> listaProveedoresRazonSocialDiferenteId(@Param("param_proveedor") int idProveedor,
			@Param("param_razonSocial") String razonSocial);

	@Query("select p from Proveedor p where p.idProveedor != :param_proveedor and p.ruc like :param_ruc")
	public abstract List<Proveedor> listaProveedoresRucDiferenteId(@Param("param_proveedor") int idProveedor,
			@Param("param_ruc") String ruc);
}
