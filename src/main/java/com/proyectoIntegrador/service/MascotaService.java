package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Mascota;

public interface MascotaService {

	public abstract List<Mascota> listarMascotaCliente(int idCliente);

	public abstract Mascota listarMascotaId(int idMascota);

	public abstract List<Mascota> listarMascotas();

	public abstract Mascota agregarModificarMascota(Mascota obj);

	public abstract void eliminarMascota(int idMascota);
}
