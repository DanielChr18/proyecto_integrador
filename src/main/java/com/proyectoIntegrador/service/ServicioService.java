package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Servicio;

public interface ServicioService {

	public abstract List<Servicio> listaServicios();

	public abstract List<Servicio> listaServiciosNombre(String nombre);

	public abstract List<Servicio> listaNombreDiferenteId(int idServicio, String nombre);

	public abstract Servicio listaServiciosId(int idServicio);

	public abstract Servicio agregarModificarServicio(Servicio obj);

	public abstract void eliminarServicio(int idServicio);

}
