package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class MigracionPrepagoPostpagoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long numVenta;
	private Long numAbonado;
	private String codError;
	private String desError;
	private Integer numEvento;
	private String numOOSS;
	
	public String getNumOOSS() {
		return numOOSS;
	}
	public void setNumOOSS(String numOOSS) {
		this.numOOSS = numOOSS;
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getDesError() {
		return desError;
	}
	public void setDesError(String desError) {
		this.desError = desError;
	}
	public Long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(Long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public Integer getNumEvento() {
		return numEvento;
	}
	public void setNumEvento(Integer numEvento) {
		this.numEvento = numEvento;
	}
	public Long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(Long numVenta) {
		this.numVenta = numVenta;
	}
	
}
