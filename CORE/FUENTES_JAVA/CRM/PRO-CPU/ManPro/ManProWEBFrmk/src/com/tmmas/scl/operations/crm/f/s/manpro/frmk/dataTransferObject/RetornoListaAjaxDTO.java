package com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject;

import java.io.Serializable;

public class RetornoListaAjaxDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Object[] lista;
	private String codError;
	private String msgError;
	private String abrirPopupFiltro="N";
	
	public RetornoListaAjaxDTO() {
		this.codError = "";
		this.msgError = "";
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public Object[] getLista() {
		return lista;
	}
	public void setLista(Object[] lista) {
		this.lista = lista;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
	public String getAbrirPopupFiltro() {
		return abrirPopupFiltro;
	}
	public void setAbrirPopupFiltro(String abrirPopupFiltro) {
		this.abrirPopupFiltro = abrirPopupFiltro;
	}

}
