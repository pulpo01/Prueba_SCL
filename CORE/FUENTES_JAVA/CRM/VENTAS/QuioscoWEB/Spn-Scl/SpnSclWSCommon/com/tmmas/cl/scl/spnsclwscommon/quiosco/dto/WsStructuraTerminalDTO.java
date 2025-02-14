package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

public class WsStructuraTerminalDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;		
    private String numImei;
    
	public String getNumImei() {
		return numImei;
	}
	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}

}
