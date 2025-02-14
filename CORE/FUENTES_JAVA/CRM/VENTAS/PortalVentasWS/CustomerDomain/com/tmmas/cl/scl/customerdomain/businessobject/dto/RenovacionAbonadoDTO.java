package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class RenovacionAbonadoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long	numAbonado;
	private int		indRenovacion;
	
	private long numFax;  
	private String codCalificacion;
	
	public String getCodCalificacion() {
		return codCalificacion;
	}
	public void setCodCalificacion(String codCalificacion) {
		this.codCalificacion = codCalificacion;
	}
	public long getNumFax() {
		return numFax;
	}
	public void setNumFax(long numFax) {
		this.numFax = numFax;
	}
	public int getIndRenovacion() {
		return indRenovacion;
	}
	public void setIndRenovacion(int indRenovacion) {
		this.indRenovacion = indRenovacion;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	
}
