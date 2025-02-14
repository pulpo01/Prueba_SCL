package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class LstClienteResponseDTO implements Serializable{
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	private ClienteDTO[] lstDatCliente;
	private RespuestaDTO respuesta;
	
	public ClienteDTO[] getLstDatCliente() {
		return lstDatCliente;
	}
	public void setLstDatCliente(ClienteDTO[] lstDatCliente) {
		this.lstDatCliente = lstDatCliente;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
}
