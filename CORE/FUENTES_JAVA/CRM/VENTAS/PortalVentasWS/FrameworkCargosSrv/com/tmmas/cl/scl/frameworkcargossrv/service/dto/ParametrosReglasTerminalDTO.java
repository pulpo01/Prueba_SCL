package com.tmmas.cl.scl.frameworkcargossrv.service.dto;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosReglaDTO;

public class ParametrosReglasTerminalDTO extends ParametrosReglaDTO {
	
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
	private String indicadorProcEquipo;
	private String codigoPlanTarifario;
	private String numeroSerie;
	private String codigoModalidadVenta;
	private String tipoContrato;
	
	private String esMayorista;
	
	private String nroSerie;
	private String codBodega;
	private String codOficina;
	private String codigoCalificacion;
	
	private String tipoCliente;
	
	private int indRenovacion;
	
	public int getIndRenovacion() {
		return indRenovacion;
	}
	public void setIndRenovacion(int indRenovacion) {
		this.indRenovacion = indRenovacion;
	}
	public String getTipoCliente() {
		return tipoCliente;
	}
	public void setTipoCliente(String tipoCliente) {
		this.tipoCliente = tipoCliente;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
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
	public String getEsMayorista() {
		return esMayorista;
	}
	public void setEsMayorista(String esMayorista) {
		this.esMayorista = esMayorista;
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
	public String getCodigoCalificacion() {
		return codigoCalificacion;
	}
	public void setCodigoCalificacion(String codigoCalificacion) {
		this.codigoCalificacion = codigoCalificacion;
	} 
	
}//fin ParametrosReglasTerminalDTO
