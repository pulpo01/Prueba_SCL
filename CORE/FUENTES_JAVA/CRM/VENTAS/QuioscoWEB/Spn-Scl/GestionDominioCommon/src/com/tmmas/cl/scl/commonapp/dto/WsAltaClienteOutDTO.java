package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class WsAltaClienteOutDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoCliente;
	private RetornoDTO[] errores;
	private String resultadoTransaccion="0";

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

	public String getCodigoCliente() {
		return codigoCliente;
	}

	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}

}
