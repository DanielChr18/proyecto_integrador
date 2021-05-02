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
@Table(name = "producto")
@Data
public class Producto {

	@Column(name = "idproducto")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idProducto;

	@Column(name = "nombre")
	private String nombre;

	@Column(name = "precio")
	private double precio;

	@Column(name = "stock")
	private int stock;

	@Column(name = "serie")
	private String serie;

	@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idmarca")
	private Marca idMarca;

	@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idproveedor")
	private Proveedor idProveedor;

	@Column(name = "descripcion")
	private String descripcion;

	@Column(name = "descripcionlarga")
	private String descripcionLarga;

	@Column(name = "estado")
	private String estado;

	@Column(name = "imagen1")
	private String imagen1;

	@Column(name = "imagen2")
	private String imagen2;

	@Column(name = "imagen3")
	private String imagen3;

}
