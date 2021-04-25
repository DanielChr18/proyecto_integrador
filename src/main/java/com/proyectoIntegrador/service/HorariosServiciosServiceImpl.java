package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.HorariosServicios;
import com.proyectoIntegrador.repository.HorariosServiciosRepository;

@Service
public class HorariosServiciosServiceImpl implements HorariosServiciosService {

	@Autowired
	private HorariosServiciosRepository repository;

	@Override
	public List<HorariosServicios> listarHorarios() {
		return repository.findAll();
	}

	@Override
	public List<HorariosServicios> listarHorariosServicios(int idServicio) {
		return repository.listarHorasServicios(idServicio);
	}

	@Override
	public HorariosServicios agregarHorario(HorariosServicios obj) {
		return repository.save(obj);
	}

	@Override
	public void eliminarHorario(int idHorario) {
		repository.deleteById(idHorario);
	}

	@Override
	public HorariosServicios listarHoraServicio(int idServicio, String horario) {
		return repository.listarHoraServicio(idServicio, horario);
	}

}
