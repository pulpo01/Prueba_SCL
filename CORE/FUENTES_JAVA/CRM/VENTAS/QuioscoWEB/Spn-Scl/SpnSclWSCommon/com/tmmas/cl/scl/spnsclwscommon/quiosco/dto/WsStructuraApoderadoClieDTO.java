package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

public class WsStructuraApoderadoClieDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private  String CodigoTipident;
	private  String NumeroIdent;
	private  String NomApoderado;
	
	
	public String getCodigoTipident() {
		return CodigoTipident;
	}
	public void setCodigoTipident(String codigoTipident) {
		CodigoTipident = codigoTipident;
	}
	public String getNomApoderado() {
		return NomApoderado;
	}
	public void setNomApoderado(String nomApoderado) {
		NomApoderado = nomApoderado;
	}
	public String getNumeroIdent() {
		return NumeroIdent;
	}
	public void setNumeroIdent(String numeroIdent) {
		NumeroIdent = numeroIdent;
	}

	

}
