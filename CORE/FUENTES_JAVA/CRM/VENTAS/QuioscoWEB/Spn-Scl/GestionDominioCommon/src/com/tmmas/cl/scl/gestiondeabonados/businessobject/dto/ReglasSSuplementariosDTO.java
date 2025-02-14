package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class ReglasSSuplementariosDTO implements Serializable{

	
	
	
	/**
	 * 
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private String codigoServicio;
	private String codigoServicioDef;	
	private String tiporelacion;
	
	public String getCodigoServicio() {
		return codigoServicio;
	}
	public void setCodigoServicio(String codigoServicio) {
		this.codigoServicio = codigoServicio;
	}
	public String getCodigoServicioDef() {
		return codigoServicioDef;
	}
	public void setCodigoServicioDef(String codigoServicioDef) {
		this.codigoServicioDef = codigoServicioDef;
	}
	public String getTiporelacion() {
		return tiporelacion;
	}
	public void setTiporelacion(String tiporelacion) {
		this.tiporelacion = tiporelacion;
	}

	

	

}
