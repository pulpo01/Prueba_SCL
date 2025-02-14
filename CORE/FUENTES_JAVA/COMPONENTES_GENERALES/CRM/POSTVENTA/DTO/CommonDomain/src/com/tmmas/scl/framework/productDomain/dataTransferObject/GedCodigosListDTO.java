package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class GedCodigosListDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private GedCodigosDTO[] gedCodigosDTO;

	public GedCodigosDTO[] getGedCodigosDTO() {
		return gedCodigosDTO;
	}

	public void setGedCodigosDTO(GedCodigosDTO[] gedCodigosDTO) {
		this.gedCodigosDTO = gedCodigosDTO;
	}

}
