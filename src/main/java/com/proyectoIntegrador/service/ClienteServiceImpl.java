package com.proyectoIntegrador.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.Cliente;
import com.proyectoIntegrador.repository.ClienteRepository;

@Service
public class ClienteServiceImpl implements ClienteService {

	@Autowired
	private ClienteRepository repository;

	@Override
	public Cliente buscarClienteUsuario(int idUsuario) {
		return repository.buscarClienteUsuario(idUsuario);
	}

	@Override
	public Cliente listaClientesId(int idCliente) {
		return repository.findById(idCliente).get();
	}

	@Override
	public Cliente agregarCliente(Cliente obj) {
		return repository.save(obj);
	}

	@Override
	public Cliente modificarCliente(Cliente obj) {
		return repository.save(obj);
	}

	@Override
	public void eliminarCliente(int idCliente) {
		repository.deleteById(idCliente);
	}
}
