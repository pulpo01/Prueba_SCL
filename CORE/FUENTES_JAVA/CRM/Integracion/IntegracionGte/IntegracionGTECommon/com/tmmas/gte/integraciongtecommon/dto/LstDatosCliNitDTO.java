package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class LstDatosCliNitDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private DatosCliNitDTO[]  listadoClientes;
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public DatosCliNitDTO[] getListadoClientes() {
		return listadoClientes;
	}
	public void setListadoClientes(DatosCliNitDTO[] listadoClientes) {
		this.listadoClientes = listadoClientes;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
		
	
	
}
