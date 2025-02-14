package com.tmmas.cl.scl.commonbusinessentities.dto;

import java.io.Serializable;

public class DetalleLineaSolicitudDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private long numAbonado;

	private String planTarifario;

	private String desEquipo;

	private int codUso;

	private DetalleCargosSolicitudDTO[] cargosRecurrentes;

	private DetalleCargosSolicitudDTO[] cargos;

	private double montoTotal;
	
	private long numCelular;

	public long getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}

	public DetalleCargosSolicitudDTO[] getCargos() {
		return cargos;
	}

	public void setCargos(DetalleCargosSolicitudDTO[] cargos) {
		this.cargos = cargos;
	}

	public String getDesEquipo() {
		return desEquipo;
	}

	public void setDesEquipo(String desEquipo) {
		this.desEquipo = desEquipo;
	}

	public double getMontoTotal() {
		return montoTotal;
	}

	public void setMontoTotal(double montoTotal) {
		this.montoTotal = montoTotal;
	}

	public long getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}

	public String getPlanTarifario() {
		return planTarifario;
	}

	public void setPlanTarifario(String planTarifario) {
		this.planTarifario = planTarifario;
	}

	public DetalleCargosSolicitudDTO[] getCargosRecurrentes() {
		return cargosRecurrentes;
	}

	public void setCargosRecurrentes(DetalleCargosSolicitudDTO[] cargosRecurrentes) {
		this.cargosRecurrentes = cargosRecurrentes;
	}

	public int getCodUso() {
		return codUso;
	}

	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}

	/**
	 * Constructs a <code>String</code> with all attributes in name = value format.
	 * 
	 * @return a <code>String</code> representation of this object.
	 */
	public String toString() {
		final String newLine = "\n";
		StringBuffer b = new StringBuffer();
		b.append("DetalleLineaSolicitudDTO ( ").append(super.toString()).append(newLine);
		b.append("cargos = ").append(this.cargos).append(newLine);
		b.append("codUso = ").append(this.codUso).append(newLine);
		b.append("desEquipo = ").append(this.desEquipo).append(newLine);
		b.append("montoTotal = ").append(this.montoTotal).append(newLine);
		b.append("numAbonado = ").append(this.numAbonado).append(newLine);
		b.append("planTarifario = ").append(this.planTarifario).append(newLine);
		b.append(" )");
		return b.toString();
	}

}
