package com.tmmas.gte.integraciongtecommon.dto;

public class AbonadoOutDTO {
	
	private AbonadoDTO[]  listadoAbonados;
	private RespuestaDTO respuesta;
	
	
	public AbonadoDTO[] getListadoAbonados() {
		return listadoAbonados;
	}
	public void setListadoAbonados(AbonadoDTO[] listadoAbonados) {
		this.listadoAbonados = listadoAbonados;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
}
