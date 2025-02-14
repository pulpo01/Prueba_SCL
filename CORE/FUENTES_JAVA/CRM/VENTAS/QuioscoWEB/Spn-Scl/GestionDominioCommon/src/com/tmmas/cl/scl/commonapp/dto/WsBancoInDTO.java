/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 15/06/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;


public class WsBancoInDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	
	private String codBanco;
	private String indicadorTipcuenta;	
	private String numeroCtacorr;	
	private WsTarjetaCreditoInDTO tarjeta;
	private WsSucursalBancoInDTO sucursal;
	
	public WsTarjetaCreditoInDTO getTarjeta() {
		return tarjeta;
	}
	public void setTarjeta(WsTarjetaCreditoInDTO tarjeta) {
		this.tarjeta = tarjeta;
	}
	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}

	public WsSucursalBancoInDTO getSucursal() {
		return sucursal;
	}
	public void setSucursal(WsSucursalBancoInDTO sucursal) {
		this.sucursal = sucursal;
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
}
