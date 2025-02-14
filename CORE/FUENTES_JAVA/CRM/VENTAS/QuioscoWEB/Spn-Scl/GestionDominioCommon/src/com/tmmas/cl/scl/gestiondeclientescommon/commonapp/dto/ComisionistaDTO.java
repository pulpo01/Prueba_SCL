package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class ComisionistaDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codTipcomis;
	private String desTipcomis;
	private long indExterno;
	public String getCodTipcomis() {
		return codTipcomis;
	}
	public void setCodTipcomis(String codTipcomis) {
		this.codTipcomis = codTipcomis;
	}
	public String getDesTipcomis() {
		return desTipcomis;
	}
	public void setDesTipcomis(String desTipcomis) {
		this.desTipcomis = desTipcomis;
	}
	public long getIndExterno() {
		return indExterno;
	}
	public void setIndExterno(long indExterno) {
		this.indExterno = indExterno;
	}


}
