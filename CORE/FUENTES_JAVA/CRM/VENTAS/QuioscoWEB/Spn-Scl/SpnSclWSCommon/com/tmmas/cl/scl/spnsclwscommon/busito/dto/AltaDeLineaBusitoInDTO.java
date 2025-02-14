package com.tmmas.cl.scl.spnsclwscommon.busito.dto;

import java.io.Serializable;

public class AltaDeLineaBusitoInDTO  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codigoCliente;
	private String codigoVendedor;
	private String numeroSerieKit;
	private String nomUsuario;
	
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNumeroSerieKit() {
		return numeroSerieKit;
	}
	public void setNumeroSerieKit(String numeroSerieKit) {
		this.numeroSerieKit = numeroSerieKit;
	}
	
	
	
}
