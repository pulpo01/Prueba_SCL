package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class AnulacionVentaDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long numCelular;
	private String usuario;
	private String codCausaBaja;
	private String IdentificadorTransaccion;
	
	
	public String getCodCausaBaja() {
		return codCausaBaja;
	}
	public void setCodCausaBaja(String codCausaBaja) {
		this.codCausaBaja = codCausaBaja;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getIdentificadorTransaccion() {
		return IdentificadorTransaccion;
	}
	public void setIdentificadorTransaccion(String identificadorTransaccion) {
		IdentificadorTransaccion = identificadorTransaccion;
	}
	
}
