package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class WsDireccionOutDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoDireccion;
	private RetornoDTO errores[];
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
	public String getCodigoDireccion() {
		return codigoDireccion;
	}
	public void setCodigoDireccion(String codigoDireccion) {
		this.codigoDireccion = codigoDireccion;
	}

	
	
	
}
