package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable;

public class FacturaInDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String folio;

	public String getFolio() {
		return folio;
	}

	public void setFolio(String folio) {
		this.folio = folio;
	}


}
