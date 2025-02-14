package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class AperturaSimMdnDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String numSimcard;
	private long mdn;
	
	public long getMdn() {
		return mdn;
	}
	public void setMdn(long mdn) {
		this.mdn = mdn;
	}
	public String getNumSimcard() {
		return numSimcard;
	}
	public void setNumSimcard(String numSimcard) {
		this.numSimcard = numSimcard;
	}
}
