package com.tmmas.cl.scl.frameworkcargossrv.service.dto;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;



//import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosReglaDTO;

public class ParametrosReglasTerminalDTO extends ParametrosReglaDTO {
	
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
	private String indicadorProcEquipo;
	private String codigoPlanTarifario;
	private String numeroSerie;
	private String codigoModalidadVenta;
	private String tipoContrato;
	private String numAbonado;
	private String numeroImei;
	private String numeroCelular;
	private String numeroContrato;
	private String codigoTecnologia;
	private String paramRenova; 	// INI P-MIX-09003 OCB;
	
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}
	public String getNumeroContrato() {
		return numeroContrato;
	}
	public void setNumeroContrato(String numeroContrato) {
		this.numeroContrato = numeroContrato;
	}
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public String getNumeroImei() {
		return numeroImei;
	}
	public void setNumeroImei(String numeroImei) {
		this.numeroImei = numeroImei;
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
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getIndicadorProcEquipo() {
		return indicadorProcEquipo;
	}
	public void setIndicadorProcEquipo(String indicadorProcEquipo) {
		this.indicadorProcEquipo = indicadorProcEquipo;
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
	public String getTipoStock() {
		return tipoStock;
	}
	public void setTipoStock(String tipoStock) {
		this.tipoStock = tipoStock;
	}
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	} 
	
	// INI P-MIX-09003 OCB;
	public String getParamRenova() {
		return paramRenova;
	}
	public void setParamRenova(String paramRenova) {
		this.paramRenova = paramRenova;
	}
	// FIN P-MIX-09003 OCB;
	
}//fin ParametrosReglasTerminalDTO
