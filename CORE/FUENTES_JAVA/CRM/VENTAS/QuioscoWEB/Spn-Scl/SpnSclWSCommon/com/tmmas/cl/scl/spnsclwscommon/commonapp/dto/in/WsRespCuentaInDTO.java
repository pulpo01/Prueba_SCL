package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

public class WsRespCuentaInDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private WsDireccionInDTO direccion;
	private  String CodigoTipident;
	private  String NumeroIdent;		
	private String FechaNacimiento;
	private String Responsable;
	
	
	public String getCodigoTipident() {
		return CodigoTipident;
	}
	public void setCodigoTipident(String codigoTipident) {
		CodigoTipident = codigoTipident;
	}
	public WsDireccionInDTO getDireccion() {
		return direccion;
	}
	public void setDireccion(WsDireccionInDTO direccion) {
		this.direccion = direccion;
	}
	public String getFechaNacimiento() {
		return FechaNacimiento;
	}
	public void setFechaNacimiento(String fechaNacimiento) {
		FechaNacimiento = fechaNacimiento;
	}
	public String getNumeroIdent() {
		return NumeroIdent;
	}
	public void setNumeroIdent(String numeroIdent) {
		NumeroIdent = numeroIdent;
	}
	public String getResponsable() {
		return Responsable;
	}
	public void setResponsable(String responsable) {
		Responsable = responsable;
	}
	
	

}
