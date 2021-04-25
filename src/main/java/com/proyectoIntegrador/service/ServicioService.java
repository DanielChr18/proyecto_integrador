package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Servicio;

public interface ServicioService {

	public abstract List<Servicio> listaServicios();
	
	public abstract Servicio listaServiciosNombre(String nombre);

	public abstract Servicio listaServiciosId(int idServicio);

	public abstract Servicio agregarServicio(Servicio obj);

	public abstract Servicio modificarServicio(Servicio obj);

	public abstract void eliminarServicio(int idServicio);

}
