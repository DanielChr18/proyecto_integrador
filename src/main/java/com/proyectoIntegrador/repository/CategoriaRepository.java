package com.proyectoIntegrador.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proyectoIntegrador.entity.Categoria;

public interface CategoriaRepository extends JpaRepository<Categoria, Integer> {

}
