package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class GrupoPrestacionDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;

    private String grpPrestacion;

	public String getGrpPrestacion() {
		return grpPrestacion;
	}

	public void setGrpPrestacion(String grpPrestacion) {
		this.grpPrestacion = grpPrestacion;
	}


}