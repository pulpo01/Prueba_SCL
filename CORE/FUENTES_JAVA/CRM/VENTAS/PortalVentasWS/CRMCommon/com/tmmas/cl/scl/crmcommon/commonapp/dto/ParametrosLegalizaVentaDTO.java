package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;
//COL-07011 APCC
public class ParametrosLegalizaVentaDTO  implements Serializable{
	private static final long serialVersionUID = 1L;
	private String numVenta;//NOT NULL,
	private String nomUsuario;//NOT NULL,
	
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}

}
