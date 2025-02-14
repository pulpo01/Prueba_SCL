package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoLineaDTO;

public class WsCunetaAltaDeLineaOutDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private WsLineaOutDTO[] lineaOut;
	private String numVenta;
	private RetornoLineaDTO[] errores;
	private String resultadoTransaccion="0";
	
	
	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}
	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}
		
	public RetornoLineaDTO[] getErrores() {
		return errores;
	}
	public void setErrores(RetornoLineaDTO[] errores) {
		this.errores = errores;
	}
	public WsLineaOutDTO[] getLineaOut() {
		return lineaOut;
	}
	public void setLineaOut(WsLineaOutDTO[] lineaOut) {
		this.lineaOut = lineaOut;
	}
	public String getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}

}
