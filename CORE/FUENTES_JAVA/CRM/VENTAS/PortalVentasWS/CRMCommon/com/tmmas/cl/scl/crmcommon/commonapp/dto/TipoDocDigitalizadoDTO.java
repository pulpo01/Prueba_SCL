package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class TipoDocDigitalizadoDTO implements Serializable {

	private static final long serialVersionUID = 6397443473378369457L;

	private String codTipoDocDigitalizado;

	private String desTipoDocDigitalizado;

	public String getCodTipoDocDigitalizado() {
		return codTipoDocDigitalizado;
	}

	public void setCodTipoDocDigitalizado(String codTipoDocumento) {
		this.codTipoDocDigitalizado = codTipoDocumento;
	}

	public String getDesTipoDocDigitalizado() {
		return desTipoDocDigitalizado;
	}

	public void setDesTipoDocDigitalizado(String desTipoDocumento) {
		this.desTipoDocDigitalizado = desTipoDocumento;
	}

}
