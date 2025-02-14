package com.tmmas.cl.scl.migracionmasiva.dto;

import java.io.Serializable;

public class WSDatosSalidaDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codError;
	private String descError;
	private String nroEvento;
//	private String nroVenta;
//	private String numAboPospago;
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getDescError() {
		return descError;
	}
	public void setDescError(String descError) {
		this.descError = descError;
	}
	public String getNroEvento() {
		return nroEvento;
	}
	public void setNroEvento(String nroEvento) {
		this.nroEvento = nroEvento;
	}

}
