package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class ConceptosRecaudacionComDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	/*-- Bancos --*/
	private String codigoBanco;
	private String descripcionBanco;
	private int indicadorPAC;

	/*-- Sucursales --*/
	private String codigoSucursalBanco;
	private String descripcionSucursalBanco;

	/*-- Tarjetas --*/
	private String codigoTarjeta;
	private String descripcionTarjeta;
	
	/*-- Modalidad de Pago --*/
	private int codigoModPago;
	private String descripcionModPago;
	private int indicadorManual;
	
	public int getIndicadorManual() {
		return indicadorManual;
	}
	public void setIndicadorManual(int indicadorManual) {
		this.indicadorManual = indicadorManual;
	}
	public String getCodigoSucursalBanco() {
		return codigoSucursalBanco;
	}
	public void setCodigoSucursalBanco(String codigoSucursalBanco) {
		this.codigoSucursalBanco = codigoSucursalBanco;
	}
	public String getDescripcionSucursalBanco() {
		return descripcionSucursalBanco;
	}
	public void setDescripcionSucursalBanco(String descripcionSucursalBanco) {
		this.descripcionSucursalBanco = descripcionSucursalBanco;
	}
	public String getCodigoBanco() {
		return codigoBanco;
	}
	public void setCodigoBanco(String codigoBanco) {
		this.codigoBanco = codigoBanco;
	}
	public String getDescripcionBanco() {
		return descripcionBanco;
	}
	public void setDescripcionBanco(String descripcionBanco) {
		this.descripcionBanco = descripcionBanco;
	}
	public int getIndicadorPAC() {
		return indicadorPAC;
	}
	public void setIndicadorPAC(int indicadorPAC) {
		this.indicadorPAC = indicadorPAC;
	}
	public String getCodigoTarjeta() {
		return codigoTarjeta;
	}
	public void setCodigoTarjeta(String codigoTarjeta) {
		this.codigoTarjeta = codigoTarjeta;
	}
	public String getDescripcionTarjeta() {
		return descripcionTarjeta;
	}
	public void setDescripcionTarjeta(String descripcionTarjeta) {
		this.descripcionTarjeta = descripcionTarjeta;
	}
	public int getCodigoModPago() {
		return codigoModPago;
	}
	public void setCodigoModPago(int codigoModPago) {
		this.codigoModPago = codigoModPago;
	}
	public String getDescripcionModPago() {
		return descripcionModPago;
	}
	public void setDescripcionModPago(String descripcionModPago) {
		this.descripcionModPago = descripcionModPago;
	}

}//fin class ConceptosRecaudacionDTO
