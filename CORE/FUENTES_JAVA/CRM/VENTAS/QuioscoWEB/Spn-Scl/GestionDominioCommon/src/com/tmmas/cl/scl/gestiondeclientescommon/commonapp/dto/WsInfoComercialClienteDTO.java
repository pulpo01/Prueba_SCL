package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;


public class WsInfoComercialClienteDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long codCliente;
	private String tipoCuenta;
	private String  fecAlta;
	private long codSisPago;
	private String numTarjeta;
	private float diasCartera;
	private float valorCartera;
	private PagosUltimosMesesDTO[]  pagosUltimosMesesDTO;
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
	public float getDiasCartera() {
		return diasCartera;
	}
	public void setDiasCartera(float diasCartera) {
		this.diasCartera = diasCartera;
	}
	public String getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(String fecAlta) {
		this.fecAlta = fecAlta;
	}
	public String getNumTarjeta() {
		return numTarjeta;
	}
	public void setNumTarjeta(String numTarjeta) {
		this.numTarjeta = numTarjeta;
	}
	public PagosUltimosMesesDTO[] getPagosUltimosMesesDTO() {
		return pagosUltimosMesesDTO;
	}
	public void setPagosUltimosMesesDTO(PagosUltimosMesesDTO[] pagosUltimosMesesDTO) {
		this.pagosUltimosMesesDTO = pagosUltimosMesesDTO;
	}
	public String getTipoCuenta() {
		return tipoCuenta;
	}
	public void setTipoCuenta(String tipoCuenta) {
		this.tipoCuenta = tipoCuenta;
	}
	public float getValorCartera() {
		return valorCartera;
	}
	public void setValorCartera(float valorCartera) {
		this.valorCartera = valorCartera;
	}
	
}
