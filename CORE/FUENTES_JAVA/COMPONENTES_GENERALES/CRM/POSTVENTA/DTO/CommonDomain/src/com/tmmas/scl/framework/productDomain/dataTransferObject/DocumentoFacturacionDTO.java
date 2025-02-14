package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class DocumentoFacturacionDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String indiceCiclo;
	private String codigoCliente;
	private String fechaEmision;
	private float promedioFacturado;
	private int numeroMeses;
	
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getFechaEmision() {
		return fechaEmision;
	}
	public void setFechaEmision(String fechaEmision) {
		this.fechaEmision = fechaEmision;
	}
	public String getIndiceCiclo() {
		return indiceCiclo;
	}
	public void setIndiceCiclo(String indiceCiclo) {
		this.indiceCiclo = indiceCiclo;
	}
	public int getNumeroMeses() {
		return numeroMeses;
	}
	public void setNumeroMeses(int numeroMeses) {
		this.numeroMeses = numeroMeses;
	}
	public float getPromedioFacturado() {
		return promedioFacturado;
	}
	public void setPromedioFacturado(float promedioFacturado) {
		this.promedioFacturado = promedioFacturado;
	}
	
	
	
}
