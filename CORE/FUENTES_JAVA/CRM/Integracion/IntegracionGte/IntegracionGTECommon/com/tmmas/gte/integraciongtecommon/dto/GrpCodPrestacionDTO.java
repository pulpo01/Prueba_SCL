package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class GrpCodPrestacionDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;

    private String grpPrestacion;
    private String codPrestacion;

	public String getCodPrestacion() {
		return codPrestacion;
	}

	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
	}

	public String getGrpPrestacion() {
		return grpPrestacion;
	}

	public void setGrpPrestacion(String grpPrestacion) {
		this.grpPrestacion = grpPrestacion;
	}


}