package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ImpuestosDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private float totalCargos;
	private float totalDescuentos;
	private float totalImpuestos;
	private String numeroProceso;
	private int codigoConcepto;
		
	private long numProceso;
	
	public long getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(long numProceso) {
		this.numProceso = numProceso;
	}
	public int getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(int codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getNumeroProceso() {
		return numeroProceso;
	}
	public void setNumeroProceso(String numeroProceso) {
		this.numeroProceso = numeroProceso;
	}
	public float getTotalCargos() {
		return totalCargos;
	}
	public void setTotalCargos(float totalCargos) {
		this.totalCargos = totalCargos;
	}
	public float getTotalDescuentos() {
		return totalDescuentos;
	}
	public void setTotalDescuentos(float totalDescuentos) {
		this.totalDescuentos = totalDescuentos;
	}
	public float getTotalImpuestos() {
		return totalImpuestos;
	}
	public void setTotalImpuestos(float totalImpuestos) {
		this.totalImpuestos = totalImpuestos;
	}
	
	
	
}
