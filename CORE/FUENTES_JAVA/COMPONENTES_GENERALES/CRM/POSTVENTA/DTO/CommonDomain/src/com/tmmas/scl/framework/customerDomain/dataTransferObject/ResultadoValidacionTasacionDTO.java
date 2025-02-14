package com.tmmas.scl.framework.customerDomain.dataTransferObject;

public class ResultadoValidacionTasacionDTO extends ResultadoValidacionDTO{
	private static final long serialVersionUID = 1L;
	private double totalImporteCargoBasico;
	public double getTotalImporteCargoBasico() {
		return totalImporteCargoBasico;
	}
	public void setTotalImporteCargoBasico(double totalImporteCargoBasico) {
		this.totalImporteCargoBasico = totalImporteCargoBasico;
	}

}
