package com.proyectoIntegrador.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "categoria")
@Data
public class Categoria {

	@Column(name = "idcategoria")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idCategoria;

	@Column(name = "nombre")
	private String nombre;

}
