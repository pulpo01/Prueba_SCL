package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class ValorClasificacionDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codClasificacion;
	private String desClasificacion;
	private int indDefecto;
	public String getCodClasificacion() {
		return codClasificacion;
	}
	public void setCodClasificacion(String codClasificacion) {
		this.codClasificacion = codClasificacion;
	}
	public String getDesClasificacion() {
		return desClasificacion;
	}
	public void setDesClasificacion(String desClasificacion) {
		this.desClasificacion = desClasificacion;
	}
	public int getIndDefecto() {
		return indDefecto;
	}
	public void setIndDefecto(int indDefecto) {
		this.indDefecto = indDefecto;
	}
	
	
}
