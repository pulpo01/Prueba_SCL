package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class ServicioOcacionalDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String codigoServicio;

	//-- MANEJO DE ERRORES
	private Long codigoError;
	private String descripcionError;
	private Long numeroEvento;
	
	public Long getCodigoError() {
		return codigoError;
	}

	public void setCodigoError(Long codigoError) {
		this.codigoError = codigoError;
	}

	public String getDescripcionError() {
		return descripcionError;
	}

	public void setDescripcionError(String descripcionError) {
		this.descripcionError = descripcionError;
	}

	public Long getNumeroEvento() {
		return numeroEvento;
	}

	public void setNumeroEvento(Long numeroEvento) {
		this.numeroEvento = numeroEvento;
	}

	public String getCodigoServicio() {
		return codigoServicio;
	}

	public void setCodigoServicio(String codigoServicio) {
		this.codigoServicio = codigoServicio;
	}

}//fin ServicioOcacionalDTO
