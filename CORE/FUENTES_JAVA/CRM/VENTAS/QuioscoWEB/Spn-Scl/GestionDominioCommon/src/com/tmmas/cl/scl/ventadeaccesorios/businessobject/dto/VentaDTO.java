package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class VentaDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String  numVenta;
	private int		indTipVenta;
	private int		codModVenta;
	private double	impVenta;
	
	public int getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(int codModVenta) {
		this.codModVenta = codModVenta;
	}
	public double getImpVenta() {
		return impVenta;
	}
	public void setImpVenta(double impVenta) {
		this.impVenta = impVenta;
	}
	public int getIndTipVenta() {
		return indTipVenta;
	}
	public void setIndTipVenta(int indTipVenta) {
		this.indTipVenta = indTipVenta;
	}
	public String getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}
}
