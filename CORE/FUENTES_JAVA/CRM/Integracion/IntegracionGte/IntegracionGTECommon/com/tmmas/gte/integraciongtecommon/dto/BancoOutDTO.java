package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class BancoOutDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	private static final long serialVersionUID = 1L;
	private String codBanco;   
	private String descripcion;
	
	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	
}