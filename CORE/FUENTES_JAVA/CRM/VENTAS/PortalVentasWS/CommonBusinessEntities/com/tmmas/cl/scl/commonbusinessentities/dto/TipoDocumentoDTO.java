package com.tmmas.cl.scl.commonbusinessentities.dto;

import java.io.Serializable;

public class TipoDocumentoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codTipoDocumento;
	private String glsTipoDocumento;
	private String accionAsocImpresion;
	
	public String getAccionAsocImpresion() {
		return accionAsocImpresion;
	}
	public void setAccionAsocImpresion(String accionAsocImpresion) {
		this.accionAsocImpresion = accionAsocImpresion;
	}
	public String getCodTipoDocumento() {
		return codTipoDocumento;
	}
	public void setCodTipoDocumento(String codTipoDocumento) {
		this.codTipoDocumento = codTipoDocumento;
	}
	public String getGlsTipoDocumento() {
		return glsTipoDocumento;
	}
	public void setGlsTipoDocumento(String glsTipoDocumento) {
		this.glsTipoDocumento = glsTipoDocumento;
	}
}
