package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsTerminalInDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String min;	
	private String numImei;
	
	public String getNumImei() {
		return numImei;
	}
	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}
	public String getMin() {
		return min;
	}
	public void setMin(String min) {
		this.min = min;
	}
}
