package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;


public class WsListArticulosStockPorVendedorDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codCliente;
	private String tipoCuenta;
	private String  fecAlta;
	private String codSisPago;
	private String numTarjeta;
	private String diasCartera;
	private String valorCartera;
	private PagosUltimosMesesDTO[]  pagosUltimosMesesDTO;
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodSisPago() {
		return codSisPago;
	}
	public void setCodSisPago(String codSisPago) {
		this.codSisPago = codSisPago;
	}
	public String getDiasCartera() {
		return diasCartera;
	}
	public void setDiasCartera(String diasCartera) {
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
	public String getValorCartera() {
		return valorCartera;
	}
	public void setValorCartera(String valorCartera) {
		this.valorCartera = valorCartera;
	}
}
