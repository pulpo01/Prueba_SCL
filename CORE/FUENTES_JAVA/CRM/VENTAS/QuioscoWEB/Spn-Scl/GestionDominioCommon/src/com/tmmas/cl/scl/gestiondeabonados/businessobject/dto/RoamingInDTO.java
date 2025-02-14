package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class RoamingInDTO extends RoamingDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long dias;

	public long getDias() {
		return dias;
	}

	public void setDias(long dias) {
		this.dias = dias;
	}

}
