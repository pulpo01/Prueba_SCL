package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto;

import java.io.Serializable;


public class WsArticuloResDesImasDDTO  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String descripcionErro;
	private String codigoError;
    private String SpnID;
	
	public String getSpnID() {
		return SpnID;
	}
	public void setSpnID(String spnID) {
		SpnID = spnID;
	}
	public String getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(String codigoError) {
		this.codigoError = codigoError;
	}
	public String getDescripcionErro() {
		return descripcionErro;
	}
	public void setDescripcionErro(String descripcionErro) {
		this.descripcionErro = descripcionErro;
	}

}
