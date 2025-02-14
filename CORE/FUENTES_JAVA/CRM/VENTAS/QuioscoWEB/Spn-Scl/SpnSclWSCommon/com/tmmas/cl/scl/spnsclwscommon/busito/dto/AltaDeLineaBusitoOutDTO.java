package com.tmmas.cl.scl.spnsclwscommon.busito.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.commonapp.dto.WsLineaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoLineaDTO;


public class AltaDeLineaBusitoOutDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private WsLineaOutDTO[] lineaOut;
	private String numVenta;
	private RetornoDTO[]  errores;
	private String resultadoTransaccion="0";
	
	public RetornoDTO[] getErrores() {
		return errores;
	}
	public void setErrores(RetornoDTO[] errores) {
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
	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}
	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}


}
