/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 13/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ConversionDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long codOOSS;
	private long codOSAnt;
	private String codActuacion;
	private String codTipModi;
	private String evento;
	private String codActuacionWeb;
	
	public String getCodActuacionWeb() {
		return codActuacionWeb;
	}
	public void setCodActuacionWeb(String codActuacionWeb) {
		this.codActuacionWeb = codActuacionWeb;
	}
	public String getEvento() {
		return evento;
	}
	public void setEvento(String evento) {
		this.evento = evento;
	}
	public String getCodActuacion() {
		return codActuacion;
	}
	public void setCodActuacion(String codActuacion) {
		this.codActuacion = codActuacion;
	}
	public long getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(long codOOSS) {
		this.codOOSS = codOOSS;
	}
	public long getCodOSAnt() {
		return codOSAnt;
	}
	public void setCodOSAnt(long codOSAnt) {
		this.codOSAnt = codOSAnt;
	}
	public String getCodTipModi() {
		return codTipModi;
	}
	public void setCodTipModi(String codTipModi) {
		this.codTipModi = codTipModi;
	}
	
}
