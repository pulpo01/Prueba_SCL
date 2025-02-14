package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsNumeroSerieOutDTO  extends RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private long codArticulo ;
	private String desArticulo;
	private long codBodega;
	public long getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(long codBodega) {
		this.codBodega = codBodega;
	}
	public String getDesArticulo() {
		return desArticulo;
	}
	public void setDesArticulo(String desArticulo) {
		this.desArticulo = desArticulo;
	}
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
	

}
