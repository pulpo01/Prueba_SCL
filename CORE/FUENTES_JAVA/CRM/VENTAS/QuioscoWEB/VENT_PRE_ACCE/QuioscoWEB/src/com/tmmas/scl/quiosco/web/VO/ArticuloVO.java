package com.tmmas.scl.quiosco.web.VO;

public class ArticuloVO {
	
	//Datos del Articulo
	private String codArticulo;
	private String codTipificacion;
	private String descripcion;
	private String tipificacion;
	private String clientizable;
	private String usuaSclClient;
	
	//
	public String getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getCodTipificacion() {
		return codTipificacion;
	}
	public void setCodTipificacion(String codTipificacion) {
		this.codTipificacion = codTipificacion;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getTipificacion() {
		return tipificacion;
	}
	public void setTipificacion(String tipificacion) {
		this.tipificacion = tipificacion;
	}
	public String getClientizable() {
		return clientizable;
	}
	public void setClientizable(String clientizable) {
		this.clientizable = clientizable;
	}
	public String getUsuaSclClient() {
		return usuaSclClient;
	}
	public void setUsuaSclClient(String usuaSclClient) {
		this.usuaSclClient = usuaSclClient;
	}
	
}
