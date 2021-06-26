package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.FechasServicios;

public interface FechasServiciosService {

	public abstract List<FechasServicios> findByFechaServicio(String fecha, int idServicio);

	public abstract List<FechasServicios> findByHoraServicio(String hora, int idServicio);

	public abstract FechasServicios findByHoraFechaServicio(int idHorario, String fecha);

	public abstract List<FechasServicios> findByServicio(int idServicio);

	public abstract List<FechasServicios> findAll();

	public abstract FechasServicios agregarFechaServicio(FechasServicios obj);

	public abstract void eliminarFechaServicio(int idFechaServicio);
}
