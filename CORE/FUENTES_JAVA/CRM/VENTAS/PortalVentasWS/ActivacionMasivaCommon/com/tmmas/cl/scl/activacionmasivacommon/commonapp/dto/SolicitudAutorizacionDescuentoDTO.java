package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

public class SolicitudAutorizacionDescuentoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private long numeroAutorizacion;
	private String codigoEstado;
	private String descripcionEstado;
	public String getDescripcionEstado() {
		return descripcionEstado;
	}
	public void setDescripcionEstado(String descripcionEstado) {
		this.descripcionEstado = descripcionEstado;
	}
	public String getCodigoEstado() {
		return codigoEstado;
	}
	public void setCodigoEstado(String codigoEstado) {
		this.codigoEstado = codigoEstado;
	}
	public long getNumeroAutorizacion() {
		return numeroAutorizacion;
	}
	public void setNumeroAutorizacion(long numeroAutorizacion) {
		this.numeroAutorizacion = numeroAutorizacion;
	}

}
