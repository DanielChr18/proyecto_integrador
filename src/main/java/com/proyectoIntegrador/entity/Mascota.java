package com.proyectoIntegrador.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Entity
@Table(name = "mascota")
@Data
public class Mascota {

	@Column(name = "idmascota")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idMascota;

	@Column(name = "nombre")
	private String nombre;

	@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idtipomascota")
	private TipoMascota idTipoMascota;

	@Column(name = "raza")
	private String raza;

	@Column(name = "fechaNacimiento")
	private String fechaNacimiento;

	@Column(name = "sexo")
	private String sexo;

	@Column(name = "imagen")
	private String imagen;

	@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idcliente")
	private Cliente idCliente;
}
