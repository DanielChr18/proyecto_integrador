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
@Table(name = "historialmascota")
@Data
public class HistorialMascota {

	@Column(name = "idhistorialmascota")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idHistorialMascota;

	@Column(name = "fecha")
	private String fecha;

	@Column(name = "hora")
	private String hora;

	@Column(name = "descripcion")
	private String descripcion;

	@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idtrabajador")
	private Trabajador idTrabajador;

	@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idmascota")
	private Mascota idMascota;
}
