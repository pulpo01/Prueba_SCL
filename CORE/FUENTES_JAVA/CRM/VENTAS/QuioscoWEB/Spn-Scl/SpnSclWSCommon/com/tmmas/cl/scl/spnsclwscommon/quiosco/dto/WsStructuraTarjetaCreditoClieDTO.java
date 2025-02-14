package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

public class WsStructuraTarjetaCreditoClieDTO implements Serializable{
	
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private  String TipoTarjeta;
	private  String NumeroTarjeta;
	private  String FechaDeVencimiento;
	
	public String getFechaDeVencimiento() {
		return FechaDeVencimiento;
	}
	public void setFechaDeVencimiento(String fechaDeVencimiento) {
		FechaDeVencimiento = fechaDeVencimiento;
	}
	public String getNumeroTarjeta() {
		return NumeroTarjeta;
	}
	public void setNumeroTarjeta(String numeroTarjeta) {
		NumeroTarjeta = numeroTarjeta;
	}
	public String getTipoTarjeta() {
		return TipoTarjeta;
	}
	public void setTipoTarjeta(String tipoTarjeta) {
		TipoTarjeta = tipoTarjeta;
	}

}
