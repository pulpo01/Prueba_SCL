package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class DetalleDevolucionDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codDevolucion;
	private String linDevolucion;
	private String codPedido;
	private String desArticulo;
	private String serie;
	private String tipoDevolucion;
	
	public String getCodDevolucion() {
		return codDevolucion;
	}
	public void setCodDevolucion(String codDevolucion) {
		this.codDevolucion = codDevolucion;
	}
	public String getLinDevolucion() {
		return linDevolucion;
	}
	public void setLinDevolucion(String linDevolucion) {
		this.linDevolucion = linDevolucion;
	}
	public String getCodPedido() {
		return codPedido;
	}
	public void setCodPedido(String codPedido) {
		this.codPedido = codPedido;
	}
	public String getDesArticulo() {
		return desArticulo;
	}
	public void setDesArticulo(String desArticulo) {
		this.desArticulo = desArticulo;
	}
	public String getSerie() {
		return serie;
	}
	public void setSerie(String serie) {
		this.serie = serie;
	}
	public String getTipoDevolucion() {
		return tipoDevolucion;
	}
	public void setTipoDevolucion(String tipoDevolucion) {
		this.tipoDevolucion = tipoDevolucion;
	}
	
	
	
}
