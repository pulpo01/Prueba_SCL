package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class CategoriaCambioClienteDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long codCliente;
	private int codCategoriaCambio;
	private String nomUsuario;
	
	public int getCodCategoriaCambio() {
		return codCategoriaCambio;
	}
	public void setCodCategoriaCambio(int codCategoriaCambio) {
		this.codCategoriaCambio = codCategoriaCambio;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	
	
}
