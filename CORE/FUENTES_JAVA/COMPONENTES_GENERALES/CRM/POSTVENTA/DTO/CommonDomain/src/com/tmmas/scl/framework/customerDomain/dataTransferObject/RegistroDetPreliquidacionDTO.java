package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class RegistroDetPreliquidacionDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private long numeroVenta;
	private int numItem;
	private long numeroAbonado;
	private long numeroCelular;
	private String numeroSerie;
	private double importeCargo;
	private double importeCargoFinal;
	private int codigoArticulo;
	private int tipoDescuento;
	private double valorDescuento;
	
	public int getCodigoArticulo() {
		return codigoArticulo;
	}
	public void setCodigoArticulo(int codigoArticulo) {
		this.codigoArticulo = codigoArticulo;
	}
	public double getImporteCargo() {
		return importeCargo;
	}
	public void setImporteCargo(double importeCargo) {
		this.importeCargo = importeCargo;
	}
	public double getImporteCargoFinal() {
		return importeCargoFinal;
	}
	public void setImporteCargoFinal(double importeCargoFinal) {
		this.importeCargoFinal = importeCargoFinal;
	}
	public long getNumeroAbonado() {
		return numeroAbonado;
	}
	public void setNumeroAbonado(long numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}
	public long getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(long numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}
	public long getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(long numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public int getNumItem() {
		return numItem;
	}
	public void setNumItem(int numItem) {
		this.numItem = numItem;
	}
	public int getTipoDescuento() {
		return tipoDescuento;
	}
	public void setTipoDescuento(int tipoDescuento) {
		this.tipoDescuento = tipoDescuento;
	}
	public double getValorDescuento() {
		return valorDescuento;
	}
	public void setValorDescuento(double valorDescuento) {
		this.valorDescuento = valorDescuento;
	}
	
}
