package com.tmmas.cl.scl.ss911correofax.dto;

import java.io.Serializable;

public class TipDireccion911CorreoFaxDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected String codDireccion;
	protected String tipDireccion;
	protected String desTipDireccion;
	
	public String getCodDireccion() {
		return codDireccion;
	}
	public void setCodDireccion(String codDireccion) {
		this.codDireccion = codDireccion;
	}
	public String getDesTipDireccion() {
		return desTipDireccion;
	}
	public void setDesTipDireccion(String desTipDireccion) {
		this.desTipDireccion = desTipDireccion;
	}
	public String getTipDireccion() {
		return tipDireccion;
	}
	public void setTipDireccion(String tipDireccion) {
		this.tipDireccion = tipDireccion;
	}

}
