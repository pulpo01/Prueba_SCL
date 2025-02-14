package com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring;

import java.io.Serializable;

public class DatosGeneralesScoringDTO implements Serializable {

	private static final long serialVersionUID = 6369501776495510579L;

	private String codOficina;

	private String codTipComis;

	private Integer codModVenta;

	private String codTipContrato;

	private String codCuota;

	private long codVendedor;

	private Long codVendedorDealer;

	private Long codAgente;

	private String nombreVendedor;

	private String nombreVendealer;

	private long numSolScoring;

	private Long codPeriodo;

	private Double montoPreautorizado;

	private String facturaTercero;
	
	private String indVtaExterna;

	public String getIndVtaExterna() {
		return indVtaExterna;
	}

	public void setIndVtaExterna(String indVtaExterna) {
		this.indVtaExterna = indVtaExterna;
	}

	public String getFacturaTercero() {
		return facturaTercero;
	}

	public void setFacturaTercero(String facturaTercero) {
		this.facturaTercero = facturaTercero;
	}

	public Double getMontoPreautorizado() {
		return montoPreautorizado;
	}

	public void setMontoPreautorizado(Double montoPreautorizado) {
		this.montoPreautorizado = montoPreautorizado;
	}

	public Long getCodPeriodo() {
		return codPeriodo;
	}

	public void setCodPeriodo(Long codPeriodo) {
		this.codPeriodo = codPeriodo;
	}

	public Long getCodAgente() {
		return codAgente;
	}

	public void setCodAgente(Long codAgente) {
		this.codAgente = codAgente;
	}

	public String getCodCuota() {
		return codCuota;
	}

	public void setCodCuota(String codCuota) {
		this.codCuota = codCuota;
	}

	public Integer getCodModVenta() {
		return codModVenta;
	}

	public void setCodModVenta(Integer codModVenta) {
		this.codModVenta = codModVenta;
	}

	public String getCodOficina() {
		return codOficina;
	}

	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}

	public String getCodTipComis() {
		return codTipComis;
	}

	public void setCodTipComis(String codTipComis) {
		this.codTipComis = codTipComis;
	}

	public String getCodTipContrato() {
		return codTipContrato;
	}

	public void setCodTipContrato(String codTipContrato) {
		this.codTipContrato = codTipContrato;
	}

	public long getCodVendedor() {
		return codVendedor;
	}

	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}

	public Long getCodVendedorDealer() {
		return codVendedorDealer;
	}

	public void setCodVendedorDealer(Long codVendedorDealer) {
		this.codVendedorDealer = codVendedorDealer;
	}

	public String toString() {
		StringBuffer r = new StringBuffer();
		r.append(super.toString() + "\n");
		r.append("getCodAgente() [" + getCodAgente() + "]\n");
		r.append("getCodCuota() [" + getCodCuota() + "]\n");
		r.append("getCodModVenta() [" + getCodModVenta() + "]\n");
		r.append("getCodOficina() [" + getCodOficina() + "]\n");
		r.append("getCodPeriodo() [" + getCodPeriodo() + "]\n");
		r.append("getCodTipComis() [" + getCodTipComis() + "]\n");
		r.append("getCodTipContrato() [" + getCodTipContrato() + "]\n");
		r.append("getCodVendedor() [" + getCodVendedor() + "]\n");
		r.append("getCodVendedorDealer() [" + getCodVendedorDealer() + "]\n");
		r.append("getFacturaTercero() [" + getFacturaTercero() + "]\n");
		r.append("getIndVtaExterna() [" + getIndVtaExterna() + "]\n");
		r.append("getMontoPreautorizado() [" + getMontoPreautorizado() + "]\n");
		r.append("getNumSolScoring() [" + getNumSolScoring() + "]\n");
		return r.toString();
	}

	public String getNombreVendedor() {
		return nombreVendedor;
	}

	public void setNombreVendedor(String nombreVendedor) {
		this.nombreVendedor = nombreVendedor;
	}

	public String getNombreVendealer() {
		return nombreVendealer;
	}

	public void setNombreVendealer(String nombreVendealer) {
		this.nombreVendealer = nombreVendealer;
	}

	public long getNumSolScoring() {
		return numSolScoring;
	}

	public void setNumSolScoring(long numSolScoring) {
		this.numSolScoring = numSolScoring;
	}

}
