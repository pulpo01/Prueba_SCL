package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConsAvisoSiniestroResponseDTO implements Serializable{
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	private AvisoSiniestroDTO[]  listadoSiniestros;
	private RespuestaDTO respuesta;
	
	public AvisoSiniestroDTO[] getListadoSiniestros() {
		return listadoSiniestros;
	}
	public void setListadoSiniestros(AvisoSiniestroDTO[] listadoSiniestros) {
		this.listadoSiniestros = listadoSiniestros;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
	

}
