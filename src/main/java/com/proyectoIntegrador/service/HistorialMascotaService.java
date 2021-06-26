package com.proyectoIntegrador.service;



import java.util.List;

import com.proyectoIntegrador.entity.HistorialMascota;




public interface HistorialMascotaService {

	
	public abstract HistorialMascota registrarHistorialMas(HistorialMascota obj);

	public abstract List<HistorialMascota> listarHistorialMascotaNombre(String mascotaNombre);
	
	public abstract HistorialMascota listarHistorialMascotaId(int idHistorialMascota);

	public abstract List<HistorialMascota> listarHistorialClienteNombre(String clienteNombre);
	
	public abstract List<HistorialMascota> listarHistorialClienteNombreId(int clienteNombreId);
	
}
