package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class GrupoCorreosDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codGrupo;
	private String desGrupo;
	private String fecCreacion;
	
	public String getCodGrupo() {
		return codGrupo;
	}
	public void setCodGrupo(String codGrupo) {
		this.codGrupo = codGrupo;
	}
	public String getDesGrupo() {
		return desGrupo;
	}
	public void setDesGrupo(String desGrupo) {
		this.desGrupo = desGrupo;
	}
	public String getFecCreacion() {
		return fecCreacion;
	}
	public void setFecCreacion(String fecCreacion) {
		this.fecCreacion = fecCreacion;
	}	
	
}
