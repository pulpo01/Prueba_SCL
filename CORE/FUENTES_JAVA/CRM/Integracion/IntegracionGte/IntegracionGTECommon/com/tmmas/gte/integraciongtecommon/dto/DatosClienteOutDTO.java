package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class DatosClienteOutDTO implements Serializable{
	/**
	 * Autor : Juan Daniel Muñoz Queupul.
	 */
	private static final long serialVersionUID = 1L;
	private ClienteOutDTO datosCliente;
	private RespuestaDTO respuesta;
	

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public ClienteOutDTO getDatosCliente() {
		return datosCliente;
	}
	public void setDatosCliente(ClienteOutDTO datosCliente) {
		this.datosCliente = datosCliente;
	}

}

