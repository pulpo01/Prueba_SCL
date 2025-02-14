package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class InWSLstClienXIdentDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codTipIdent;
	private String numIdent;
	
	public String getCodTipIdent() {
		return codTipIdent;
	}
	public void setCodTipIdent(String codTipIdent) {
		this.codTipIdent = codTipIdent;
	}
	public String getNumIdent() {
		return numIdent;
	}
	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}
}
