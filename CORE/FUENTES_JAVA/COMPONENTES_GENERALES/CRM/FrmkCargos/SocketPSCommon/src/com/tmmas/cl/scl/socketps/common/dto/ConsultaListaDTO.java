package com.tmmas.cl.scl.socketps.common.dto;

import java.io.Serializable;

public class ConsultaListaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String lin = "";
	private String numItems = "";
	private String codListIni = "";
	private HeaderPSDTO header = new HeaderPSDTO();
	
	public String getCodListIni() {
		return codListIni;
	}
	public void setCodListIni(String codListIni) {
		this.codListIni = codListIni;
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
	public String getNumItems() {
		return numItems;
	}
	public void setNumItems(String numItems) {
		this.numItems = numItems;
	}
	
	
}
