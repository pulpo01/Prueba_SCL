package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class DatosClienteResponseDTO implements Serializable{
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	private ClienteDTO DatosCliente;
	private RespuestaDTO respuesta;
	
	public ClienteDTO getDatosCliente() {
		return DatosCliente;
	}
	public void setDatosCliente(ClienteDTO lstDatCliente) {
		this.DatosCliente = lstDatCliente;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
}
