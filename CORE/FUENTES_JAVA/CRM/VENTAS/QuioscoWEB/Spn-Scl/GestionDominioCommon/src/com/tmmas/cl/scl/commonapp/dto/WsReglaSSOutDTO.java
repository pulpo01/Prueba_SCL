package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReglaCompatibilidadSSDTO;

public class WsReglaSSOutDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//-- MANEJO DE ERRORES
	private Long codigoError;
	private String descripcionError;
	private Long numeroEvento;
	private String resultadoTransaccion;
	
	
	
	ReglaCompatibilidadSSDTO[] reglaCompatibilidadSSDTOs;

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

	public ReglaCompatibilidadSSDTO[] getReglaCompatibilidadSSDTOs() {
		return reglaCompatibilidadSSDTOs;
	}

	public void setReglaCompatibilidadSSDTOs(
			ReglaCompatibilidadSSDTO[] reglaCompatibilidadSSDTOs) {
		this.reglaCompatibilidadSSDTOs = reglaCompatibilidadSSDTOs;
	}

	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}

	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}
	

}
