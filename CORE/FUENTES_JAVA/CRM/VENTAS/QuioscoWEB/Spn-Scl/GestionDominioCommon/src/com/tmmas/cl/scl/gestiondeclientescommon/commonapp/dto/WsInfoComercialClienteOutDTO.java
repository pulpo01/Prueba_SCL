package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsInfoComercialClienteOutDTO extends RetornoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	
	private WsInfoComercialClienteDTO[] wsInfoComercialClienteDTO;
	private String resultadoTransaccion="0";

	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}

	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}

	public WsInfoComercialClienteDTO[] getWsInfoComercialClienteDTO() {
		return wsInfoComercialClienteDTO;
	}

	public void setWsInfoComercialClienteDTO(
			WsInfoComercialClienteDTO[] wsInfoComercialClienteDTO) {
		this.wsInfoComercialClienteDTO = wsInfoComercialClienteDTO;
	}
	
	
	
}
