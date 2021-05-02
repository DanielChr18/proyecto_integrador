package com.proyectoIntegrador.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoIntegrador.entity.Producto;
import com.proyectoIntegrador.repository.ProductoRepository;

@Service
public class ProductoServiceImpl implements ProductoService {

	@Autowired
	private ProductoRepository repository;

	@Override
	public List<Producto> listaProductos() {
		List<Producto> lista = repository.findAll();
		List<Producto> listaProductos = new ArrayList<Producto>();
		for (Producto p : lista) {
			if(p.getEstado().equals("activado"))
				listaProductos.add(p);
		}
		return listaProductos;
	}

	@Override
	public Producto listaProductosId(int idProducto) {
		return repository.findById(idProducto).get();
	}

	@Override
	public List<Producto> ListaProductosNombre(String nombre) {
		return repository.listaProductosNombre(nombre + "%");
	}

	@Override
	public Producto agregarProducto(Producto obj) {
		return repository.save(obj);
	}

	@Override
	public Producto modificarProducto(Producto obj) {
		return repository.save(obj);
	}
}
