package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class OficinaVendedorDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codOficina;
	private String desOficina;
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getDesOficina() {
		return desOficina;
	}
	public void setDesOficina(String desOficina) {
		this.desOficina = desOficina;
	}

}
