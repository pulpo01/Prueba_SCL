package com.tmmas.cl.scl.commonbusinessentities.dto;

import java.io.Serializable;

public class DetalleCargosSolicitudDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String desConcepto;

	private double cargos;

	private double impuestos;

	private double descuentos;

	private double total;

	// Datos override
	private String tipoServicio; // PA (Plan adicional)- CB (Cargo Basico) - SS (Servicio Suplemetario)

	private String codOrigenTransaccion; // VT (Venta) - PV (Posventa)

	private long codCliente;

	private long numAbonado;

	private long numVenta;

	private String nomUsuarora;

	private String codPlantarif;

	private long codProductoContratado;

	private long codCargoContratado;

	private String codCargoBasico;

	private String codServicio;

	private double importeOrigen;

	private Double importeOverride;

	private String codMoneda;

	private long codConcepto;

	private int correlativoCargo;

	private String desMoneda;

	public String getDesMoneda() {
		return desMoneda;
	}

	public void setDesMoneda(String desMoneda) {
		this.desMoneda = desMoneda;
	}

	public double getCargos() {
		return cargos;
	}

	public void setCargos(double cargos) {
		this.cargos = cargos;
	}

	public double getDescuentos() {
		return descuentos;
	}

	public void setDescuentos(double descuentos) {
		this.descuentos = descuentos;
	}

	public double getImpuestos() {
		return impuestos;
	}

	public void setImpuestos(double impuestos) {
		this.impuestos = impuestos;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public String getDesConcepto() {
		return desConcepto;
	}

	public void setDesConcepto(String desConcepto) {
		this.desConcepto = desConcepto;
	}

	public String getTipoServicio() {
		return tipoServicio;
	}

	public void setTipoServicio(String tipoServicio) {
		this.tipoServicio = tipoServicio;
	}

	public String getCodOrigenTransaccion() {
		return codOrigenTransaccion;
	}

	public void setCodOrigenTransaccion(String codOrigenTransaccion) {
		this.codOrigenTransaccion = codOrigenTransaccion;
	}

	public long getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	public String getCodPlantarif() {
		return codPlantarif;
	}

	public void setCodPlantarif(String codPlantarif) {
		this.codPlantarif = codPlantarif;
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

	public long getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}

	public long getCodConcepto() {
		return codConcepto;
	}

	public void setCodConcepto(long codConcepto) {
		this.codConcepto = codConcepto;
	}

	public long getCodProductoContratado() {
		return codProductoContratado;
	}

	public void setCodProductoContratado(long codProductoContratado) {
		this.codProductoContratado = codProductoContratado;
	}

	public double getImporteOrigen() {
		return importeOrigen;
	}

	public void setImporteOrigen(double importeOrigen) {
		this.importeOrigen = importeOrigen;
	}

	public long getCodCargoContratado() {
		return codCargoContratado;
	}

	public void setCodCargoContratado(long codCargoContratado) {
		this.codCargoContratado = codCargoContratado;
	}

	public String getCodCargoBasico() {
		return codCargoBasico;
	}

	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}

	public String getCodMoneda() {
		return codMoneda;
	}

	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}

	public String getCodServicio() {
		return codServicio;
	}

	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}

	public Double getImporteOverride() {
		return importeOverride;
	}

	public void setImporteOverride(Double importeOverride) {
		this.importeOverride = importeOverride;
	}

	public int getCorrelativoCargo() {
		return correlativoCargo;
	}

	public void setCorrelativoCargo(int correlativoCargo) {
		this.correlativoCargo = correlativoCargo;
	}

	/**
	 * Constructs a <code>String</code> with all attributes in name = value format.
	 * 
	 * @return a <code>String</code> representation of this object.
	 */
	public String toString() {
		final String newLine = "\n";

		StringBuffer b = new StringBuffer();

		b.append("DetalleCargosSolicitudDTO ( ").append(super.toString()).append(newLine);
		b.append("cargos = ").append(this.cargos).append(newLine);
		b.append("codCargoBasico = ").append(this.codCargoBasico).append(newLine);
		b.append("codCargoContratado = ").append(this.codCargoContratado).append(newLine);
		b.append("codCliente = ").append(this.codCliente).append(newLine);
		b.append("codConcepto = ").append(this.codConcepto).append(newLine);
		b.append("codMoneda = ").append(this.codMoneda).append(newLine);
		b.append("codOrigenTransaccion = ").append(this.codOrigenTransaccion).append(newLine);
		b.append("codPlantarif = ").append(this.codPlantarif).append(newLine);
		b.append("codProductoContratado = ").append(this.codProductoContratado).append(newLine);
		b.append("codServicio = ").append(this.codServicio).append(newLine);
		b.append("correlativoCargo = ").append(this.correlativoCargo).append(newLine);
		b.append("desConcepto = ").append(this.desConcepto).append(newLine);
		b.append("desMoneda = ").append(this.desMoneda).append(newLine);
		b.append("descuentos = ").append(this.descuentos).append(newLine);
		b.append("importeOrigen = ").append(this.importeOrigen).append(newLine);
		b.append("importeOverride = ").append(this.importeOverride).append(newLine);
		b.append("impuestos = ").append(this.impuestos).append(newLine).append("nomUsuarora = ").append(
				this.nomUsuarora).append(newLine);
		b.append("numAbonado = ").append(this.numAbonado).append(newLine);
		b.append("numVenta = ").append(this.numVenta).append(newLine);
		b.append("tipoServicio = ").append(this.tipoServicio).append(newLine).append("total = ").append(this.total)
				.append(newLine);
		b.append(" )");

		return b.toString();
	}

}
