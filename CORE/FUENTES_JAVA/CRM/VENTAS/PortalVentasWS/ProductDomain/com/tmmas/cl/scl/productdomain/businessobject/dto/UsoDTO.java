package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class UsoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	
	private String tipoCliente;
	private String tipoRed;	
	
	private long codUso;
	private String desUso;
	private int indRestPlan;
	
	
	public long getCodUso() {
		return codUso;
	}
	public void setCodUso(long codUso) {
		this.codUso = codUso;
	}
	public String getDesUso() {
		return desUso;
	}
	public void setDesUso(String desUso) {
		this.desUso = desUso;
	}
	public String getTipoCliente() {
		return tipoCliente;
	}
	public void setTipoCliente(String tipoCliente) {
		this.tipoCliente = tipoCliente;
	}
	public String getTipoRed() {
		return tipoRed;
	}
	public void setTipoRed(String tipoRed) {
		this.tipoRed = tipoRed;
	}
	public int getIndRestPlan() {
		return indRestPlan;
	}
	public void setIndRestPlan(int indRestPlan) {
		this.indRestPlan = indRestPlan;
	}
	
	
}//fin class PlanComercialDTO
