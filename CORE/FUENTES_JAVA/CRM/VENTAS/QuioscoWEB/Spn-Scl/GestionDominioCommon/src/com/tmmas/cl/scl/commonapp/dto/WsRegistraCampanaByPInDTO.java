package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsRegistraCampanaByPInDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoCampana;      
	private String codigoCliente;      
	private String numeroAbonado;      
	private String indicadorAsignacion;
	
	
	public String getCodigoCampana() {
		return codigoCampana;
	}
	public void setCodigoCampana(String codigoCampana) {
		this.codigoCampana = codigoCampana;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getIndicadorAsignacion() {
		return indicadorAsignacion;
	}
	public void setIndicadorAsignacion(String indicadorAsignacion) {
		this.indicadorAsignacion = indicadorAsignacion;
	}
	public String getNumeroAbonado() {
		return numeroAbonado;
	}
	public void setNumeroAbonado(String numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}
	
	

}
