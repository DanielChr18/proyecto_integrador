package com.proyectoIntegrador.service;

import com.proyectoIntegrador.entity.Usuario;

public interface UsuarioService {

	public abstract Usuario buscarUsuario(String usuario, String contrasenia);

	public abstract Usuario agregarUsuario(Usuario obj);

	public abstract Usuario modificarUsuario(Usuario obj);

	public abstract void eliminarUsuario(int idUsuario);
	
	public abstract Usuario findByNomUsuario(String nomUsuario);
}
