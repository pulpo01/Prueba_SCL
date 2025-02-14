package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class MuestraURLDTO extends ResulTransaccionDTO implements Serializable{
	
	private static final long serialVersionUID = 7244286643345651259L;
	
	private String strUrlDomPuer;

	public String getStrUrlDomPuer() {
		return strUrlDomPuer;
	}

	public void setStrUrlDomPuer(String strUrlDomPuer) {
		this.strUrlDomPuer = strUrlDomPuer;
	}
	
}
	