package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConsCicloFactDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;

    private long codCiclo;

	public long getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(long codCiclo) {
		this.codCiclo = codCiclo;
	}
    

}