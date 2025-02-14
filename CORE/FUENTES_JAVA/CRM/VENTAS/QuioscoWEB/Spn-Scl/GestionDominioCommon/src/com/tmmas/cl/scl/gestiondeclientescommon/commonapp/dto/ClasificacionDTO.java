package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class ClasificacionDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codElemento;
	private String desElemento;
	private int indActivo;
	private int indVisible;
	
	public String getCodElemento() {
		return codElemento;
	}
	public void setCodElemento(String codElemento) {
		this.codElemento = codElemento;
	}
	public String getDesElemento() {
		return desElemento;
	}
	public void setDesElemento(String desElemento) {
		this.desElemento = desElemento;
	}
	public int getIndActivo() {
		return indActivo;
	}
	public void setIndActivo(int indActivo) {
		this.indActivo = indActivo;
	}
	public int getIndVisible() {
		return indVisible;
	}
	public void setIndVisible(int indVisible) {
		this.indVisible = indVisible;
	}
	
	
}
