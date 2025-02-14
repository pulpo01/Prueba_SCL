package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;

public class WsConsCargosVentaOutDTO implements Serializable{
	
	/**
	 * 
	**/
	private static final long serialVersionUID = 1L;
	private ObtencionCargosDTO cargos;
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
	public ObtencionCargosDTO getCargos() {
		return cargos;
	}
	public void setCargos(ObtencionCargosDTO cargos) {
		this.cargos = cargos;
	}
	
}
