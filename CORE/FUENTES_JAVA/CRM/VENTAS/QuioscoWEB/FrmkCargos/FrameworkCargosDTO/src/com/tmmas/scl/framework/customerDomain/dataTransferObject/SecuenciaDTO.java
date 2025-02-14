/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 13/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class SecuenciaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String nomSecuencia;
	private long numSecuencia;
	
	public String getNomSecuencia() {
		return nomSecuencia;
	}
	public void setNomSecuencia(String nomSecuencia) {
		this.nomSecuencia = nomSecuencia;
	}
	public long getNumSecuencia() {
		return numSecuencia;
	}
	public void setNumSecuencia(long numSecuencia) {
		this.numSecuencia = numSecuencia;
	}
}
