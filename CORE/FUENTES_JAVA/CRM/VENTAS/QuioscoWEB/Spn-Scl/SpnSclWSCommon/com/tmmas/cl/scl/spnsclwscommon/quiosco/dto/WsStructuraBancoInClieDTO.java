package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

public class WsStructuraBancoInClieDTO implements Serializable{
	
	
	WsStructuraSucursalBancoClieDTO  sucursalBanco;
	WsStructuraTarjetaCreditoClieDTO tarjetaCreditoClie;
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codBanco;
	private String indicadorTipcuenta;	
	private String numeroCtacorr;
	
	
	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}
	public String getIndicadorTipcuenta() {
		return indicadorTipcuenta;
	}
	public void setIndicadorTipcuenta(String indicadorTipcuenta) {
		this.indicadorTipcuenta = indicadorTipcuenta;
	}
	public String getNumeroCtacorr() {
		return numeroCtacorr;
	}
	public void setNumeroCtacorr(String numeroCtacorr) {
		this.numeroCtacorr = numeroCtacorr;
	}
	public WsStructuraSucursalBancoClieDTO getSucursalBanco() {
		return sucursalBanco;
	}
	public void setSucursalBanco(WsStructuraSucursalBancoClieDTO sucursalBanco) {
		this.sucursalBanco = sucursalBanco;
	}
	public WsStructuraTarjetaCreditoClieDTO getTarjetaCreditoClie() {
		return tarjetaCreditoClie;
	}
	public void setTarjetaCreditoClie(
			WsStructuraTarjetaCreditoClieDTO tarjetaCreditoClie) {
		this.tarjetaCreditoClie = tarjetaCreditoClie;
	}		

}
