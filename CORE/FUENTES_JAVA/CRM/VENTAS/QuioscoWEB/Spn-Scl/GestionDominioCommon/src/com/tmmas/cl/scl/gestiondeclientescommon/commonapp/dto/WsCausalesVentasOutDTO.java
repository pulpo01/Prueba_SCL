package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsCausalesVentasOutDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String codCausalVentas;
	private String desCausalVentas;
	
	
	public String getCodCausalVentas() {
		return codCausalVentas;
	}
	public void setCodCausalVentas(String codCausalVentas) {
		this.codCausalVentas = codCausalVentas;
	}
	public String getDesCausalVentas() {
		return desCausalVentas;
	}
	public void setDesCausalVentas(String desCausalVentas) {
		this.desCausalVentas = desCausalVentas;
	}
	
}
