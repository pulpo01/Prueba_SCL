package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;


public class MenuUsuarioSCLDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String formulario;
	private String grupo;

	public String getGrupo() {
		return grupo;
	}

	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}

	public String getFormulario() {
		return formulario;
	}

	public void setFormulario(String formulario) {
		this.formulario = formulario;
	}
	
	
}
