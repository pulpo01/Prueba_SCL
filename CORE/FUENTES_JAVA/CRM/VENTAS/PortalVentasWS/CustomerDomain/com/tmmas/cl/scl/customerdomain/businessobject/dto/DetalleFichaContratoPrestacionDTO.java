package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class DetalleFichaContratoPrestacionDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private long numAbonado;

	private String numSerie;

	private String desEquipo;

	private String planTarifario;

	private double importeCargoBasico;

	private double valorReferencia;

	private double precioVenta;

	private String codPlanServ;

	private int codUso;

	private long numCelular;

	public int getCodUso() {
		return codUso;
	}

	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}

	public String getCodPlanServ() {
		return codPlanServ;
	}

	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}

	public String getDesEquipo() {
		return desEquipo;
	}

	public void setDesEquipo(String desEquipo) {
		this.desEquipo = desEquipo;
	}

	public double getImporteCargoBasico() {
		return importeCargoBasico;
	}

	public void setImporteCargoBasico(double importeCargoBasico) {
		this.importeCargoBasico = importeCargoBasico;
	}

	public long getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}

	public String getNumSerie() {
		return numSerie;
	}

	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}

	public String getPlanTarifario() {
		return planTarifario;
	}

	public void setPlanTarifario(String planTarifario) {
		this.planTarifario = planTarifario;
	}

	public double getPrecioVenta() {
		return precioVenta;
	}

	public void setPrecioVenta(double precioVenta) {
		this.precioVenta = precioVenta;
	}

	public double getValorReferencia() {
		return valorReferencia;
	}

	public void setValorReferencia(double valorReferencia) {
		this.valorReferencia = valorReferencia;
	}

	public long getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}

	public String toString() {
		final String nl = "\n";
		StringBuffer b = new StringBuffer();
		b.append("DetalleFichaContratoPrestacionDTO ( ").append(super.toString()).append(nl);
		b.append("codPlanServ = ").append(this.codPlanServ).append(nl);
		b.append("codUso = ").append(this.codUso).append(nl);
		b.append("desEquipo = ").append(this.desEquipo).append(nl);
		b.append("importeCargoBasico = ").append(this.importeCargoBasico).append(nl);
		b.append("numAbonado = ").append(this.numAbonado).append(nl);
		b.append("numCelular = ").append(this.numCelular).append(nl);
		b.append("numSerie = ").append(this.numSerie).append(nl);
		b.append("planTarifario = ").append(this.planTarifario).append(nl);
		b.append("precioVenta = ").append(this.precioVenta).append(nl);
		b.append("valorReferencia = ").append(this.valorReferencia).append(nl);
		b.append(" )");
		return b.toString();
	}

}
