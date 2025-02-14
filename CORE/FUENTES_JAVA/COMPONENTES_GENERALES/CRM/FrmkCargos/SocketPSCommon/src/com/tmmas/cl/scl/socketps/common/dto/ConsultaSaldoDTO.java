package com.tmmas.cl.scl.socketps.common.dto;

import java.io.Serializable;

public class ConsultaSaldoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String lin = "";
	private String region = "";
	private HeaderPSDTO header = new HeaderPSDTO();
	
	public HeaderPSDTO getHeader() {
		return header;
	}
	public void setHeader(HeaderPSDTO header) {
		this.header = header;
	}
	public String getLin() {
		return lin;
	}
	public void setLin(String lin) {
		this.lin = lin;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}

	
}
