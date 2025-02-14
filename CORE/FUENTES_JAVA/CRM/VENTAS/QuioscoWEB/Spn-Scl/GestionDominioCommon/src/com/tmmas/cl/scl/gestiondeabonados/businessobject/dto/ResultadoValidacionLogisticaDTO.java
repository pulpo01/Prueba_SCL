package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ResultadoValidacionDTO;

public class ResultadoValidacionLogisticaDTO extends ResultadoValidacionDTO{

	private static final long serialVersionUID = 1L;
	
	private int largoSerie;
    
	public int getLargoSerie() {
		return largoSerie;
	}
	public void setLargoSerie(int largoSerie) {
		this.largoSerie = largoSerie;
	}
}
