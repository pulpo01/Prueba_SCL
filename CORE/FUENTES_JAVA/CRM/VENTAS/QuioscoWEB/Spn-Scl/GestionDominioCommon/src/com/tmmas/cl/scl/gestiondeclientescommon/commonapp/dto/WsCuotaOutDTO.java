package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsCuotaOutDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String codCuota;
	private String desCuota;
	public String getCodCuota() {
		return codCuota;
	}
	public void setCodCuota(String codCuota) {
		this.codCuota = codCuota;
	}
	public String getDesCuota() {
		return desCuota;
	}
	public void setDesCuota(String desCuota) {
		this.desCuota = desCuota;
	}
}