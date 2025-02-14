package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class InfoFacturaDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private DetalleFacturaVO[] lisdetalleFactura;
	private String totalCargos;
	private String totalITBM;
	private String totalISC;
	private String totalAPagar;
	private String numFolio;
	private String prefPlaza;
	private String descuento;
	private String iva;
	
	//Inicio Inc. 177348 - 06/11/2011 -  FADL 
	private String impCruzRoja;
	private String impNum911;
	private String impVenta;
	private String descuentoTotal;
	private String numSerie;
	//Fin Inc. 177348 - 06/11/2011 -  FADL 
	
	public String getDescuento() {
		return descuento;
	}
	public void setDescuento(String descuento) {
		this.descuento = descuento;
	}
	public DetalleFacturaVO[] getLisdetalleFactura() {
		return lisdetalleFactura;
	}
	public void setLisdetalleFactura(DetalleFacturaVO[] lisdetalleFactura) {
		this.lisdetalleFactura = lisdetalleFactura;
	}
	public String getNumFolio() {
		return numFolio;
	}
	public void setNumFolio(String numFolio) {
		this.numFolio = numFolio;
	}
	public String getPrefPlaza() {
		return prefPlaza;
	}
	public void setPrefPlaza(String prefPlaza) {
		this.prefPlaza = prefPlaza;
	}
	public String getTotalAPagar() {
		return totalAPagar;
	}
	public void setTotalAPagar(String totalAPagar) {
		this.totalAPagar = totalAPagar;
	}
	public String getTotalCargos() {
		return totalCargos;
	}
	public void setTotalCargos(String totalCargos) {
		this.totalCargos = totalCargos;
	}
	public String getTotalISC() {
		return totalISC;
	}
	public void setTotalISC(String totalISC) {
		this.totalISC = totalISC;
	}
	public String getTotalITBM() {
		return totalITBM;
	}
	public void setTotalITBM(String totalITBM) {
		this.totalITBM = totalITBM;
	}
	public String getIva() {
		return iva;
	}
	public void setIva(String iva) {
		this.iva = iva;
	}
	//Inicio Inc. 177348 - 06/11/2011 -  FADL 
	public String getImpCruzRoja() {
		return impCruzRoja;
	}
	public void setImpCruzRoja(String impCruzRoja) {
		this.impCruzRoja = impCruzRoja;
	}
	public String getImpNum911() {
		return impNum911;
	}
	public void setImpNum911(String impNum911) {
		this.impNum911 = impNum911;
	}
	public String getImpVenta() {
		return impVenta;
	}
	public void setImpVenta(String impVenta) {
		this.impVenta = impVenta;
	}
	public String getDescuentoTotal() {
		return descuentoTotal;
	}
	public void setDescuentoTotal(String descuentoTotal) {
		this.descuentoTotal = descuentoTotal;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	//Fin Inc. 177348 - 06/11/2011 -  FADL 

}
