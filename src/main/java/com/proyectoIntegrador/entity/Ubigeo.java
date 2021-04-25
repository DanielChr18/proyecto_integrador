package com.proyectoIntegrador.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Data
@Table(name = "ubigeo")
public class Ubigeo {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idUbigeo;
	private String departamento;
	private String provincia;
	private String distrito;
}
