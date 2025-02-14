package com.tmmas.cl.scl.frameworkcargossrv.service.dto;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;

public class ParametrosReglasKitDTO extends ParametrosReglaDTO {
	
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
	private String codTecnologia;
	
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
	public String getCodigoUso() {
		return codigoUso;
	}
	public void setCodigoUso(String codigoUso) {
		this.codigoUso = codigoUso;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getGrupoTecnologiaGSM() {
		return grupoTecnologiaGSM;
	}
	public void setGrupoTecnologiaGSM(String grupoTecnologiaGSM) {
		this.grupoTecnologiaGSM = grupoTecnologiaGSM;
	}
	public String getGrupoTecnologico() {
		return grupoTecnologico;
	}
	public void setGrupoTecnologico(String grupoTecnologico) {
		this.grupoTecnologico = grupoTecnologico;
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
	public String getTipoContrato() {
		return tipoContrato;
	}
	public void setTipoContrato(String tipoContrato) {
		this.tipoContrato = tipoContrato;
	}
	public String getTipoStock() {
		return tipoStock;
	}
	public void setTipoStock(String tipoStock) {
		this.tipoStock = tipoStock;
	}
}
