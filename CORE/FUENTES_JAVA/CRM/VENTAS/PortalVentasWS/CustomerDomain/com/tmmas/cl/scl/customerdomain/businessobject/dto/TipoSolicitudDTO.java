package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class TipoSolicitudDTO implements Serializable {
private static final long serialVersionUID = 1L;
	
	private String codTipoSolicitud;
	private String glsTipoSolicitud;
	
	public String getCodTipoSolicitud() {
		return codTipoSolicitud;
	}
	public void setCodTipoSolicitud(String codTipoSolicitud) {
		this.codTipoSolicitud = codTipoSolicitud;
	}
	public String getGlsTipoSolicitud() {
		return glsTipoSolicitud;
	}
	public void setGlsTipoSolicitud(String glsTipoSolicitud) {
		this.glsTipoSolicitud = glsTipoSolicitud;
	}	
}
