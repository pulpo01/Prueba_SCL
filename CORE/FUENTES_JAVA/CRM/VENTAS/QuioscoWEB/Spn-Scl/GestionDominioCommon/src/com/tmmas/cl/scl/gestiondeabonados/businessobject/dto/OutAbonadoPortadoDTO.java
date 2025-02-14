package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class OutAbonadoPortadoDTO extends RetornoDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long indPortado;
	private String resultadoTransaccion;

	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}

	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}

	public long getIndPortado() {
		return indPortado;
	}

	public void setIndPortado(long indPortado) {
		this.indPortado = indPortado;
	}

}
