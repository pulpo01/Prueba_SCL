package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class PagoRecaudadoraOutDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	private String recaudadora;             
	private String descripcionEmpresa;
	private RespuestaDTO respuesta;
    public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getDescripcionEmpresa() {
		return descripcionEmpresa;
	}
	public void setDescripcionEmpresa(String descripcionEmpresa) {
		this.descripcionEmpresa = descripcionEmpresa;
	}
	public String getRecaudadora() {
		return recaudadora;
	}
	public void setRecaudadora(String recaudadora) {
		this.recaudadora = recaudadora;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
}