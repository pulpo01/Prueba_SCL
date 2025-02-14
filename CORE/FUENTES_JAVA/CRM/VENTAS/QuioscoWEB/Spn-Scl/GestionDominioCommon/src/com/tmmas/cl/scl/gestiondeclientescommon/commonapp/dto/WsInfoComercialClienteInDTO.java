package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsInfoComercialClienteInDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String numIdent;
	private String tipIdent;
	public String getNumIdent() {
		return numIdent;
	}
	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}
	public String getTipIdent() {
		return tipIdent;
	}
	public void setTipIdent(String tipIdent) {
		this.tipIdent = tipIdent;
	}
	
	public String toString(){
		StringBuffer buffer = new StringBuffer("WsInfoComercialClienteInDTO: ");		
		buffer.append("numIdent = ").append(numIdent);
		buffer.append(", tipIdent = ").append(tipIdent);
		return buffer.toString();
	}
	
}
