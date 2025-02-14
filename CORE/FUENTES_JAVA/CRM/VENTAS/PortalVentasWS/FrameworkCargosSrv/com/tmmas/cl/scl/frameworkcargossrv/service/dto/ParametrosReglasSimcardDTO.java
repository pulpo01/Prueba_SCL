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

import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosReglaDTO;

public class ParametrosReglasSimcardDTO extends ParametrosReglaDTO {
	
	private static final long serialVersionUID = 1L;

	private String codigoArticulo;
	private String tipoStock;
	private int codigoUso;
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
	
	private String esMayorista;
	
	private String nroSerie;
	private String codBodega;
	private String codOficina;
	private String codigoCalificacion;
	
	private String tipoCliente;
	
	private int indRenovacion;
	private String tipoArticulo;
	
	public String getTipoArticulo() {
		return tipoArticulo;
	}
	public void setTipoArticulo(String tipoArticulo) {
		this.tipoArticulo = tipoArticulo;
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
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getEsMayorista() {
		return esMayorista;
	}
	public void setEsMayorista(String esMayorista) {
		this.esMayorista = esMayorista;
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
	public String getNroSerie() {
		return nroSerie;
	}
	public void setNroSerie(String nroSerie) {
		this.nroSerie = nroSerie;
	}
	public String getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(String codBodega) {
		this.codBodega = codBodega;
	}
	public int getCodigoUso() {
		return codigoUso;
	}
	public void setCodigoUso(int codigoUso) {
		this.codigoUso = codigoUso;
	}
	public int getIndRenovacion() {
		return indRenovacion;
	}
	public void setIndRenovacion(int indRenovacion) {
		this.indRenovacion = indRenovacion;
	}		
	
}//fin ParametrosReglasSimcardDTO
