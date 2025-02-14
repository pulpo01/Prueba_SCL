/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 11/04/2007     Héctor Hermosilla             			Versión Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class ParametrosObtencionCargosDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private String codigoCliente;
	private String codigoVendedor;
	private int numeroMesesContrato;
	private int indicadorTipoVenta;
	private String numeroVenta;
	private String numeroCuotas;
	private String tipoPlanHibrido;
	private String tipoPlanPostPago;
	private String tipoPlanPrepago;
	private String codigoConcepto;
	private String tipoContrato;
	private int indComodato;
	private String codigoModalidadVenta;
	private String codigoCausalDescuento;
	
	private Long num_terminal;
	private Long num_abonado;
	private int codUsoVenta;
	private String codOficina;	
	
	
	//*-- MAYORISTA
	private String canalVendedor;
	private String procTerminal; //I:Interno - E:Externo
	
	//Release II 	
	private String cod_actabo;
	
	//Guatemala - El Salvador
	private String codigoCalificacion;
	private String tipoCliente;
	
	
	//Determina los cargos que debe cobrar dependiendo si es llamado de la Solicitud de Venta o bien de la Formalizacion
	private boolean esSolicitudVenta=true;
	
	//indica si es una renovacion de linea
	private int indRenovacion;
	private boolean esEvCrediticia=false;
	private boolean esOverride=false;
	
	public boolean isEsOverride() {
		return esOverride;
	}
	public void setEsOverride(boolean esOverride) {
		this.esOverride = esOverride;
	}
	public boolean isEsEvCrediticia() {
		return esEvCrediticia;
	}
	public void setEsEvCrediticia(boolean esEvCrediticia) {
		this.esEvCrediticia = esEvCrediticia;
	}
	public int getIndRenovacion() {
		return indRenovacion;
	}
	public void setIndRenovacion(int indRenovacion) {
		this.indRenovacion = indRenovacion;
	}
	public boolean isEsSolicitudVenta() {
		return esSolicitudVenta;
	}
	public void setEsSolicitudVenta(boolean esSolicitudVenta) {
		this.esSolicitudVenta = esSolicitudVenta;
	}
	public String getTipoCliente() {
		return tipoCliente;
	}
	public void setTipoCliente(String tipoCliente) {
		this.tipoCliente = tipoCliente;
	}
	public String getCodigoCalificacion() {
		return codigoCalificacion;
	}
	public void setCodigoCalificacion(String codigoCalificacion) {
		this.codigoCalificacion = codigoCalificacion;
	}
	public String getCod_actabo() {
		return cod_actabo;
	}
	public void setCod_actabo(String cod_actabo) {
		this.cod_actabo = cod_actabo;
	}
	public String getCanalVendedor() {
		return canalVendedor;
	}
	public void setCanalVendedor(String canalVendedor) {
		this.canalVendedor = canalVendedor;
	}
	public String getCodigoModalidadVenta() {
		return codigoModalidadVenta;
	}
	public void setCodigoModalidadVenta(String codigoModalidadVenta) {
		this.codigoModalidadVenta = codigoModalidadVenta;
	}
	public String getTipoContrato() {
		return tipoContrato;
	}
	public void setTipoContrato(String tipoContrato) {
		this.tipoContrato = tipoContrato;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getNumeroCuotas() {
		return numeroCuotas;
	}
	public void setNumeroCuotas(String numeroCuotas) {
		this.numeroCuotas = numeroCuotas;
	}
	public int getNumeroMesesContrato() {
		return numeroMesesContrato;
	}
	public void setNumeroMesesContrato(int numeroMesesContrato) {
		this.numeroMesesContrato = numeroMesesContrato;
	}
	public String getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(String numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getTipoPlanHibrido() {
		return tipoPlanHibrido;
	}
	public void setTipoPlanHibrido(String tipoPlanHibrido) {
		this.tipoPlanHibrido = tipoPlanHibrido;
	}
	public String getTipoPlanPostPago() {
		return tipoPlanPostPago;
	}
	public void setTipoPlanPostPago(String tipoPlanPostPago) {
		this.tipoPlanPostPago = tipoPlanPostPago;
	}
	public int getIndicadorTipoVenta() {
		return indicadorTipoVenta;
	}
	public void setIndicadorTipoVenta(int indicadorTipoVenta) {
		this.indicadorTipoVenta = indicadorTipoVenta;
	}
	public int getIndComodato() {
		return indComodato;
	}
	public void setIndComodato(int indComodato) {
		this.indComodato = indComodato;
	}
	public Long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(Long num_abonado) {
		this.num_abonado = num_abonado;
	}
	public Long getNum_terminal() {
		return num_terminal;
	}
	public void setNum_terminal(Long num_terminal) {
		this.num_terminal = num_terminal;
	}
	public String getCodigoCausalDescuento() {
		return codigoCausalDescuento;
	}
	public void setCodigoCausalDescuento(String codigoCausalDescuento) {
		this.codigoCausalDescuento = codigoCausalDescuento;
	}
	public String getProcTerminal() {
		return procTerminal;
	}
	public void setProcTerminal(String procTerminal) {
		this.procTerminal = procTerminal;
	}	
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public int getCodUsoVenta() {
		return codUsoVenta;
	}
	public void setCodUsoVenta(int codUsoVenta) {
		this.codUsoVenta = codUsoVenta;
	}
	public String getTipoPlanPrepago() {
		return tipoPlanPrepago;
	}
	public void setTipoPlanPrepago(String tipoPlanPrepago) {
		this.tipoPlanPrepago = tipoPlanPrepago;
	}
	
	
}
