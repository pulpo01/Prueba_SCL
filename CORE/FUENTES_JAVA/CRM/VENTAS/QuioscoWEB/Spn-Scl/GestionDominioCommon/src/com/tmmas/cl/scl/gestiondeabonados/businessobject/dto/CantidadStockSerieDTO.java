package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class CantidadStockSerieDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private String codArticulo;
	private String codBodega;
	private String codUso;
	private int cantidadStock;
	
	private String codError;
	private String codEvento;
	private String desEvento;
	private String resultadoTransaccion;
	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}
	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getCodEvento() {
		return codEvento;
	}
	public void setCodEvento(String codEvento) {
		this.codEvento = codEvento;
	}
	public String getDesEvento() {
		return desEvento;
	}
	public void setDesEvento(String desEvento) {
		this.desEvento = desEvento;
	}
	public int getCantidadStock() {
		return cantidadStock;
	}
	public void setCantidadStock(int cantidadStock) {
		this.cantidadStock = cantidadStock;
	}
	public String getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(String codBodega) {
		this.codBodega = codBodega;
	}
	public String getCodUso() {
		return codUso;
	}
	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}
	
	

}
