package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;


public class ComponentesResponseDTO implements Serializable{
	/*
	 * Autor : Daniel Jara Oyarzún
	 * */
	private static final long serialVersionUID = 1L;
	private  ComponentesDTO[] ssActivos;      																								 
	private	 ComponentesDTO[] ssInactivos;     
	private	 RespuestaDTO     respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public ComponentesDTO[] getSsActivos() {
		return ssActivos;
	}
	public void setSsActivos(ComponentesDTO[] ssActivos) {
		this.ssActivos = ssActivos;
	}
	public ComponentesDTO[] getSsInactivos() {
		return ssInactivos;
	}
	public void setSsInactivos(ComponentesDTO[] ssInactivos) {
		this.ssInactivos = ssInactivos;
	}    
	
	
	
}
