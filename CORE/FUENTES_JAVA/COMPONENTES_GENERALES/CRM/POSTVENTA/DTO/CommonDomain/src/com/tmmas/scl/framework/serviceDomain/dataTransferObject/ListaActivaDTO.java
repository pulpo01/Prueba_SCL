/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 24/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;

public class ListaActivaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codigo;
	private String valor;
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getValor() {
		return valor;
	}
	public void setValor(String valor) {
		this.valor = valor;
	}
}
