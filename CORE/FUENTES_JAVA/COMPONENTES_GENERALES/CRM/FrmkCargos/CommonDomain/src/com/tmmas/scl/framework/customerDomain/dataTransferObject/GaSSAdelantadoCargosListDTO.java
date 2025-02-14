package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class GaSSAdelantadoCargosListDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private GaSSAdelantadoCargosDTO[] gaSSAdelantadoCargosDTO;

	public GaSSAdelantadoCargosDTO[] getGaSSAdelantadoCargosDTO() {
		return gaSSAdelantadoCargosDTO;
	}

	public void setGaSSAdelantadoCargosDTO(GaSSAdelantadoCargosDTO[] gaSSAdelantadoCargosDTO) {
		this.gaSSAdelantadoCargosDTO = gaSSAdelantadoCargosDTO;
	}

}
