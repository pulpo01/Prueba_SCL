package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
public class AuditoriaResponseDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long codAuditoria;
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCodAuditoria() {
		return codAuditoria;
	}
	public void setCodAuditoria(long codAuditoria) {
		this.codAuditoria = codAuditoria;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
}
