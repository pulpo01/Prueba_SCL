package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class ListaFrecuentesDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private long numMovimiento;
	private String listaActiva;
	//private long[] listaActiva;
	
	public String getListaActiva() {
		return listaActiva;
	}
	public void setListaActiva(String listaActiva) {
		this.listaActiva = listaActiva;
	}
	public long getNumMovimiento() {
		return numMovimiento;
	}
	public void setNumMovimiento(long numMovimiento) {
		this.numMovimiento = numMovimiento;
	}
	

	
	
}
