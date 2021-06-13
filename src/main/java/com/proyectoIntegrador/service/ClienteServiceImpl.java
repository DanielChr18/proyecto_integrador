package com.proyectoIntegrador.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.Cliente;
import com.proyectoIntegrador.repository.ClienteRepository;

@Service
public class ClienteServiceImpl implements ClienteService {

	@Autowired
	private ClienteRepository repository;

	@Override
	public List<Cliente> listaClientes() {
		return repository.findAll();
	}

	@Override
	public Cliente listaClientesId(int idCliente) {
		return repository.findById(idCliente).get();
	}

	@Override
	public Cliente listaClienteUsuario(int idUsuario) {
		return repository.listaClienteUsuario(idUsuario);
	}

	@Override
	public List<Cliente> listaClientesDni(String dni) {
		return repository.findByDni(dni);
	}

	@Override
	public List<Cliente> listaClientesEmail(String email) {
		return repository.findByEmail(email);
	}

	@Override
	public List<Cliente> listaClientesDniDiferenteId(int idCliente, String dni) {
		return repository.listaClientesDniDiferenteId(idCliente, dni);
	}

	@Override
	public List<Cliente> listaClientesEmailDiferenteId(int idCliente, String email) {
		return repository.listaClientesEmailDiferenteId(idCliente, email);
	}

	@Override
	public Cliente agregarModificarCliente(Cliente obj) {
		return repository.save(obj);
	}

	@Override
	public void eliminarCliente(int idCliente) {
		repository.deleteById(idCliente);
	}
}
