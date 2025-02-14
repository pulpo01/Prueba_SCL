package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;
import java.util.Date;

public class ConsRenovacionDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private Long indRenovacion;
	private Date fecOs;
	private String codCausa;
	private String desCausa;
	private RespuestaDTO respuesta;
	
	public String getCodCausa() {
		return codCausa;
	}
	public void setCodCausa(String codCausa) {
		this.codCausa = codCausa;
	}
	public String getDesCausa() {
		return desCausa;
	}
	public void setDesCausa(String desCausa) {
		this.desCausa = desCausa;
	}
	public Date getFecOs() {
		return fecOs;
	}
	public void setFecOs(Date fecOs) {
		this.fecOs = fecOs;
	}
	public Long getIndRenovacion() {
		return indRenovacion;
	}
	public void setIndRenovacion(Long indRenovacion) {
		this.indRenovacion = indRenovacion;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
}
