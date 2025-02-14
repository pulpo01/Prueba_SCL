package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class TipoContratoSIGADTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -169238879284743154L;
	private String codTipContrato;
	private Integer numMeses;
	private String fecFinContrato;
	public String getCodTipContrato() {
		return codTipContrato;
	}
	public void setCodTipContrato(String codTipContrato) {
		this.codTipContrato = codTipContrato;
	}
	
	public Integer getNumMeses() {
		return numMeses;
	}
	public void setNumMeses(Integer numMeses) {
		this.numMeses = numMeses;
	}
	public String getFecFinContrato() {
		return fecFinContrato;
	}
	public void setFecFinContrato(String fecFinContrato) {
		this.fecFinContrato = fecFinContrato;
	}
	
	

}
