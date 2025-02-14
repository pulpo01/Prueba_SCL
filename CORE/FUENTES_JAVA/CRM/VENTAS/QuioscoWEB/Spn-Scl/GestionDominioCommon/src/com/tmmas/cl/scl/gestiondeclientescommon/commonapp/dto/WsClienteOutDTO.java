package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsClienteOutDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long numAbonado;
	private long numCelular;
	private long montoGarantia;
	private String fechaPagoGarantia;
	private long   importeCargoBasico;
	private long   codMoneda;
	private String desMoneda;
	public long getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(long codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getDesMoneda() {
		return desMoneda;
	}
	public void setDesMoneda(String desMoneda) {
		this.desMoneda = desMoneda;
	}
	public String getFechaPagoGarantia() {
		return fechaPagoGarantia;
	}
	public void setFechaPagoGarantia(String fechaPagoGarantia) {
		this.fechaPagoGarantia = fechaPagoGarantia;
	}
	public long getImporteCargoBasico() {
		return importeCargoBasico;
	}
	public void setImporteCargoBasico(long importeCargoBasico) {
		this.importeCargoBasico = importeCargoBasico;
	}
	public long getMontoGarantia() {
		return montoGarantia;
	}
	public void setMontoGarantia(long montoGarantia) {
		this.montoGarantia = montoGarantia;
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
