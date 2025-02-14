package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsApoderadoInDTO implements Serializable{

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
	public String getNumeroIdent() {
		return NumeroIdent;
	}
	public void setNumeroIdent(String numeroIdent) {
		NumeroIdent = numeroIdent;
	}
	public String getNomApoderado() {
		return NomApoderado;
	}
	public void setNomApoderado(String nomApoderado) {
		NomApoderado = nomApoderado;
	}
	
}
