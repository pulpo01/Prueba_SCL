package com.tmmas.scl.framework.Sistema.dto;

import java.io.Serializable;

public class UsuarioQueryDTO implements Serializable {
	private String nomUsuario;

	private String codPrograma;

	private String numVersion;

	public String getCodPrograma() {
		return codPrograma;
	}

	public void setCodPrograma(String codPrograma) {
		this.codPrograma = codPrograma;
	}

	public String getNomUsuario() {
		return nomUsuario;
	}

	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}

	public String getNumVersion() {
		return numVersion;
	}

	public void setNumVersion(String numVersion) {
		this.numVersion = numVersion;
	}
}
