//P-CSR-11002 JLGN 05-08-2011
package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class MensajePromocionalDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codMensaje;
	private String desMensaje;
	
	public String getCodMensaje() {
		return codMensaje;
	}
	public void setCodMensaje(String codMensaje) {
		this.codMensaje = codMensaje;
	}
	public String getDesMensaje() {
		return desMensaje;
	}
	public void setDesMensaje(String desMensaje) {
		this.desMensaje = desMensaje;
	}
}
