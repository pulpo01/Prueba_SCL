package com.tmmas.scl.framework.customerDomain.dataTransferObject;

public class ResultadoValidacionLogisticaDTO extends ResultadoValidacionDTO {

	private static final long serialVersionUID = 1L;
	
	private int largoSerie;
    
	public int getLargoSerie() {
		return largoSerie;
	}
	public void setLargoSerie(int largoSerie) {
		this.largoSerie = largoSerie;
	}
}
