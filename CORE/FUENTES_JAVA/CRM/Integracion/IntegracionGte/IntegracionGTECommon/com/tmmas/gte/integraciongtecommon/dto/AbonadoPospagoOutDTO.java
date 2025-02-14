package com.tmmas.gte.integraciongtecommon.dto;

public class AbonadoPospagoOutDTO {
	
	private AbonadoPospagoDTO[] listadoClientes;
	private RespuestaDTO respuesta;

	public AbonadoPospagoDTO[] getListadoClientes() {
		return listadoClientes;
	}
	public void setListadoClientes(AbonadoPospagoDTO[] listadoClientes) {
		this.listadoClientes = listadoClientes;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
}
