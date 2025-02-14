/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA. Av. Del Condor 720, Huechuraba,
 * Santiago de Chile, Chile Todos los derechos reservados. Este software es informaci&oacute;n propietaria y
 * confidencial de TM-mAs SA. Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia con los
 * t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs. Fecha ------------------- Autor
 * ------------------------- Cambios ---------- 16/03/2007 H&eacute;ctor Hermosilla Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;
import java.sql.Date;

public class SeguroDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String codSeguro;

	private String desSeguro;

	private long numAbonado;

	private int numEventos;

	private double importeEquipo;

	private String nomUsuarora;

	private String fechaFinContrato;

	private int periodo;

	private long codConcepto;

	private long codCargo;

	// Datos para el cargo
	private long codCliente;

	private String codPlanServ;

	private Date fechaAlta;

	private Date fechaBaja;

	public Date getFechaAlta() {
		return fechaAlta;
	}

	public void setFechaAlta(Date fechaAlta) {
		this.fechaAlta = fechaAlta;
	}

	public Date getFechaBaja() {
		return fechaBaja;
	}

	public void setFechaBaja(Date fechaBaja) {
		this.fechaBaja = fechaBaja;
	}

	public String getCodPlanServ() {
		return codPlanServ;
	}

	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}

	public long getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	public String getFechaFinContrato() {
		return fechaFinContrato;
	}

	public void setFechaFinContrato(String fechaFinContrato) {
		this.fechaFinContrato = fechaFinContrato;
	}

	public double getImporteEquipo() {
		return importeEquipo;
	}

	public void setImporteEquipo(double importeEquipo) {
		this.importeEquipo = importeEquipo;
	}

	public String getNomUsuarora() {
		return nomUsuarora;
	}

	public void setNomUsuarora(String nomUsuarora) {
		this.nomUsuarora = nomUsuarora;
	}

	public long getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}

	public int getNumEventos() {
		return numEventos;
	}

	public void setNumEventos(int numEventos) {
		this.numEventos = numEventos;
	}

	public String getCodSeguro() {
		return codSeguro;
	}

	public void setCodSeguro(String codSeguro) {
		this.codSeguro = codSeguro;
	}

	public String getDesSeguro() {
		return desSeguro;
	}

	public void setDesSeguro(String desSeguro) {
		this.desSeguro = desSeguro;
	}

	public int getPeriodo() {
		return periodo;
	}

	public void setPeriodo(int periodo) {
		this.periodo = periodo;
	}

	public long getCodConcepto() {
		return codConcepto;
	}

	public void setCodConcepto(long codConcepto) {
		this.codConcepto = codConcepto;
	}

	public long getCodCargo() {
		return codCargo;
	}

	public void setCodCargo(long codCargo) {
		this.codCargo = codCargo;
	}

	/**
	 * Constructs a <code>String</code> with all attributes in name = value format.
	 * 
	 * @return a <code>String</code> representation of this object.
	 */
	public String toString() {
		final String newLine = "\n";

		StringBuffer b = new StringBuffer();

		b.append("SeguroDTO ( ").append(super.toString()).append(newLine);
		b.append("codCargo = ").append(this.codCargo).append(newLine);
		b.append("codCliente = ").append(this.codCliente).append(newLine);
		b.append("codConcepto = ").append(this.codConcepto).append(newLine);
		b.append("codPlanServ = ").append(this.codPlanServ).append(newLine);
		b.append("codSeguro = ").append(this.codSeguro).append(newLine);
		b.append("desSeguro = ").append(this.desSeguro).append(newLine);
		b.append("fechaAlta = ").append(this.fechaAlta).append(newLine);
		b.append("fechaBaja = ").append(this.fechaBaja).append(newLine);
		b.append("fechaFinContrato = ").append(this.fechaFinContrato).append(newLine);
		b.append("importeEquipo = ").append(this.importeEquipo).append(newLine);
		b.append("nomUsuarora = ").append(this.nomUsuarora).append(newLine);
		b.append("numAbonado = ").append(this.numAbonado).append(newLine);
		b.append("numEventos = ").append(this.numEventos).append(newLine);
		b.append("periodo = ").append(this.periodo).append(newLine);
		b.append(" )");

		return b.toString();
	}

}
