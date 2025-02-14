package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class BancoResponseDTO implements Serializable {
	/*
	 * Autor: Leonardo Muñoz R.
	 * */
	private static final long serialVersionUID = 1L;
	private BancoOutDTO[] listadoBancos;
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
	public BancoOutDTO[] getListadoBancos() {
		return listadoBancos;
	}
	public void setListadoBancos(BancoOutDTO[] listadoBancos) {
		this.listadoBancos = listadoBancos;
	}
	
	
}
