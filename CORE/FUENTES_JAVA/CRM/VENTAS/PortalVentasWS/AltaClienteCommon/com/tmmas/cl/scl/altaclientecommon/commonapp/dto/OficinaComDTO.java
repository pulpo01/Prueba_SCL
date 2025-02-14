package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class OficinaComDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codigoOficina;
	private String descripcionOficina;
	//P-CSR-11002 JLGN 10-10-2011
	private String nombreUsuario;
	/* --Indice del objeto por defecto */ 
    public static int indiceDefectoOficina = -1;
    
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public String getDescripcionOficina() {
		return descripcionOficina;
	}
	public void setDescripcionOficina(String descripcionOficina) {
		this.descripcionOficina = descripcionOficina;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	
}//fin class OficinaDTO