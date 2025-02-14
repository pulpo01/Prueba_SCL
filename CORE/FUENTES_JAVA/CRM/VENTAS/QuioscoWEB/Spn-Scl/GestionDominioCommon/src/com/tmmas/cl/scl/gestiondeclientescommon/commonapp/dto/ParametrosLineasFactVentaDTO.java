package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class ParametrosLineasFactVentaDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long numCelular;
	private String numImei;
	private long codArticulo;//Terminal
	private String tipTerminal; // 'I' 'E'
	private float mntoDscSimcard;
	private float mntoDscTerminal;
	private float mntGarantiaLinea;
	private long codDscSimcard;
	private long codDscTerminal;
	private String codigoCausalDescuento;
	
	
	public String getCodigoCausalDescuento() {
		return codigoCausalDescuento;
	}
	public void setCodigoCausalDescuento(String codigoCausalDescuento) {
		this.codigoCausalDescuento = codigoCausalDescuento;
	}
	public long getCodDscSimcard() {
		return codDscSimcard;
	}
	public void setCodDscSimcard(long codDscSimcard) {
		this.codDscSimcard = codDscSimcard;
	}
	public long getCodDscTerminal() {
		return codDscTerminal;
	}
	public void setCodDscTerminal(long codDscTerminal) {
		this.codDscTerminal = codDscTerminal;
	}
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
	public float getMntGarantiaLinea() {
		return mntGarantiaLinea;
	}
	public void setMntGarantiaLinea(float mntGarantiaLinea) {
		this.mntGarantiaLinea = mntGarantiaLinea;
	}
	public float getMntoDscSimcard() {
		return mntoDscSimcard;
	}
	public void setMntoDscSimcard(float mntoDscSimcard) {
		this.mntoDscSimcard = mntoDscSimcard;
	}
	public float getMntoDscTerminal() {
		return mntoDscTerminal;
	}
	public void setMntoDscTerminal(float mntoDscTerminal) {
		this.mntoDscTerminal = mntoDscTerminal;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	
	public String getNumImei() {
		return numImei;
	}
	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
}
