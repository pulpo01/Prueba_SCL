/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 11/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

public class FormaPagoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String tipoValor;
	private String descripcionTipoValor;
	
	public String getDescripcionTipoValor() {
		return descripcionTipoValor;
	}
	public void setDescripcionTipoValor(String descripcionTipoValor) {
		this.descripcionTipoValor = descripcionTipoValor;
	}
	public String getTipoValor() {
		return tipoValor;
	}
	public void setTipoValor(String tipoValor) {
		this.tipoValor = tipoValor;
	}
}
