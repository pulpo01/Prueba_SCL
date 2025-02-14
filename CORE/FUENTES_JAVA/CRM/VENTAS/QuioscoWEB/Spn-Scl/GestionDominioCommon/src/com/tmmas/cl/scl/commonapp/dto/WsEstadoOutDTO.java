package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.EstadoDTO;



public class WsEstadoOutDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//-- MANEJO DE ERRORES
	private Long codigoError;
	private String descripcionError;
	private Long numeroEvento;
	private String resultadoTransaccion;
	
	
	private EstadoDTO[] estadoDTOs;


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

	public EstadoDTO[] getEstadoDTOs() {
		return estadoDTOs;
	}


	public void setEstadoDTOs(EstadoDTO[] estadoDTOs) {
		this.estadoDTOs = estadoDTOs;
	}


	public Long getNumeroEvento() {
		return numeroEvento;
	}


	public void setNumeroEvento(Long numeroEvento) {
		this.numeroEvento = numeroEvento;
	}


	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}


	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}


}
