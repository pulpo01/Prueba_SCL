package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class DireccionRespOutDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	
	private DireccionOutDTO  direccionFacturacion;
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



	public DireccionOutDTO getDireccionFacturacion() {
		return direccionFacturacion;
	}



	public void setDireccionFacturacion(DireccionOutDTO direccionFacturacion) {
		this.direccionFacturacion = direccionFacturacion;
	}











	

}