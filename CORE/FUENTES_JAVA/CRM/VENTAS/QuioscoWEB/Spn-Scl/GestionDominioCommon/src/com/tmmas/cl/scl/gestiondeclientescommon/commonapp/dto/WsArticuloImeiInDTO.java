package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsArticuloImeiInDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String numSerie;  //NUM_SERIE     VARCHAR2(25 BYTE)

	public String getNumSerie() {
		return numSerie;
	}

	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
}
