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

public class ParametrosDescuentoDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private String indicadorCiclo;
	private int numeroMesesFact;
	private String codigoCliente;
	private String codigoVendedor;
	private String codigoOperacion;
	private String tipoContrato;
	private int numeroMesesContrato;
	private String codigoAntiguedad;
	private String codigoPromedioFacturable;
	private String codigoContratoNuevo;
	private String numeroMesesNuevo;
	private String codigoArticulo;
	private String indiceVentaExterna;
	private String codigoCausaDescuento;
	private String codigoCausaVenta;
	private String codigoCategoria;
	private String codigoModalidadVenta;
	private String tipoPlanTarifario;
	private String concepto;
	private String claseDescuento;
	private String codAbonocel;
	private String equipoEstado;
	private String claseDescuentoArticulo;
	private float valorPromedioFact;
	private String codigoConcepto;
	private String tipoConcepto;
	private String tipoConceptoDescuento;
	private String codigoCalificaion;
	private int indRenovacion;
	
	public int getIndRenovacion() {
		return indRenovacion;
	}
	public void setIndRenovacion(int indRenovacion) {
		this.indRenovacion = indRenovacion;
	}
	public String getCodigoCalificaion() {
		return codigoCalificaion;
	}
	public void setCodigoCalificaion(String codigoCalificaion) {
		this.codigoCalificaion = codigoCalificaion;
	}
	public String getTipoConcepto() {
		return tipoConcepto;
	}
	public void setTipoConcepto(String tipoConcepto) {
		this.tipoConcepto = tipoConcepto;
	}
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public float getValorPromedioFact() {
		return valorPromedioFact;
	}
	public void setValorPromedioFact(float valorPromedioFact) {
		this.valorPromedioFact = valorPromedioFact;
	}
	public String getClaseDescuentoArticulo() {
		return claseDescuentoArticulo;
	}
	public void setClaseDescuentoArticulo(String claseDescuentoArticulo) {
		this.claseDescuentoArticulo = claseDescuentoArticulo;
	}
	public String getEquipoEstado() {
		return equipoEstado;
	}
	public void setEquipoEstado(String equipoEstado) {
		this.equipoEstado = equipoEstado;
	}
	public String getCodAbonocel() {
		return codAbonocel;
	}
	public void setCodAbonocel(String codAbonocel) {
		this.codAbonocel = codAbonocel;
	}
	public String getClaseDescuento() {
		return claseDescuento;
	}
	public void setClaseDescuento(String claseDescuento) {
		this.claseDescuento = claseDescuento;
	}
	public String getCodigoAntiguedad() {
		return codigoAntiguedad;
	}
	public void setCodigoAntiguedad(String codigoAntiguedad) {
		this.codigoAntiguedad = codigoAntiguedad;
	}
	public String getCodigoArticulo() {
		return codigoArticulo;
	}
	public void setCodigoArticulo(String codigoArticulo) {
		this.codigoArticulo = codigoArticulo;
	}
	public String getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}
	public String getCodigoCausaVenta() {
		return codigoCausaVenta;
	}
	public void setCodigoCausaVenta(String codigoCausaVenta) {
		this.codigoCausaVenta = codigoCausaVenta;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoContratoNuevo() {
		return codigoContratoNuevo;
	}
	public void setCodigoContratoNuevo(String codigoContratoNuevo) {
		this.codigoContratoNuevo = codigoContratoNuevo;
	}
	public String getCodigoModalidadVenta() {
		return codigoModalidadVenta;
	}
	public void setCodigoModalidadVenta(String codigoModalidadVenta) {
		this.codigoModalidadVenta = codigoModalidadVenta;
	}
	public String getCodigoOperacion() {
		return codigoOperacion;
	}
	public void setCodigoOperacion(String codigoOperacion) {
		this.codigoOperacion = codigoOperacion;
	}
	public String getCodigoPromedioFacturable() {
		return codigoPromedioFacturable;
	}
	public void setCodigoPromedioFacturable(String codigoPromedioFacturable) {
		this.codigoPromedioFacturable = codigoPromedioFacturable;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getConcepto() {
		return concepto;
	}
	public void setConcepto(String concepto) {
		this.concepto = concepto;
	}
	public String getIndicadorCiclo() {
		return indicadorCiclo;
	}
	public void setIndicadorCiclo(String indicadorCiclo) {
		this.indicadorCiclo = indicadorCiclo;
	}
	public String getIndiceVentaExterna() {
		return indiceVentaExterna;
	}
	public void setIndiceVentaExterna(String indiceVentaExterna) {
		this.indiceVentaExterna = indiceVentaExterna;
	}
	public int getNumeroMesesContrato() {
		return numeroMesesContrato;
	}
	public void setNumeroMesesContrato(int numeroMesesContrato) {
		this.numeroMesesContrato = numeroMesesContrato;
	}
	public int getNumeroMesesFact() {
		return numeroMesesFact;
	}
	public void setNumeroMesesFact(int numeroMesesFact) {
		this.numeroMesesFact = numeroMesesFact;
	}
	public String getNumeroMesesNuevo() {
		return numeroMesesNuevo;
	}
	public void setNumeroMesesNuevo(String numeroMesesNuevo) {
		this.numeroMesesNuevo = numeroMesesNuevo;
	}
	public String getTipoContrato() {
		return tipoContrato;
	}
	public void setTipoContrato(String tipoContrato) {
		this.tipoContrato = tipoContrato;
	}
	public String getTipoPlanTarifario() {
		return tipoPlanTarifario;
	}
	public void setTipoPlanTarifario(String tipoPlanTarifario) {
		this.tipoPlanTarifario = tipoPlanTarifario;
	}
	public String getTipoConceptoDescuento() {
		return tipoConceptoDescuento;
	}
	public void setTipoConceptoDescuento(String tipoConceptoDescuento) {
		this.tipoConceptoDescuento = tipoConceptoDescuento;
	}
	public String getCodigoCausaDescuento() {
		return codigoCausaDescuento;
	}
	public void setCodigoCausaDescuento(String codigoCausaDescuento) {
		this.codigoCausaDescuento = codigoCausaDescuento;
	}
	

}
