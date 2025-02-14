package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsCunetaAltaDeLineaJMSDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private WsCunetaAltaDeLineaDTO CunetaAltaDeLinea;
	private int rollback;
	
	
	public WsCunetaAltaDeLineaDTO getCunetaAltaDeLinea() {
		return CunetaAltaDeLinea;
	}
	public void setCunetaAltaDeLinea(WsCunetaAltaDeLineaDTO cunetaAltaDeLinea) {
		CunetaAltaDeLinea = cunetaAltaDeLinea;
	}
	public int getRollback() {
		return rollback;
	}
	public void setRollback(int rollback) {
		this.rollback = rollback;
	}


}
