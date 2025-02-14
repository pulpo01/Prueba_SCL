package com.tmmas.cl.scl.socketps.common.dto;

import java.io.Serializable;

public class ConsultaBolsasDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String lin = "";
	private String codMoneda = "";
	private String cantRegs = "";
	
	private HeaderPSDTO header = new HeaderPSDTO();

	public String getCantRegs() {
		return cantRegs;
	}

	public void setCantRegs(String cantRegs) {
		this.cantRegs = cantRegs;
	}

	public String getCodMoneda() {
		return codMoneda;
	}

	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}

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
	
	
}
