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
 * 11/04/2007     Wildo Ramos      					Versión Inicial
 */

package com.tmmas.cl.scl.frameworkcargossrv.service.dto;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;

//import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosReglaDTO;

public class ParametrosReglasSimcardDTO extends ParametrosReglaDTO {
	
	private static final long serialVersionUID = 1L;

	private String codigoArticulo;
	private String tipoStock;
	private String codigoUso;
	private String estado;
	private String indiceRecambioPrecioLista;
	private String indiceRecambioNoLista;
	private String codigoCategoria;
	private String indicadorValorar;
	private String indicadorPrecioLista;
	private String grupoTecnologico; 
	private String grupoTecnologiaGSM; 
	private String codigoPlanTarifario;
	private String codigoModalidadVenta;
	private String tipoContrato;
	private String numAbonado;
	private String numSerie;
	private String paramRenova;
	
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getTipoContrato() {
		return tipoContrato;
	}
	public void setTipoContrato(String tipoContrato) {
		this.tipoContrato = tipoContrato;
	}
	public String getCodigoModalidadVenta() {
		return codigoModalidadVenta;
	}
	public void setCodigoModalidadVenta(String codigoModalidadVenta) {
		this.codigoModalidadVenta = codigoModalidadVenta;
	}
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getGrupoTecnologiaGSM() {
		return grupoTecnologiaGSM;
	}
	public void setGrupoTecnologiaGSM(String grupoTecnologiaGSM) {
		this.grupoTecnologiaGSM = grupoTecnologiaGSM;
	}
	public String getIndicadorPrecioLista() {
		return indicadorPrecioLista;
	}
	public void setIndicadorPrecioLista(String indicadorPrecioLista) {
		this.indicadorPrecioLista = indicadorPrecioLista;
	}
	public String getIndicadorValorar() {
		return indicadorValorar;
	}
	public void setIndicadorValorar(String indicadorValorar) {
		this.indicadorValorar = indicadorValorar;
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
	public String getCodigoUso() {
		return codigoUso;
	}
	public void setCodigoUso(String codigoUso) {
		this.codigoUso = codigoUso;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getTipoStock() {
		return tipoStock;
	}
	public void setTipoStock(String tipoStock) {
		this.tipoStock = tipoStock;
	}
	public String getGrupoTecnologico() {
		return grupoTecnologico;
	}
	public void setGrupoTecnologico(String grupoTecnologico) {
		this.grupoTecnologico = grupoTecnologico;
	}
	public String getIndiceRecambioNoLista() {
		return indiceRecambioNoLista;
	}
	public void setIndiceRecambioNoLista(String indiceRecambioNoLista) {
		this.indiceRecambioNoLista = indiceRecambioNoLista;
	}
	public String getIndiceRecambioPrecioLista() {
		return indiceRecambioPrecioLista;
	}
	public void setIndiceRecambioPrecioLista(String indiceRecambioPrecioLista) {
		this.indiceRecambioPrecioLista = indiceRecambioPrecioLista;
	}
	public String getParamRenova() {
		return paramRenova;
	}
	public void setParamRenova(String paramRenova) {
		this.paramRenova = paramRenova;
	}
	
}//fin ParametrosReglasSimcardDTO
