package com.tmmas.cl.scl.ss911correofax.dto;

import java.io.Serializable;

public class RetornoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected String numEvento;
	protected String descripcion;
	protected boolean oK;// true: transaccion exitosa false: viene error;
	
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getNumEvento() {
		return numEvento;
	}
	public void setNumEvento(String numEvento) {
		this.numEvento = numEvento;
	}
	public boolean isOK() {
		return oK;
	}
	public void setOK(boolean ok) {
		oK = ok;
	}
	

}
