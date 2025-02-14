package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class NivelAbonadoDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long   numAbonado;
	private String codNivel1;
	private String codNivel2;
	private String codNivel3;
	
	public String getCodNivel1() {
		return codNivel1;
	}
	public void setCodNivel1(String codNivel1) {
		this.codNivel1 = codNivel1;
	}
	public String getCodNivel2() {
		return codNivel2;
	}
	public void setCodNivel2(String codNivel2) {
		this.codNivel2 = codNivel2;
	}
	public String getCodNivel3() {
		return codNivel3;
	}
	public void setCodNivel3(String codNivel3) {
		this.codNivel3 = codNivel3;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	
}
