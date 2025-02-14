package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;


public class SimcardSNPNDTO extends SimcardDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String carga;	
	private String codHLR;
	
	public String getCodHLR() {
		return codHLR;
	}
	public void setCodHLR(String codHLR) {
		this.codHLR = codHLR;
	}
	public String getCarga() {
		return carga;
	}
	public void setCarga(String carga) {
		this.carga = carga;
	}
	

}
