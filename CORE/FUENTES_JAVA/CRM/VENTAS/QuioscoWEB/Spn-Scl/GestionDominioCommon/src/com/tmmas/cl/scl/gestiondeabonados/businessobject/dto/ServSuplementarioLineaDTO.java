package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class ServSuplementarioLineaDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String codServicio;

	public String getCodServicio() {
		return codServicio;
	}

	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}

}
