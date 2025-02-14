package com.tmmas.cl.scl.socketps.common.dto;

import java.io.Serializable;

public class ConsultaPlanDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String lin = "";
	private String icc = "";
	private HeaderPSDTO header = new HeaderPSDTO();
	
	public HeaderPSDTO getHeader() {
		return header;
	}
	public void setHeader(HeaderPSDTO header) {
		this.header = header;
	}
	public String getIcc() {
		return icc;
	}
	public void setIcc(String icc) {
		this.icc = icc;
	}
	public String getLin() {
		return lin;
	}
	public void setLin(String lin) {
		this.lin = lin;
	}
	
}
