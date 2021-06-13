package com.proyectoIntegrador.service;

import java.util.List;

import com.proyectoIntegrador.entity.Cliente;

public interface ClienteService {

	public abstract List<Cliente> listaClientes();

	public abstract Cliente listaClientesId(int idCliente);

	public abstract List<Cliente> listaClientesDni(String dni);

	public abstract List<Cliente> listaClientesEmail(String email);

	public abstract List<Cliente> listaClientesDniDiferenteId(int idCliente, String dni);

	public abstract List<Cliente> listaClientesEmailDiferenteId(int idCliente, String email);

	public abstract Cliente listaClienteUsuario(int idUsuario);

	public abstract Cliente agregarModificarCliente(Cliente obj);

	public abstract void eliminarCliente(int idCliente);
}
