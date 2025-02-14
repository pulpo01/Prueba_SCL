package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;

import org.apache.struts.action.ActionForm;


public class ConDesPlanFormOri extends ActionForm{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String checkContratado;
	private String checkContratar;
	
	private String condicH;
	private String comentH;
	private String cartaH;
	private long codOSAnt;
	private String codActuacion;
	private String evento;
	
	public String getCheckContratado() {
		return checkContratado;
	}
	public void setCheckContratado(String checkContratado) {
		this.checkContratado = checkContratado;
	}
	public String getCheckContratar() {
		return checkContratar;
	}
	public void setCheckContratar(String checkContratar) {
		this.checkContratar = checkContratar;
	}
	
	public String getCartaH() {
		return cartaH;
	}
	public void setCartaH(String cartaH) {
		this.cartaH = cartaH;
	}
	public String getCodActuacion() {
		return codActuacion;
	}
	public void setCodActuacion(String codActuacion) {
		this.codActuacion = codActuacion;
	}
	public long getCodOSAnt() {
		return codOSAnt;
	}
	public void setCodOSAnt(long codOSAnt) {
		this.codOSAnt = codOSAnt;
	}
	public String getComentH() {
		return comentH;
	}
	public void setComentH(String comentH) {
		this.comentH = comentH;
	}
	public String getCondicH() {
		return condicH;
	}
	public void setCondicH(String condicH) {
		this.condicH = condicH;
	}
	public String getEvento() {
		return evento;
	}
	public void setEvento(String evento) {
		this.evento = evento;
	}
	
	
}
