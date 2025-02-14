package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsLineaInDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private WsHomeLineaInDTO homeLinea;
	private WsSimcardInDTO simcard;
	private WsTerminalInDTO terminal;
	private WsDatosPlanTerifarioInDTO datosPlanTerifario;	
	private WsUsuarioInDTO usuarioLinea;
	private String codigoOperador; 
	private String codPrestacion; //CSR-11002

	public String getCodPrestacion() {
		return codPrestacion;
	}
	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
	}
	public String getCodigoOperador() {
		return codigoOperador;
	}
	public void setCodigoOperador(String codigoOperador) {
		this.codigoOperador = codigoOperador;
	}
	public WsHomeLineaInDTO getHomeLinea() {
		return homeLinea;
	}
	public void setHomeLinea(WsHomeLineaInDTO homeLinea) {
		this.homeLinea = homeLinea;
	}
	public WsSimcardInDTO getSimcard() {
		return simcard;
	}
	public void setSimcard(WsSimcardInDTO simcard) {
		this.simcard = simcard;
	}
	public WsDatosPlanTerifarioInDTO getDatosPlanTerifario() {
		return datosPlanTerifario;
	}
	public void setDatosPlanTerifario(WsDatosPlanTerifarioInDTO datosPlanTerifario) {
		this.datosPlanTerifario = datosPlanTerifario;
	}	
	public WsTerminalInDTO getTerminal() {
		return terminal;
	}
	public void setTerminal(WsTerminalInDTO terminal) {
		this.terminal = terminal;
	}
	public WsUsuarioInDTO getUsuarioLinea() {
		return usuarioLinea;
	}
	public void setUsuarioLinea(WsUsuarioInDTO usuarioLinea) {
		this.usuarioLinea = usuarioLinea;
	}
	
	

}
