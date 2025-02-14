package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;

public class WsCategoriaImpostivaOutDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//-- MANEJO DE ERRORES
	private Long codigoError;
	private String descripcionError;
	private String resultadoTransaccion;
	
	
	private ClienteDTO[] clienteDTOs;


	public ClienteDTO[] getClienteDTOs() {
		return clienteDTOs;
	}


	public void setClienteDTOs(ClienteDTO[] clienteDTOs) {
		this.clienteDTOs = clienteDTOs;
	}


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


	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}


	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}

}
