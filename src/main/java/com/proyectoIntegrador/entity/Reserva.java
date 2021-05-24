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
@Table(name = "reserva")
@Data
public class Reserva {
	
	@Column(name = "idreserva")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idReserva;

	@Column(name = "fecha")
	private String fecha;

	@Column(name = "horario")
	private String horario;

	@Column(name = "estado")
	private String estado;

	@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idcliente")
	private Cliente idCliente;

	@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idservicio")
	private Servicio idServicio;

}
