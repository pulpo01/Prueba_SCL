package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class LstCliResponseDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private ClienteAuxDTO[]  listadoClientes;
	private RespuestaDTO respuesta;
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public ClienteAuxDTO[] getListadoClientes() {
		return listadoClientes;
	}
	public void setListadoClientes(ClienteAuxDTO[] listadoClientes) {
		this.listadoClientes = listadoClientes;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
	
		
	
}
