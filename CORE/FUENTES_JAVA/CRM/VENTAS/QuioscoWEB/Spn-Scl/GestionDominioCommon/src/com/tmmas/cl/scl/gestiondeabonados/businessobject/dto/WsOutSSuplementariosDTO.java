package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class WsOutSSuplementariosDTO extends RetornoDTO  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private SSuplementariosDTO[] serviciosSuplementarios;
	private String resultadoTransaccion="0";


	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}


	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}


	public SSuplementariosDTO[] getServiciosSuplementarios() {
		return serviciosSuplementarios;
	}


	public void setServiciosSuplementarios(
			SSuplementariosDTO[] serviciosSuplementarios) {
		this.serviciosSuplementarios = serviciosSuplementarios;
	}
	
}
