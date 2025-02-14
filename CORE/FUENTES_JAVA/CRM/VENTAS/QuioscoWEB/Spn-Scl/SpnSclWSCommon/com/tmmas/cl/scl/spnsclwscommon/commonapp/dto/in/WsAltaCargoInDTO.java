package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

public class WsAltaCargoInDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String numeroLinea;
	private String serieTerminal;
	private String montoDescuentoSimcard;
	private String montoDescuentoTerminal;
	private String codigoCausaDescuentoSimcard;
	private String codigoCausaDescuentoTerminal;
	private String montoGarantía;
	
	
	
	public String getCodigoCausaDescuentoSimcard() {
		return codigoCausaDescuentoSimcard;
	}
	public void setCodigoCausaDescuentoSimcard(String codigoCausaDescuentoSimcard) {
		this.codigoCausaDescuentoSimcard = codigoCausaDescuentoSimcard;
	}
	public String getCodigoCausaDescuentoTerminal() {
		return codigoCausaDescuentoTerminal;
	}
	public void setCodigoCausaDescuentoTerminal(String codigoCausaDescuentoTerminal) {
		this.codigoCausaDescuentoTerminal = codigoCausaDescuentoTerminal;
	}
	public String getMontoDescuentoSimcard() {
		return montoDescuentoSimcard;
	}
	public void setMontoDescuentoSimcard(String montoDescuentoSimcard) {
		this.montoDescuentoSimcard = montoDescuentoSimcard;
	}
	public String getMontoDescuentoTerminal() {
		return montoDescuentoTerminal;
	}
	public void setMontoDescuentoTerminal(String montoDescuentoTerminal) {
		this.montoDescuentoTerminal = montoDescuentoTerminal;
	}
	public String getMontoGarantía() {
		return montoGarantía;
	}
	public void setMontoGarantía(String montoGarantía) {
		this.montoGarantía = montoGarantía;
	}
	public String getNumeroLinea() {
		return numeroLinea;
	}
	public void setNumeroLinea(String numeroLinea) {
		this.numeroLinea = numeroLinea;
	}
	public String getSerieTerminal() {
		return serieTerminal;
	}
	public void setSerieTerminal(String serieTerminal) {
		this.serieTerminal = serieTerminal;
	}


}
