package com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject;

import java.io.Serializable;

public class UtilAgrupCargosDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoConcepto;
	private float monto;
	private String codigoMoneda;
	private float valorDescuento;
	private String codigoConceptoDescuento;
	private long numUnidades;
	private long tipDescuento;
	public long getTipDescuento() {
		return tipDescuento;
	}
	public void setTipDescuento(long tipDescuento) {
		this.tipDescuento = tipDescuento;
	}
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getCodigoConceptoDescuento() {
		return codigoConceptoDescuento;
	}
	public void setCodigoConceptoDescuento(String codigoConceptoDescuento) {
		this.codigoConceptoDescuento = codigoConceptoDescuento;
	}
	public String getCodigoMoneda() {
		return codigoMoneda;
	}
	public void setCodigoMoneda(String codigoMoneda) {
		this.codigoMoneda = codigoMoneda;
	}
	public float getMonto() {
		return monto;
	}
	public void setMonto(float monto) {
		this.monto = monto;
	}
	public float getValorDescuento() {
		return valorDescuento;
	}
	public void setValorDescuento(float valorDescuento) {
		this.valorDescuento = valorDescuento;
	}
	public long getNumUnidades() {
		return numUnidades;
	}
	public void setNumUnidades(long numUnidades) {
		this.numUnidades = numUnidades;
	}
	
	
	
}
