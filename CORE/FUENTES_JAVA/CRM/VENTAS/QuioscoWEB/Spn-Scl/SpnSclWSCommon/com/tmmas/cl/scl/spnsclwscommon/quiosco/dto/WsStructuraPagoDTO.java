package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

public class WsStructuraPagoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codCajaQuiosco;	
	private String sistemaPago;
	private String codBanco;
	private String numCuentaCorriente;
	private String numTarjetaCredito;
	private Boolean aplicapago;
	private String codTipTarjeta;
    private String numDocumento;
	
	
	public String getCodTipTarjeta() {
		return codTipTarjeta;
	}
	public void setCodTipTarjeta(String codTipTarjeta) {
		this.codTipTarjeta = codTipTarjeta;
	}
	public String getNumDocumento() {
		return numDocumento;
	}
	public void setNumDocumento(String numDocumento) {
		this.numDocumento = numDocumento;
	}
	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}
	public String getCodCajaQuiosco() {
		return codCajaQuiosco;
	}
	public void setCodCajaQuiosco(String codCajaQuiosco) {
		this.codCajaQuiosco = codCajaQuiosco;
	}
	public String getNumCuentaCorriente() {
		return numCuentaCorriente;
	}
	public void setNumCuentaCorriente(String numCuentaCorriente) {
		this.numCuentaCorriente = numCuentaCorriente;
	}
	public String getNumTarjetaCredito() {
		return numTarjetaCredito;
	}
	public void setNumTarjetaCredito(String numTarjetaCredito) {
		this.numTarjetaCredito = numTarjetaCredito;
	}
	public String getSistemaPago() {
		return sistemaPago;
	}
	public void setSistemaPago(String sistemaPago) {
		this.sistemaPago = sistemaPago;
	}
	public Boolean getAplicapago() {
		return aplicapago;
	}
	public void setAplicapago(Boolean aplicapago) {
		this.aplicapago = aplicapago;
	}
	

}
