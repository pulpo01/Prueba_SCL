/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 24/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;

public class SaldoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long numCelular;
	private String codTecnologia;
	private String saldo;
	
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public String getSaldo() {
		return saldo;
	}
	public void setSaldo(String saldo) {
		this.saldo = saldo;
	}
}
