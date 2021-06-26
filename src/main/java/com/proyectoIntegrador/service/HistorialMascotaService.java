package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.HistorialMascota;

public interface HistorialMascotaService {

	public abstract HistorialMascota registrarHistorialMas(HistorialMascota obj);

	public abstract List<HistorialMascota> listarHistorialMascotaNombreCliente(int idCliente, String mascotaNombre);

	public abstract HistorialMascota listarHistorialMascotaId(int idHistorialMascota);

	public abstract List<HistorialMascota> listarHistorialClienteNombre(String clienteNombre);

}
