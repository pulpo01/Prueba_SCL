package com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto;

import java.io.Serializable;

public class MonedaDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String monedaConc;
	private String monedaLoc;
	private double impConc;
	private double facConversion;
	private double impConcConv;
	private String fecConversion;
	
	
	public double getFacConversion() {
		return facConversion;
	}
	public void setFacConversion(double facConversion) {
		this.facConversion = facConversion;
	}
	public double getImpConc() {
		return impConc;
	}
	public void setImpConc(double impConc) {
		this.impConc = impConc;
	}
	public String getMonedaConc() {
		return monedaConc;
	}
	public void setMonedaConc(String monedaConc) {
		this.monedaConc = monedaConc;
	}
	public String getMonedaLoc() {
		return monedaLoc;
	}
	public void setMonedaLoc(String monedaLoc) {
		this.monedaLoc = monedaLoc;
	}
	public double getImpConcConv() {
		return impConcConv;
	}
	public void setImpConcConv(double impConcConv) {
		this.impConcConv = impConcConv;
	}
	public String getFecConversion() {
		return fecConversion;
	}
	public void setFecConversion(String fecConversion) {
		this.fecConversion = fecConversion;
	}
	
	
	
}
