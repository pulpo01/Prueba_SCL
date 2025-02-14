package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class RetornoBusquedaVendedorAjaxDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String codigoOficina;
	private String codigoTipComis;
	private String codigoDistribuidor;
	private String codigoVendedor;
	
	private String codError;
	private String msgError;
	
	public RetornoBusquedaVendedorAjaxDTO() {
		this.codError = "";
		this.msgError = "";
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

	public String getCodigoOficina() {
		return codigoOficina;
	}

	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}

	public String getCodigoTipComis() {
		return codigoTipComis;
	}

	public void setCodigoTipComis(String codigoTipComis) {
		this.codigoTipComis = codigoTipComis;
	}

	public String getCodigoDistribuidor() {
		return codigoDistribuidor;
	}

	public void setCodigoDistribuidor(String codigoDistribuidor) {
		this.codigoDistribuidor = codigoDistribuidor;
	}

	public String getCodigoVendedor() {
		return codigoVendedor;
	}

	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	
	
}
