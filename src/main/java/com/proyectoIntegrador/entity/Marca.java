package com.proyectoIntegrador.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "marca")
@Data
public class Marca {

	@Column(name = "idmarca")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idMarca;

	@Column(name = "nombre")
	private String nombre;
}
