package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto;

import java.io.Serializable;

public class ResponsableWSDTO implements Serializable{

	
	private static final long serialVersionUID = 1L;
	private  String CodigoTipident;
	private  String NumeroIdent;
	private  String NombreResponsable;
	
	
	public String getCodigoTipident() {
		return CodigoTipident;
	}
	public void setCodigoTipident(String codigoTipident) {
		CodigoTipident = codigoTipident;
	}
	public String getNombreResponsable() {
		return NombreResponsable;
	}
	public void setNombreResponsable(String nombreResponsable) {
		NombreResponsable = nombreResponsable;
	}
	public String getNumeroIdent() {
		return NumeroIdent;
	}
	public void setNumeroIdent(String numeroIdent) {
		NumeroIdent = numeroIdent;
	}
}
