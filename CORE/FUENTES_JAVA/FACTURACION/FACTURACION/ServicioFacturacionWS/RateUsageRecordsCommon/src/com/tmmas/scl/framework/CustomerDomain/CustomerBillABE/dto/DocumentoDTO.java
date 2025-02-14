/**
 *  @ Project : P-TMM-08004
 *  @ File Name : Documento.java
 *  @ Date : 28/08/2008  
 *  @ Author : hsegura   
 */

package com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto;

import java.io.Serializable;


public abstract  class DocumentoDTO implements Serializable  {
	private String modalidadCobro;
	private String numeroCuotas;
	private String tipoDocumento;
	private String moneda;
	private String tipoGlosa;
	private String usuarioSistema;
	private CabeceraDocumentoDTO cabeceraDocumento;
	private DetalleDocumentoDTO detalleDocumento;
	public CabeceraDocumentoDTO getCabeceraDocumento() {
		return cabeceraDocumento;
	}
	public void setCabeceraDocumento(CabeceraDocumentoDTO cabeceraDocumento) {
		this.cabeceraDocumento = cabeceraDocumento;
	}
	public DetalleDocumentoDTO getDetalleDocumento() {
		return detalleDocumento;
	}
	public void setDetalleDocumento(DetalleDocumentoDTO detalleDocumento) {
		this.detalleDocumento = detalleDocumento;
	}
	public String getModalidadCobro() {
		return modalidadCobro;
	}
	public void setModalidadCobro(String modalidadCobro) {
		this.modalidadCobro = modalidadCobro;
	}
	public String getMoneda() {
		return moneda;
	}
	public void setMoneda(String moneda) {
		this.moneda = moneda;
	}
	public String getNumeroCuotas() {
		return numeroCuotas;
	}
	public void setNumeroCuotas(String numeroCuotas) {
		this.numeroCuotas = numeroCuotas;
	}
	public String getTipoDocumento() {
		return tipoDocumento;
	}
	public void setTipoDocumento(String tipoDocumento) {
		this.tipoDocumento = tipoDocumento;
	}
	public String getTipoGlosa() {
		return tipoGlosa;
	}
	public void setTipoGlosa(String tipoGlosa) {
		this.tipoGlosa = tipoGlosa;
	}
	public String getUsuarioSistema() {
		return usuarioSistema;
	}
	public void setUsuarioSistema(String usuarioSistema) {
		this.usuarioSistema = usuarioSistema;
	}	
	
	
}
