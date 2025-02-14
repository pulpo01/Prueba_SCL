package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class ReservaOutDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private RetornoDTO[] errores;
	private String resultadoTransaccion;
	
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
