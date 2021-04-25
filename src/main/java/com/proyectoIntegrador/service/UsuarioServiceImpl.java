package com.proyectoIntegrador.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.Usuario;
import com.proyectoIntegrador.repository.UsuarioRepository;

@Service
public class UsuarioServiceImpl implements UsuarioService {

	@Autowired
	private UsuarioRepository repository;

	@Override
	public Usuario buscarUsuario(String usuario, String contrasenia) {
		return repository.buscarUsuario(usuario, contrasenia);
	}

	@Override
	public Usuario agregarUsuario(Usuario obj) {
		return repository.save(obj);
	}

	@Override
	public Usuario modificarUsuario(Usuario obj) {
		return repository.save(obj);
	}

	@Override
	public void eliminarUsuario(int idUsuario) {
		repository.deleteById(idUsuario);
	}

	@Override
	public Usuario findByNomUsuario(String nomUsuario) {
		return repository.findByNomUsuario(nomUsuario);
	}
}
