package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsArticuloImeiOutDTO extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private int codArticulo;
	private String desArticulo;
	private String codModelo;
	public int getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(int codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getCodModelo() {
		return codModelo;
	}
	public void setCodModelo(String codModelo) {
		this.codModelo = codModelo;
	}
	public String getDesArticulo() {
		return desArticulo;
	}
	public void setDesArticulo(String desArticulo) {
		this.desArticulo = desArticulo;
	}
}
