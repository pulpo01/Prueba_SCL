package com.tmmas.scl.framework.customerDomain.dataTransferObject;


import java.io.Serializable;

public class ResultadoValidacionDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private boolean resultado;
	private String estado;
	private String detalleEstado;
	private String numeroCelular;
	private int resultadoBase;
	
	public String getDetalleEstado() {
		return detalleEstado;
	}
	public void setDetalleEstado(String detalleEstado) {
		this.detalleEstado = detalleEstado;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public boolean isResultado() {
		return resultado;
	}
	public void setResultado(boolean resultado) {
		this.resultado = resultado;
	}
	public int getResultadoBase() {
		return resultadoBase;
	}
	public void setResultadoBase(int resultadoBase) {
		this.resultadoBase = resultadoBase;
	}
	
	
	
	
}
