package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class ArticuloOutDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private long  codigo;
	private String descripcion;
	private String codModelo;
	private String codFabricante;
	private String desFabricante;	
	
	public String getCodFabricante() {
		return codFabricante;
	}
	public void setCodFabricante(String codFabricante) {
		this.codFabricante = codFabricante;
	}
	public long getCodigo() {
		return codigo;
	}
	public void setCodigo(long codigo) {
		this.codigo = codigo;
	}
	public String getCodModelo() {
		return codModelo;
	}
	public void setCodModelo(String codModelo) {
		this.codModelo = codModelo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getDesFabricante() {
		return desFabricante;
	}
	public void setDesFabricante(String desFabricante) {
		this.desFabricante = desFabricante;
	}
}
