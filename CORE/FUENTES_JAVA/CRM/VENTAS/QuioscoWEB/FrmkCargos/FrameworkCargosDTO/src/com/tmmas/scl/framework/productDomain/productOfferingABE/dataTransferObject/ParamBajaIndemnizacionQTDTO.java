package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;

public class ParamBajaIndemnizacionQTDTO implements Serializable {


	private static final long serialVersionUID = 1L;
	
	private long cod_Producto;
	private long num_Abonado;  
	private Timestamp fec_Alta;
	private Timestamp fec_Prorroga;
	private String cod_TipContrato;
	private long num_Meses;
	
	public long getCod_Producto() {
		return cod_Producto;
	}
	public void setCod_Producto(long cod_Producto) {
		this.cod_Producto = cod_Producto;
	}
	public String getCod_TipContrato() {
		return cod_TipContrato;
	}
	public void setCod_TipContrato(String cod_TipContrato) {
		this.cod_TipContrato = cod_TipContrato;
	}
	public Timestamp getFec_Alta() {
		return fec_Alta;
	}
	public void setFec_Alta(Timestamp fec_Alta) {
		this.fec_Alta = fec_Alta;
	}
	public Timestamp getFec_Prorroga() {
		return fec_Prorroga;
	}
	public void setFec_Prorroga(Timestamp fec_Prorroga) {
		this.fec_Prorroga = fec_Prorroga;
	}
	public long getNum_Abonado() {
		return num_Abonado;
	}
	public void setNum_Abonado(long num_Abonado) {
		this.num_Abonado = num_Abonado;
	}
	public long getNum_Meses() {
		return num_Meses;
	}
	public void setNum_Meses(long num_Meses) {
		this.num_Meses = num_Meses;
	}

}
