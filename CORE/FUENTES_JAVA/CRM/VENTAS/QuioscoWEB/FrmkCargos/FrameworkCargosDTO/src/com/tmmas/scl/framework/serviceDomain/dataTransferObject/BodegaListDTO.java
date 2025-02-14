package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;

public class BodegaListDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private BodegaDTO bodegas[];
	public BodegaDTO[] getBodegas() {
		return bodegas;
	}
	public void setBodegas(BodegaDTO[] bodegas) {
		this.bodegas = bodegas;
	}

}
