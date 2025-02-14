package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class AbonadoActivoDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long numAbonado;
	private long numCelular;
	private float mtoGarantia;
	private String fecPago;
	private float impCargobasico;
	private String codMoneda;
	private String desMoneda;
	
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getDesMoneda() {
		return desMoneda;
	}
	public void setDesMoneda(String desMoneda) {
		this.desMoneda = desMoneda;
	}
	public String getFecPago() {
		return fecPago;
	}
	public void setFecPago(String fecPago) {
		this.fecPago = fecPago;
	}
	public float getImpCargobasico() {
		return impCargobasico;
	}
	public void setImpCargobasico(float impCargobasico) {
		this.impCargobasico = impCargobasico;
	}
	public float getMtoGarantia() {
		return mtoGarantia;
	}
	public void setMtoGarantia(float mtoGarantia) {
		this.mtoGarantia = mtoGarantia;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}


}
