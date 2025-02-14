package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class CodPrestacionListDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;

    private CodPrestacionDTO[] codPrestacionList;

	public CodPrestacionDTO[] getCodPrestacionList() {
		return codPrestacionList;
	}

	public void setCodPrestacionList(CodPrestacionDTO[] codPrestacionList) {
		this.codPrestacionList = codPrestacionList;
	}


}