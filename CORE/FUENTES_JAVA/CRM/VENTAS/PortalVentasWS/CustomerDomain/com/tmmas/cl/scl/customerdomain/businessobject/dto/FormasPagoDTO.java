package com.tmmas.cl.scl.customerdomain.businessobject.dto;
import java.io.Serializable;

public class FormasPagoDTO implements Serializable{
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