package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListClienteIdentOutDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private WsClienteIdentOutDTO[] wsClienteIdentArrOutDTO;
	private String resultadoTransaccion="0";
	private RetornoDTO[] errores;

	public WsClienteIdentOutDTO[] getWsClienteIdentArrOutDTO() {
		return wsClienteIdentArrOutDTO;
	}

	public void setWsClienteIdentArrOutDTO(
			WsClienteIdentOutDTO[] wsClienteIdentArrOutDTO) {
		this.wsClienteIdentArrOutDTO = wsClienteIdentArrOutDTO;
	}

	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}

	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}

	public RetornoDTO[] getErrores() {
		return errores;
	}

	public void setErrores(RetornoDTO[] errores) {
		this.errores = errores;
	}
}
