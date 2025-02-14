package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class CodCicloFacturaDTO implements Serializable  {
    /**
	 * Autor : Daniel Jara
	 */
	private static final long serialVersionUID = 1L;

    private long codCicloFactura;

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public long getCodCicloFactura() {
		return codCicloFactura;
	}

	public void setCodCicloFactura(long codCicloFactura) {
		this.codCicloFactura = codCicloFactura;
	}

	   

}