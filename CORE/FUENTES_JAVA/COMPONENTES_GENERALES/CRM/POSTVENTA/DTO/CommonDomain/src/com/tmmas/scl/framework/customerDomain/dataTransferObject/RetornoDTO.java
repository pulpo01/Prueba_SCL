/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codigo;
	private String descripcion;
	private boolean resultado;
	

	public boolean isResultado() {
		return resultado;
	}
	public void setResultado(boolean resultado) {
		this.resultado = resultado;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
}
