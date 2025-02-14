package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class SSuplementarioOutDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private RetornoDTO[] errores ;
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

}
