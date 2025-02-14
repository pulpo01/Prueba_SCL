package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.retorno;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO;

public class WsCentralesDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CentralDTO[] centrales; 
	private String resultadoTransaccion="0";
	private String codError="0";
	

	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}
	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}
	public CentralDTO[] getCentrales() {
		return centrales;
	}
	public void setCentrales(CentralDTO[] centrales) {
		this.centrales = centrales;
	}

}
