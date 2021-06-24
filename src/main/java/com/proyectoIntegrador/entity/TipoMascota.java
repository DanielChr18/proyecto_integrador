package com.proyectoIntegrador.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "tipomascota")
@Data
public class TipoMascota {

	@Column(name = "idtipomascota")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idTipoMascota;

	@Column(name = "nombre")
	private String nombre;

}
