package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class RoamingOUTDTO extends RetornoDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String fechaLlamada;
	private String detalle;
	
	public String getDetalle() {
		return detalle;
	}
	public void setDetalle(String detalle) {
		this.detalle = detalle;
	}
	public String getFechaLlamada() {
		return fechaLlamada;
	}
	public void setFechaLlamada(String fechaLlamada) {
		this.fechaLlamada = fechaLlamada;
	}
	
}
