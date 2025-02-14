package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class GenericoOOSSDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private long numOS;
	private long codEvento;
	private String desEvento;
	private long codError;
	
	public long getCodError() {
		return codError;
	}
	public void setCodError(long codError) {
		this.codError = codError;
	}
	public long getCodEvento() {
		return codEvento;
	}
	public void setCodEvento(long codEvento) {
		this.codEvento = codEvento;
	}
	public String getDesEvento() {
		return desEvento;
	}
	public void setDesEvento(String desEvento) {
		this.desEvento = desEvento;
	}
	public long getNumOS() {
		return numOS;
	}
	public void setNumOS(long numOS) {
		this.numOS = numOS;
	}
	
	
}
