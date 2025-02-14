package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsHomeLineaOutDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//-- MANEJO DE ERRORES
	private Long codigoError;
	private String descripcionError;
	private Long numeroEvento;
	private String resultadoTransaccion;
	
	
	private HomeLineaDTO[] homeLineaDTOs;


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


	public HomeLineaDTO[] getHomeLineaDTOs() {
		return homeLineaDTOs;
	}


	public void setHomeLineaDTOs(HomeLineaDTO[] homeLineaDTOs) {
		this.homeLineaDTOs = homeLineaDTOs;
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
