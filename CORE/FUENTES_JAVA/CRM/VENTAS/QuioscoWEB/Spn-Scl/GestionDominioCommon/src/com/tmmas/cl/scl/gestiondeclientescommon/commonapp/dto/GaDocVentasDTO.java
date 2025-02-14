package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class GaDocVentasDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private Long num_Venta;// NOT NULL,
	private Long cod_TipDocumento;
	private String num_Folio;
	private boolean transaccionOK;
	
	public boolean isTransaccionOK() {
		return transaccionOK;
	}
	public void setTransaccionOK(boolean transaccionOK) {
		this.transaccionOK = transaccionOK;
	}
	public Long getCod_TipDocumento() {
		return cod_TipDocumento;
	}
	public void setCod_TipDocumento(Long cod_TipDocumento) {
		this.cod_TipDocumento = cod_TipDocumento;
	}
	public String getNum_Folio() {
		return num_Folio;
	}
	public void setNum_Folio(String num_Folio) {
		this.num_Folio = num_Folio;
	}
	public Long getNum_Venta() {
		return num_Venta;
	}
	public void setNum_Venta(Long num_Venta) {
		this.num_Venta = num_Venta;
	}

}
