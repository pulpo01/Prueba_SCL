package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConsultarConscFactDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	
	private long numFolio;
	private long codTipDocum;
	private long codCliente;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodTipDocum() {
		return codTipDocum;
	}
	public void setCodTipDocum(long codTipDocum) {
		this.codTipDocum = codTipDocum;
	}
	public long getNumFolio() {
		return numFolio;
	}
	public void setNumFolio(long numFolio) {
		this.numFolio = numFolio;
	}
	
		
	
	
}
