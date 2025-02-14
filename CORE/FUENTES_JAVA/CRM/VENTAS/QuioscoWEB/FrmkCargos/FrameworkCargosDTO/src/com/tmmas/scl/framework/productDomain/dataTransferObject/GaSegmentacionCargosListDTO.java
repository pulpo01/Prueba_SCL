package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class GaSegmentacionCargosListDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private GaSegmentacionCargosDTO[] gaSegmentacionCargosDTO;

	public GaSegmentacionCargosDTO[] getGaSegmentacionCargosDTO() {
		return gaSegmentacionCargosDTO;
	}

	public void setGaSegmentacionCargosDTO(GaSegmentacionCargosDTO[] gaSegmentacionCargosDTO) {
		this.gaSegmentacionCargosDTO = gaSegmentacionCargosDTO;
	}

}
