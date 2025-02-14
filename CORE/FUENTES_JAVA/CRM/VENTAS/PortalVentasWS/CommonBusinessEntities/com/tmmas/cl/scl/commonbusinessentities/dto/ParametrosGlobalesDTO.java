package com.tmmas.cl.scl.commonbusinessentities.dto;

import java.io.Serializable;

public class ParametrosGlobalesDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codOperadora;
	private String desOperadora;
	private String codUsuario;
	private String nomUsuario;
	private String versionSistema;
	private String formatoNIT;
	private String codigoIdentificadorNIT;
	private String tipoEjecucion;/*0:inicial 1:incremental*/


	public String getTipoEjecucion() {
		return tipoEjecucion;
	}

	public void setTipoEjecucion(String tipoEjecucion) {
		this.tipoEjecucion = tipoEjecucion;
	}

	public String getCodigoIdentificadorNIT() {
		return codigoIdentificadorNIT;
	}

	public void setCodigoIdentificadorNIT(String codigoIdentificadorNIT) {
		this.codigoIdentificadorNIT = codigoIdentificadorNIT;
	}

	public String getFormatoNIT() {
		return formatoNIT;
	}

	public void setFormatoNIT(String formatoNIT) {
		this.formatoNIT = formatoNIT;
	}

	public String getCodUsuario() {
		return codUsuario;
	}

	public void setCodUsuario(String codUsuario) {
		this.codUsuario = codUsuario;
	}

	public String getNomUsuario() {
		return nomUsuario;
	}

	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}

	public String getVersionSistema() {
		return versionSistema;
	}

	public void setVersionSistema(String versionSistema) {
		this.versionSistema = versionSistema;
	}

	public String getCodOperadora() {
		return codOperadora;
	}

	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}

	public String getDesOperadora() {
		return desOperadora;
	}

	public void setDesOperadora(String desOperadora) {
		this.desOperadora = desOperadora;
	}
}
