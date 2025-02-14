package com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto;

import java.io.Serializable;

public class PuebloDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoPueblo;
	private String codigoEstado;
	private String descripcionPueblo;
	
	public String getCodigoEstado() {
		return codigoEstado;
	}
	public void setCodigoEstado(String codigoEstado) {
		this.codigoEstado = codigoEstado;
	}
	public String getCodigoPueblo() {
		return codigoPueblo;
	}
	public void setCodigoPueblo(String codigoPueblo) {
		this.codigoPueblo = codigoPueblo;
	}
	public String getDescripcionPueblo() {
		return descripcionPueblo;
	}
	public void setDescripcionPueblo(String descripcionPueblo) {
		this.descripcionPueblo = descripcionPueblo;
	}

}
