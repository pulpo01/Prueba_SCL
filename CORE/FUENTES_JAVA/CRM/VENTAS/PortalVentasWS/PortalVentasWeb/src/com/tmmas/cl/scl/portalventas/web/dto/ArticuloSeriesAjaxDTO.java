package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class ArticuloSeriesAjaxDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codigoArticulo;
	private String desArticulo;
	
	public String getCodigoArticulo() {
		return codigoArticulo;
	}
	public void setCodigoArticulo(String codigoArticulo) {
		this.codigoArticulo = codigoArticulo;
	}
	public String getDesArticulo() {
		return desArticulo;
	}
	public void setDesArticulo(String desArticulo) {
		this.desArticulo = desArticulo;
	}
}
