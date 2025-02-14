package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class DatosPeticionDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codBodegaOrigen;
	private String codBodegaDestino;
	private String usuarioPeticion;
	
	public String getCodBodegaOrigen() {
		return codBodegaOrigen;
	}
	public void setCodBodegaOrigen(String codBodegaOrigen) {
		this.codBodegaOrigen = codBodegaOrigen;
	}
	public String getCodBodegaDestino() {
		return codBodegaDestino;
	}
	public void setCodBodegaDestino(String codBodegaDestino) {
		this.codBodegaDestino = codBodegaDestino;
	}
	public String getUsuarioPeticion() {
		return usuarioPeticion;
	}
	public void setUsuarioPeticion(String usuarioPeticion) {
		this.usuarioPeticion = usuarioPeticion;
	}
}
