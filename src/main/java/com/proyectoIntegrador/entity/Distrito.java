package com.proyectoIntegrador.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "distrito")
@Data
public class Distrito {
	@Column(name = "iddistrito")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idDistrito;

	@Column(name = "ubigeo")
	private String ubigeo;

	@Column(name = "nombre")
	private String nombre;
}
