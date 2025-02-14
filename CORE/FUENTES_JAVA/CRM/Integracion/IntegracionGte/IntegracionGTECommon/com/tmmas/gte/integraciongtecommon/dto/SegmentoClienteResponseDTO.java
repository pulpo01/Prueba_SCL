package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;
import java.util.Date;

public class SegmentoClienteResponseDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String codTecnologia; 
	private String codSegmento; 
	private String desSegmento; 
	private String codTipo;
	private String desTipo;
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
	public String getCodSegmento() {
		return codSegmento;
	}
	public void setCodSegmento(String codSegmento) {
		this.codSegmento = codSegmento;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getCodTipo() {
		return codTipo;
	}
	public void setCodTipo(String codTipo) {
		this.codTipo = codTipo;
	}
	public String getDesSegmento() {
		return desSegmento;
	}
	public void setDesSegmento(String desSegmento) {
		this.desSegmento = desSegmento;
	}
	public String getDesTipo() {
		return desTipo;
	}
	public void setDesTipo(String desTipo) {
		this.desTipo = desTipo;
	}
	
	
	
}
