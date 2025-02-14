package com.tmmas.cl.scl.commonbusinessentities.dto;

import java.io.Serializable;

public class NumeroFrecuenteDTO implements Serializable
{

	private static final long serialVersionUID = 1L;
	
	private long numero; 
	private String descripcion; 
	private String tipo;
	private String codTipo;
		
	
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public long getNumero() {
		return numero;
	}
	public void setNumero(long numero) {
		this.numero = numero;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getCodTipo() {
		return codTipo;
	}
	public void setCodTipo(String codTipo) {
		this.codTipo = codTipo;
	}

}
