/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 11/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

public class ValidaPlanFreedomDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String paramProporVta;
	private long numVenta;
	private int paramPropor1;
	private int paramPropor2;
	
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
	public int getParamPropor1() {
		return paramPropor1;
	}
	public void setParamPropor1(int paramPropor1) {
		this.paramPropor1 = paramPropor1;
	}
	public int getParamPropor2() {
		return paramPropor2;
	}
	public void setParamPropor2(int paramPropor2) {
		this.paramPropor2 = paramPropor2;
	}
	public String getParamProporVta() {
		return paramProporVta;
	}
	public void setParamProporVta(String paramProporVta) {
		this.paramProporVta = paramProporVta;
	}	
	  
}
