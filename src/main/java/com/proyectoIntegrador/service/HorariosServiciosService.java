package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.HorariosServicios;

public interface HorariosServiciosService {

	public abstract List<HorariosServicios> listarHorarios();

	public abstract List<HorariosServicios> listarHorariosServicios(int idServicio);

	public abstract HorariosServicios listarHoraServicio(int idServicio, String horario);

	public abstract HorariosServicios agregarHorario(HorariosServicios obj);

	public abstract void eliminarHorario(int idHorario);
}
