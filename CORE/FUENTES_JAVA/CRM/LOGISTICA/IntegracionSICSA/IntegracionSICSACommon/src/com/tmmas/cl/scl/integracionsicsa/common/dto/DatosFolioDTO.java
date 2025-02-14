package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class DatosFolioDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private long consume;
	private String numFolio;
	
	public long getConsume() {
		return consume;
	}
	public void setConsume(long consume) {
		this.consume = consume;
	}
	public String getNumFolio() {
		return numFolio;
	}
	public void setNumFolio(String numFolio) {
		this.numFolio = numFolio;
	}
}
