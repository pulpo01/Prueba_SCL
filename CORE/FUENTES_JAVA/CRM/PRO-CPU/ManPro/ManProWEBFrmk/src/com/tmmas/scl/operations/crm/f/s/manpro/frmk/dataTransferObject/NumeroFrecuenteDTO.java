package com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject;

import java.io.Serializable;

public class NumeroFrecuenteDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long idProductoContratadoFrec;
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
	public long getIdProductoContratadoFrec() {
		return idProductoContratadoFrec;
	}
	public void setIdProductoContratadoFrec(long idProductoContratadoFrec) {
		this.idProductoContratadoFrec = idProductoContratadoFrec;
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
