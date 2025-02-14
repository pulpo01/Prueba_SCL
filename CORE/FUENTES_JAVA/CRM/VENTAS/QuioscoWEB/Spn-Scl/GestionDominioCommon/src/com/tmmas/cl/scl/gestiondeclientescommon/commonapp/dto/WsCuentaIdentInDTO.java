package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsCuentaIdentInDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private String codigoTipoIdentificacion;
	private String numeroidentificacion;
	
	public String getCodigoTipoIdentificacion() {
		return codigoTipoIdentificacion;
	}
	public void setCodigoTipoIdentificacion(String codigoTipoIdentificacion) {
		this.codigoTipoIdentificacion = codigoTipoIdentificacion;
	}
	public String getNumeroidentificacion() {
		return numeroidentificacion;
	}
	public void setNumeroidentificacion(String numeroidentificacion) {
		this.numeroidentificacion = numeroidentificacion;
	} 

}
