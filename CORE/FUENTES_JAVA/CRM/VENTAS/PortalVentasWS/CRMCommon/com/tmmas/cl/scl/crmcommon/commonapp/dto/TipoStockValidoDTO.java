package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class TipoStockValidoDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int tipoStockaValidar;
	private int modalidadVenta;
	private int codigoProducto;
	private String codigoCanal;
	
	public int getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(int codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public int getModalidadVenta() {
		return modalidadVenta;
	}
	public void setModalidadVenta(int modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}
	public int getTipoStockaValidar() {
		return tipoStockaValidar;
	}
	public void setTipoStockaValidar(int tipoStockaValidar) {
		this.tipoStockaValidar = tipoStockaValidar;
	}
	public String getCodigoCanal() {
		return codigoCanal;
	}
	public void setCodigoCanal(String codigoCanal) {
		this.codigoCanal = codigoCanal;
	}
}
