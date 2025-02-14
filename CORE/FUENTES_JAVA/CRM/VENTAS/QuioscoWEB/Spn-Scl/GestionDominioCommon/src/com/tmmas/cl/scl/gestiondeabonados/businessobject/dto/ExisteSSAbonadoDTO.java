package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class ExisteSSAbonadoDTO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long numAbonado;
	private String codigoServicio;
	private String codigoServSupl;
	
	//	-- MANEJO DE ERRORES
	private Long codigoError;
	private String descripcionError;
	private Long numeroEvento;
	
	public Long getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(Long codigoError) {
		this.codigoError = codigoError;
	}
	public String getCodigoServicio() {
		return codigoServicio;
	}
	public void setCodigoServicio(String codigoServicio) {
		this.codigoServicio = codigoServicio;
	}
	public String getCodigoServSupl() {
		return codigoServSupl;
	}
	public void setCodigoServSupl(String codigoServSupl) {
		this.codigoServSupl = codigoServSupl;
	}
	public String getDescripcionError() {
		return descripcionError;
	}
	public void setDescripcionError(String descripcionError) {
		this.descripcionError = descripcionError;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public Long getNumeroEvento() {
		return numeroEvento;
	}
	public void setNumeroEvento(Long numeroEvento) {
		this.numeroEvento = numeroEvento;
	}
	
	

}
