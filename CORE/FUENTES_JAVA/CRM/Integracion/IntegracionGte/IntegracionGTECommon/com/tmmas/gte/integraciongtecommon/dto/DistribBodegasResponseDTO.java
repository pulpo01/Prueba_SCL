package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class DistribBodegasResponseDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;

    private DistribBodegasDTO[] listBodegas;
    private RespuestaDTO respuesta;
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public DistribBodegasDTO[] getListBodegas() {
		return listBodegas;
	}
	public void setListBodegas(DistribBodegasDTO[] listBodegas) {
		this.listBodegas = listBodegas;
	}

}