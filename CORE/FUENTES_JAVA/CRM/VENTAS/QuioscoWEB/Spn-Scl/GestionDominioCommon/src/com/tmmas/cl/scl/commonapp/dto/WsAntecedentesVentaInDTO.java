package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsAntecedentesVentaInDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	


	private String codigoVendedor;
	private String codigoDealer;
	private String codigoTipoContrato;
	private String codigoModalidadVenta;
	private String Cuotas;
	private String CodigoReserva;
	
	
	public String getCodigoReserva() {
		return CodigoReserva;
	}
	public void setCodigoReserva(String codigoReserva) {
		CodigoReserva = codigoReserva;
	}
	public String getCuotas() {
		return Cuotas;
	}
	public void setCuotas(String cuotas) {
		Cuotas = cuotas;
	}
	public String getCodigoDealer() {
		return codigoDealer;
	}
	public void setCodigoDealer(String codigoDealer) {
		this.codigoDealer = codigoDealer;
	}
	public String getCodigoModalidadVenta() {
		return codigoModalidadVenta;
	}
	public void setCodigoModalidadVenta(String codigoModalidadVenta) {
		this.codigoModalidadVenta = codigoModalidadVenta;
	}
	public String getCodigoTipoContrato() {
		return codigoTipoContrato;
	}
	public void setCodigoTipoContrato(String codigoTipoContrato) {
		this.codigoTipoContrato = codigoTipoContrato;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	
	


}
