package com.tmmas.cl.scl.crmcommon.commonapp.dto;

public class ResultadoValidacionTasacionDTO extends ResultadoValidacionDTO{
	private static final long serialVersionUID = 1L;
	private double totalImporteCargoBasico;
	private double importeCargoBasico;
	public double getTotalImporteCargoBasico() {
		return totalImporteCargoBasico;
	}
	public void setTotalImporteCargoBasico(double totalImporteCargoBasico) {
		this.totalImporteCargoBasico = totalImporteCargoBasico;
	}
	public double getImporteCargoBasico() {
		return importeCargoBasico;
	}
	public void setImporteCargoBasico(double importeCargoBasico) {
		this.importeCargoBasico = importeCargoBasico;
	}

}
