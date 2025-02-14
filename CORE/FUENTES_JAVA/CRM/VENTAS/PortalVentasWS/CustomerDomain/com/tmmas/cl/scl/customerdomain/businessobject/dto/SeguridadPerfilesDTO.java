package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class SeguridadPerfilesDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String nomUsuario;
	private String codPrograma;
	private String nomProceso;
	private String codVersion;
	private boolean grupoImpresion;
	
	public SeguridadPerfilesDTO() {

	}
	
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getCodPrograma() {
		return codPrograma;
	}
	public void setCodPrograma(String codPrograma) {
		this.codPrograma = codPrograma;
	}
	public String getNomProceso() {
		return nomProceso;
	}
	public void setNomProceso(String nomProceso) {
		this.nomProceso = nomProceso;
	}
	public String getCodVersion() {
		return codVersion;
	}
	public void setCodVersion(String codVersion) {
		this.codVersion = codVersion;
	}

	public boolean isGrupoImpresion() {
		return grupoImpresion;
	}

	public void setGrupoImpresion(boolean grupoImpresion) {
		this.grupoImpresion = grupoImpresion;
	}

}
