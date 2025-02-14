package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class AbonadoProductoResponseDTO implements Serializable {
	/*
	 * Autor: Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	private String tipProducto;
	private RespuestaDTO respuesta;
	
	public String getTipProducto() {
		return tipProducto;
	}
	public void setTipProducto(String tipProducto) {
		this.tipProducto = tipProducto;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
}
