package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class CantidadSerieDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
		
	private String codArticulo;
	private String codBodega;
	private String codUso;
		
	public String getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(String codBodega) {
		this.codBodega = codBodega;
	}
	public String getCodUso() {
		return codUso;
	}
	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}
	
	

}
