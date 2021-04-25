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
@Table(name = "fechasservicios")
@Data
public class FechasServicios {

	@Column(name = "idfechasservicios")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idFechasServicios;

	@Column(name = "fecha")
	private String fecha;

	@Column(name = "estado")
	private String estado;

	@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idhorariosservicios")
	private HorariosServicios idHorariosServicios;
}
