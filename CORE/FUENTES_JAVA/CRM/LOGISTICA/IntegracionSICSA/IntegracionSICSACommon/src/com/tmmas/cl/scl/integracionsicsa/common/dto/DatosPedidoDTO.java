package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class DatosPedidoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codPedido;
	private String codEstadoFlujo;
	private String codUsuarioCre;
	private String codUsuarioIng;
	private String fecSysdate;
	
	public String getCodEstadoFlujo() {
		return codEstadoFlujo;
	}
	public void setCodEstadoFlujo(String codEstadoFlujo) {
		this.codEstadoFlujo = codEstadoFlujo;
	}
	public String getFecSysdate() {
		return fecSysdate;
	}
	public void setFecSysdate(String fecSysdate) {
		this.fecSysdate = fecSysdate;
	}
	public String getCodPedido() {
		return codPedido;
	}
	public void setCodPedido(String codPedido) {
		this.codPedido = codPedido;
	}
	public String getCodUsuarioCre() {
		return codUsuarioCre;
	}
	public void setCodUsuarioCre(String codUsuarioCre) {
		this.codUsuarioCre = codUsuarioCre;
	}
	public String getCodUsuarioIng() {
		return codUsuarioIng;
	}
	public void setCodUsuarioIng(String codUsuarioIng) {
		this.codUsuarioIng = codUsuarioIng;
	}
}
