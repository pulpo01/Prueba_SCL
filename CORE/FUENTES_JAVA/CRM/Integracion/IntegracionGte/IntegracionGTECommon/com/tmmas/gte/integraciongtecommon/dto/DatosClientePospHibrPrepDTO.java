package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class DatosClientePospHibrPrepDTO implements Serializable{
	/**
	 * Autor : Juan Daniel Muñoz Queupul.
	 */
	private static final long serialVersionUID = 1L;
	private ClientePospagoHibridoDTO datosCliente;
	private ClientePrepagoDTO datosClientePre;
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
	public ClientePospagoHibridoDTO getDatosCliente() {
		return datosCliente;
	}
	public void setDatosCliente(ClientePospagoHibridoDTO datosCliente) {
		this.datosCliente = datosCliente;
	}
	public ClientePrepagoDTO getDatosClientePre() {
		return datosClientePre;
	}
	public void setDatosClientePre(ClientePrepagoDTO datosClientePre) {
		this.datosClientePre = datosClientePre;
	}
	
}

