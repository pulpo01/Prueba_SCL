package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class EquipoResponseDTO  implements Serializable {

	private static final long serialVersionUID = 1L;

	private EquipoDTO equipo;
	private RespuestaDTO respuesta;
	
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public EquipoDTO getEquipo() {
		return equipo;
	}
	public void setEquipo(EquipoDTO equipo) {
		this.equipo = equipo;
	}
}
