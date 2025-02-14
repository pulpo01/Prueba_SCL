package com.tmmas.cl.scl.socketps.common.dto;

import java.io.Serializable;

public class ListasDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private ListaDTO[] lista;
	private RespuestaPSDTO respuesta;
	
	public ListaDTO[] getLista() {
		return lista;
	}
	public void setLista(ListaDTO[] lista) {
		this.lista = lista;
	}
	public RespuestaPSDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaPSDTO respuesta) {
		this.respuesta = respuesta;
	}
}
