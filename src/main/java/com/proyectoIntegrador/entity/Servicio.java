package com.proyectoIntegrador.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "servicio")
@Data
public class Servicio {
	@Column(name = "idservicio")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idServicio;

	@Column(name = "nombre")
	private String nombre;

	@Column(name = "precio")
	private double precio;

	@Column(name = "descripcion")
	private String descripcion;

	@Column(name = "dia")
	private String dia;

	@Column(name = "estado")
	private String estado;

	@Column(name = "imagen")
	private String imagen;

}
