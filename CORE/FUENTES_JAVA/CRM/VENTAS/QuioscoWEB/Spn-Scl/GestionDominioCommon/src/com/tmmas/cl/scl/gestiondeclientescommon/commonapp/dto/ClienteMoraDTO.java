package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class ClienteMoraDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long codCliente;
	private String numCtaTar;
	private String tipCuenta;
	private String fecAlta;
	private long codSisPago;
	private float deuVencida;
	private float diasMora;
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodSisPago() {
		return codSisPago;
	}
	public void setCodSisPago(long codSisPago) {
		this.codSisPago = codSisPago;
	}
	public float getDeuVencida() {
		return deuVencida;
	}
	public void setDeuVencida(float deuVencida) {
		this.deuVencida = deuVencida;
	}
	public float getDiasMora() {
		return diasMora;
	}
	public void setDiasMora(float diasMora) {
		this.diasMora = diasMora;
	}
	public String getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(String fecAlta) {
		this.fecAlta = fecAlta;
	}
	public String getTipCuenta() {
		return tipCuenta;
	}
	public void setTipCuenta(String tipCuenta) {
		this.tipCuenta = tipCuenta;
	}
	public String getNumCtaTar() {
		return numCtaTar;
	}
	public void setNumCtaTar(String numCtaTar) {
		this.numCtaTar = numCtaTar;
	}

}
