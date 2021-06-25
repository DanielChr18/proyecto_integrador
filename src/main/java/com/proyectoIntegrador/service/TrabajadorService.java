package com.proyectoIntegrador.service;


import com.proyectoIntegrador.entity.Trabajador;

public interface TrabajadorService {

	public abstract Trabajador buscarTrabajadorUsuario(int idUsuario);
	
	
	public abstract Trabajador listarTrabajadorId(int idTrabajador);
}
