package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class CategoriaCambioClienteDTO implements Serializable{

	/**
	 * CSR-11002 - (AL) - 2011.07.27
	 */
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
