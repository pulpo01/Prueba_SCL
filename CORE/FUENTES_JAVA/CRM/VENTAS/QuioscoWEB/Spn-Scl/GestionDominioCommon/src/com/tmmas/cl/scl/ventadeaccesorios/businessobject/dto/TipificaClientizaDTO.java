package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class TipificaClientizaDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codTipificacion;
	private int codArticulo;
	private int flagClientizable;
	private String nomUsuario;
	private int 	codError;
	private String 	msgError;	
	private int 	numEvento;	
	private String desTipificacion;
	
	public String getDesTipificacion() {
		return desTipificacion;
	}
	public void setDesTipificacion(String desTipificacion) {
		this.desTipificacion = desTipificacion;
	}
	public int getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(int codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getCodTipificacion() {
		return codTipificacion;
	}
	public void setCodTipificacion(String codTipificacion) {
		this.codTipificacion = codTipificacion;
	}

	public int getFlagClientizable() {
		return flagClientizable;
	}
	public void setFlagClientizable(int flagClientizable) {
		this.flagClientizable = flagClientizable;
	}
	public int getCodError() {
		return codError;
	}
	public void setCodError(int codError) {
		this.codError = codError;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
	public int getNumEvento() {
		return numEvento;
	}
	public void setNumEvento(int numEvento) {
		this.numEvento = numEvento;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}	
}
