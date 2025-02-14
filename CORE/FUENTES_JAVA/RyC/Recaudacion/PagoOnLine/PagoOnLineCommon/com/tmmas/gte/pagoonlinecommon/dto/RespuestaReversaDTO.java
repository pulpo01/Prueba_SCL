package com.tmmas.gte.pagoonlinecommon.dto;

public class RespuestaReversaDTO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;	
	private String tipoOperacion;
	private String status;
	private RespuestaDTO respuesta;
	
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTipoOperacion() {
		return tipoOperacion;
	}
	public void setTipoOperacion(String tipoOperacion) {
		this.tipoOperacion = tipoOperacion;
	}
}
