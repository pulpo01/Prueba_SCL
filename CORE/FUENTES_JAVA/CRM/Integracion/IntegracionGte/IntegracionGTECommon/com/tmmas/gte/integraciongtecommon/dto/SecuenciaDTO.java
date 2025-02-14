package com.tmmas.gte.integraciongtecommon.dto;
//package com.tmmas.scl.framework.customerDomain.dataTransferObject;
import java.io.Serializable;

public class SecuenciaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String nomSecuencia;
	private long numSecuencia;
	private RespuestaDTO respuesta;
	
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public String getNomSecuencia() {
		return nomSecuencia;
	}
	public void setNomSecuencia(String nomSecuencia) {
		this.nomSecuencia = nomSecuencia;
	}
	public long getNumSecuencia() {
		return numSecuencia;
	}
	public void setNumSecuencia(long numSecuencia) {
		this.numSecuencia = numSecuencia;
	}
}
