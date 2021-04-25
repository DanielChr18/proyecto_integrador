package com.proyectoIntegrador.service;

import com.proyectoIntegrador.entity.Cliente;

public interface ClienteService {

	public abstract Cliente listaClientesId(int idCliente);

	public abstract Cliente buscarClienteUsuario(int idUsuario);

	public abstract Cliente agregarCliente(Cliente obj);

	public abstract Cliente modificarCliente(Cliente obj);

	public abstract void eliminarCliente(int idCliente);
}
