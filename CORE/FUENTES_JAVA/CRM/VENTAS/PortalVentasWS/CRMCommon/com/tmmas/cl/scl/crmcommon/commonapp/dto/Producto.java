package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;


public class Producto implements Serializable
{

/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
private String  numSerie;

public Producto(String numSerie) {
	super();
	this.numSerie = numSerie;
}

public String getNumSerie() {
	return numSerie;
}

public void setNumSerie(String numSerie) {
	this.numSerie = numSerie;
}

}	
