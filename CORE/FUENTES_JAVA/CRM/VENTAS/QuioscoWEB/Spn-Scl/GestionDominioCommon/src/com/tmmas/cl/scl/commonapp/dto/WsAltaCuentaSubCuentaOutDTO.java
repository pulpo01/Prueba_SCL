package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;
import java.util.ArrayList;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;


public class WsAltaCuentaSubCuentaOutDTO implements Serializable{
	
	/**
	 * 
	 */
		
	private static final long serialVersionUID = 1L;
	
	private String CodigoCuenta;
	private RetornoDTO[] errores;
	private String resultadoTransaccion="0";

	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}

	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}

	public String getCodigoCuenta() {
		return CodigoCuenta;
	}

	public void setCodigoCuenta(String codigoCuenta) {
		CodigoCuenta = codigoCuenta;
	}

	public RetornoDTO[] getErrores() {
		return errores;
	}

	public void setErrores(RetornoDTO[] errores) {
		this.errores = errores;
	}


}
