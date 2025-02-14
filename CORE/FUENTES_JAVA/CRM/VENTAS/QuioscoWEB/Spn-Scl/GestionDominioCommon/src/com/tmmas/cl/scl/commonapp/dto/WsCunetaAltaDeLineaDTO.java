package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsCunetaAltaDeLineaDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoDeCuenta;
	private String CodigoDeCliente;	
	private String nomUsuarioOra;
	private String IdentificadorTransaccion;
	private WsActivacionLineaDTO linea;

	public String getCodigoDeCliente() {
		return CodigoDeCliente;
	}
	public void setCodigoDeCliente(String codigoDeCliente) {
		CodigoDeCliente = codigoDeCliente;
	}
	public String getCodigoDeCuenta() {
		return codigoDeCuenta;
	}
	public void setCodigoDeCuenta(String codigoDeCuenta) {
		this.codigoDeCuenta = codigoDeCuenta;
	}
	public WsActivacionLineaDTO getLinea() {
		return linea;
	}
	public void setLinea(WsActivacionLineaDTO linea) {
		this.linea = linea;
	}
	public String getNomUsuarioOra() {
		return nomUsuarioOra;
	}
	public void setNomUsuarioOra(String nomUsuarioOra) {
		this.nomUsuarioOra = nomUsuarioOra;
	}
	public String getIdentificadorTransaccion() {
		return IdentificadorTransaccion;
	}
	public void setIdentificadorTransaccion(String identificadorTransaccion) {
		IdentificadorTransaccion = identificadorTransaccion;
	}
	


}
