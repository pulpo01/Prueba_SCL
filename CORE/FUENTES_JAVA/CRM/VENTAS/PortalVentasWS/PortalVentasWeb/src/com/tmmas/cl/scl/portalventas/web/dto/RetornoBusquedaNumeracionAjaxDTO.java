package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class RetornoBusquedaNumeracionAjaxDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codError;
	private String msgError;
	private String tablaNumeracion;
	private String categoria;
	private String numero;
	private String fechaBaja;
	
	public String getFechaBaja() {
		return fechaBaja;
	}

	public void setFechaBaja(String fechaBaja) {
		this.fechaBaja = fechaBaja;
	}

	public String getNumero() {
		return numero;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}

	public String getCategoria() {
		return categoria;
	}

	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}

	public String getCodError() {
		return codError;
	}

	public void setCodError(String codError) {
		this.codError = codError;
	}

	public String getMsgError() {
		return msgError;
	}

	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}

	public String getTablaNumeracion() {
		return tablaNumeracion;
	}

	public void setTablaNumeracion(String tablaNumeracion) {
		this.tablaNumeracion = tablaNumeracion;
	}

	public RetornoBusquedaNumeracionAjaxDTO() {
		this.codError = "";
		this.msgError = "";
	}
}
