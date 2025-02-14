package com.tmmas.scl.operations.crm.fab.cusintman.web.form;

import org.apache.struts.action.ActionForm;

public class BuscaNumeroForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	private String codCriterioBusqueda;
	private String tipoBusqueda;
	private String numeroSel;
	private String busquedaRangoInf;
	private String busquedaRangoSup;
	private String rangoInfSel;
	private String rangoSupSel;
	private String largoPrefijo;
	private String largoNumCelular;
	private String tablaNumeracionAut;
	private String categoria;
	private String fechaBaja;
	private String rdTipoBusqueda;
	private String rdNumeroSel;
	private String numeroAnteriorRes;
	private String nombreCliente;
	
	
	public String getCodCriterioBusqueda() {
		return codCriterioBusqueda;
	}
	public void setCodCriterioBusqueda(String codCriterioBusqueda) {
		this.codCriterioBusqueda = codCriterioBusqueda;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getNumeroAnteriorRes() {
		return numeroAnteriorRes;
	}
	public void setNumeroAnteriorRes(String numeroAnteriorRes) {
		this.numeroAnteriorRes = numeroAnteriorRes;
	}
	public String getRdNumeroSel() {
		return rdNumeroSel;
	}
	public void setRdNumeroSel(String rdNumeroSel) {
		this.rdNumeroSel = rdNumeroSel;
	}
	
	public String getRdTipoBusqueda() {
		return rdTipoBusqueda;
	}
	public void setRdTipoBusqueda(String rdTipoBusqueda) {
		this.rdTipoBusqueda = rdTipoBusqueda;
	}

	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	public String getTablaNumeracionAut() {
		return tablaNumeracionAut;
	}
	public void setTablaNumeracionAut(String tablaNumeracionAut) {
		this.tablaNumeracionAut = tablaNumeracionAut;
	}
	public String getLargoNumCelular() {
		return largoNumCelular;
	}
	public void setLargoNumCelular(String largoNumCelular) {
		this.largoNumCelular = largoNumCelular;
	}
	public String getLargoPrefijo() {
		return largoPrefijo;
	}
	public void setLargoPrefijo(String largoPrefijo) {
		this.largoPrefijo = largoPrefijo;
	}
	public String getRangoInfSel() {
		return rangoInfSel;
	}
	public void setRangoInfSel(String rangoInfSel) {
		this.rangoInfSel = rangoInfSel;
	}
	public String getRangoSupSel() {
		return rangoSupSel;
	}
	public void setRangoSupSel(String rangoSupSel) {
		this.rangoSupSel = rangoSupSel;
	}
	public String getNumeroSel() {
		return numeroSel;
	}
	public void setNumeroSel(String numeroSel) {
		this.numeroSel = numeroSel;
	}
	
	public String getBusquedaRangoInf() {
		return busquedaRangoInf;
	}
	public void setBusquedaRangoInf(String busquedaRangoInf) {
		this.busquedaRangoInf = busquedaRangoInf;
	}
	public String getBusquedaRangoSup() {
		return busquedaRangoSup;
	}
	public void setBusquedaRangoSup(String busquedaRangoSup) {
		this.busquedaRangoSup = busquedaRangoSup;
	}
	public String getTipoBusqueda() {
		return tipoBusqueda;
	}
	public void setTipoBusqueda(String tipoBusqueda) {
		this.tipoBusqueda = tipoBusqueda;
	}

	public String getFechaBaja() {
		return fechaBaja;
	}
	public void setFechaBaja(String fechaBaja) {
		this.fechaBaja = fechaBaja;
	}
	
}
