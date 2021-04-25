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
@Table(name = "boleta")
@Data
public class Boleta {
	@Column(name = "idboleta")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idBoleta;

	@Column(name = "numero")
	private String numero;

	@Column(name = "nombre")
	private String nombre;

	@Column(name = "dni")
	private String dni;

	@Column(name = "monto")
	private double monto;

	@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idcliente")
	private Cliente idCliente;

}
