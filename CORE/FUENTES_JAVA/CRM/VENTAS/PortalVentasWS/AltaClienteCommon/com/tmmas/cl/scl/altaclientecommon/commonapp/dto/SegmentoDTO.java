package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class SegmentoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private Long codigoSegmento;
	private String descripcionSegmento;
	
	public Long getCodigoSegmento() {
		return codigoSegmento;
	}
	public void setCodigoSegmento(Long codigoSegmento) {
		this.codigoSegmento = codigoSegmento;
	}	
	public String getDescripcionSegmento() {
		return descripcionSegmento;
	}
	public void setDescripcionSegmento(String descripcionSegmento) {
		this.descripcionSegmento = descripcionSegmento;
	}
		
}//fin class OperadoraDTO