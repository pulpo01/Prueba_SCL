package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsPrecioArticuloInDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private int codArticulo;
	private int codUso;
	private int indIterno;
	
	public int getIndIterno() {
		return indIterno;
	}
	public void setIndIterno(int indIterno) {
		this.indIterno = indIterno;
	}
	public int getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(int codArticulo) {
		this.codArticulo = codArticulo;
	}
	public int getCodUso() {
		return codUso;
	}
	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}
	
	
}
