package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class SumaPrecioPlanesDTO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codCliente;
	private int meses;
	private int sumaPlanes;
	
	private String codError;
	private String desEvento;
	private String resultadoTransaccion;
	
	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}
	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}

	public String getDesEvento() {
		return desEvento;
	}
	public void setDesEvento(String desEvento) {
		this.desEvento = desEvento;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public int getMeses() {
		return meses;
	}
	public void setMeses(int meses) {
		this.meses = meses;
	}
	public int getSumaPlanes() {
		return sumaPlanes;
	}
	public void setSumaPlanes(int sumaPlanes) {
		this.sumaPlanes = sumaPlanes;
	}

}
