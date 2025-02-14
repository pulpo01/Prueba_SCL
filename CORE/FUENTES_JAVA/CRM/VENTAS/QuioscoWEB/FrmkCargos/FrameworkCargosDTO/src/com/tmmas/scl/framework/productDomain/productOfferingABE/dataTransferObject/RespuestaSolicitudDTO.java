/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 13/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

public class RespuestaSolicitudDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private long numeroAutorizacion;
	private String codigoEstado;
	
	public String getCodigoEstado() {
		return codigoEstado;
	}
	public void setCodigoEstado(String codigoEstado) {
		this.codigoEstado = codigoEstado;
	}
	public long getNumeroAutorizacion() {
		return numeroAutorizacion;
	}
	public void setNumeroAutorizacion(long numeroAutorizacion) {
		this.numeroAutorizacion = numeroAutorizacion;
	}
	
}
