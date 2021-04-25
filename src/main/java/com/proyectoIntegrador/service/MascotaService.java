package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Mascota;

public interface MascotaService {

	public abstract List<Mascota> listarMascotaCliente(int idCliente);

	public abstract Mascota agregarMascota(Mascota obj);

	public abstract Mascota modificarMascota(Mascota obj);

	public abstract void eliminarMascota(int idMascota);
}
