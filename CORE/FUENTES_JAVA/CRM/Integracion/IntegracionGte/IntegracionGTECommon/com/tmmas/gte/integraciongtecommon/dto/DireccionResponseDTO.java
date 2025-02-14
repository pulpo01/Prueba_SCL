package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class DireccionResponseDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	
	private DireccionDTO[]  lstlistadoDireciones;
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



	public DireccionDTO[] getLstlistadoDireciones() {
		return lstlistadoDireciones;
	}



	public void setLstlistadoDireciones(DireccionDTO[] lstlistadoDireciones) {
		this.lstlistadoDireciones = lstlistadoDireciones;
	}




	

}