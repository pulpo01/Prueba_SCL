package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto;

import java.io.Serializable;

public class WsConsSSuplementariosOutDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoSS;
	private String descripciónSS;
	private String grupoSS;
	private String nivelSS;
	private String tarifaconexion;
	private String monedaTarifdaConexion;
	private String tarifaMensual;
	private String monedaTarifaMensual;
	
	
	
	
	public String getCodigoSS() {
		return codigoSS;
	}
	public void setCodigoSS(String codigoSS) {
		this.codigoSS = codigoSS;
	}
	public String getDescripciónSS() {
		return descripciónSS;
	}
	public void setDescripciónSS(String descripciónSS) {
		this.descripciónSS = descripciónSS;
	}
	public String getGrupoSS() {
		return grupoSS;
	}
	public void setGrupoSS(String grupoSS) {
		this.grupoSS = grupoSS;
	}
	public String getMonedaTarifaMensual() {
		return monedaTarifaMensual;
	}
	public void setMonedaTarifaMensual(String monedaTarifaMensual) {
		this.monedaTarifaMensual = monedaTarifaMensual;
	}
	public String getMonedaTarifdaConexion() {
		return monedaTarifdaConexion;
	}
	public void setMonedaTarifdaConexion(String monedaTarifdaConexion) {
		this.monedaTarifdaConexion = monedaTarifdaConexion;
	}
	public String getNivelSS() {
		return nivelSS;
	}
	public void setNivelSS(String nivelSS) {
		this.nivelSS = nivelSS;
	}
	public String getTarifaconexion() {
		return tarifaconexion;
	}
	public void setTarifaconexion(String tarifaconexion) {
		this.tarifaconexion = tarifaconexion;
	}
	public String getTarifaMensual() {
		return tarifaMensual;
	}
	public void setTarifaMensual(String tarifaMensual) {
		this.tarifaMensual = tarifaMensual;
	}



}
