package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class TipoStockValidoDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int tipoStockaValidar;
	private int modalidadVenta;
	private int codigoProducto;
	
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
}
