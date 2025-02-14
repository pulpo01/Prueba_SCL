package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class TipoServicioResponseDTO implements Serializable {
	/**
	 * Autor : Leonardo Muñoz R.
	 * Modificado : JDMQ
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codPrestacion;
	private String desPrestacion;
	private RespuestaDTO respuesta;
	
	public String getDesPrestacion() {
		return desPrestacion;
	}
	public void setDesPrestacion(String desPrestacion) {
		this.desPrestacion = desPrestacion;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getCodPrestacion() {
		return codPrestacion;
	}
	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
	}
	
	
}
