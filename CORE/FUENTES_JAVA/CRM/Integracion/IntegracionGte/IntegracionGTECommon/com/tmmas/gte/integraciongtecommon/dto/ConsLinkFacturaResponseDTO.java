package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;


public class ConsLinkFacturaResponseDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String rutaFactura;
	private RespuestaDTO respuesta;

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public String getRutaFactura() {
		return rutaFactura;
	}
	public void setRutaFactura(String rutaFactura) {
		this.rutaFactura = rutaFactura;
	}

}
