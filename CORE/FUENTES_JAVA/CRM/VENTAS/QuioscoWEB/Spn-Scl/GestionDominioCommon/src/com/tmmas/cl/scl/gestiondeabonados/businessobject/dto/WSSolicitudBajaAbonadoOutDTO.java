package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class WSSolicitudBajaAbonadoOutDTO implements Serializable {

	private static final long serialVersionUID = 1L;

    private RetornoDTO[] errores;
    private String resultadoTransaccion="0";
    private String NumOOSS;
	
	public String getNumOOSS() {
		return NumOOSS;
	}
	public void setNumOOSS(String numOOSS) {
		NumOOSS = numOOSS;
	}
	public RetornoDTO[] getErrores() {
		return errores;
	}
	public void setErrores(RetornoDTO[] errores) {
		this.errores = errores;
	}
	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}
	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}
}
