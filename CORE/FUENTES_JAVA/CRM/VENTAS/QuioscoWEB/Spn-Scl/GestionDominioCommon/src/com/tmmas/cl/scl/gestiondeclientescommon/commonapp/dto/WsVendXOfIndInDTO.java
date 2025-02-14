package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsVendXOfIndInDTO  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String indInterno;
	private String codOficina;
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getIndInterno() {
		return indInterno;
	}
	public void setIndInterno(String indInterno) {
		this.indInterno = indInterno;
	}
	

}
