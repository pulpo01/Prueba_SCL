package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosValidacionDTO;

public class ParametrosValidacionLogisticaDTO extends ParametrosValidacionDTO{
	private static final long serialVersionUID = 1L;

	private boolean serieProgramada;
	private String codigoBodegaSimcard;
	private String codigoBodegaTerminal;
	//resultado validacion
	private String estado;
	private String glosaEstado;
	private String indProcEqTerminal;
	private String indProcEqSimcard;
	private String codigoUso;
	private String codigoArticuloTerminal;
	private String tipoArticuloTerminal;	
	private String codigoArticuloSimcard;
	private String tipoArticuloSimcard;
	private String capcodeTerminal;
	private String capcodeSimcard;
	private String tipoStockSimcard;
	private String tipoStockTerminal;
	private String desArticuloSimcard;
	private String desArticuloTerminal;
	private String codigoSubAlmSimcard;
	private String codigoEstadoSimcard;
	private String codigoEstadoTerminal;
	private int    codigoCentral;
	
	public ParametrosValidacionLogisticaDTO(){
	}
	public ParametrosValidacionLogisticaDTO(ParametrosValidacionDTO parametrosValidacion){
		this.setCodigoBodega(parametrosValidacion.getCodigoBodega());
		this.setCodigoCliente(parametrosValidacion.getCodigoCliente());
		this.setCodigoModalidadVenta(parametrosValidacion.getCodigoModalidadVenta());
		this.setCodigoPlanTarifario(parametrosValidacion.getCodigoPlanTarifario());
		this.setCodigoProducto(parametrosValidacion.getCodigoProducto());
		this.setCodigoTecnologia(parametrosValidacion.getCodigoTecnologia());
		this.setCodigoVendedor(parametrosValidacion.getCodigoVendedor());
		this.setNumeroCelular(parametrosValidacion.getNumeroCelular());
		this.setNumeroIdentificador(parametrosValidacion.getNumeroIdentificador());
		this.setNumeroSerie(parametrosValidacion.getNumeroSerie());
		this.setNumeroSerieTerminal(parametrosValidacion.getNumeroSerieTerminal());
		this.setTipoIdentificador(parametrosValidacion.getTipoIdentificador());
		this.setTipoCliente(parametrosValidacion.getTipoCliente());
		this.setLargoSerieSimcard(parametrosValidacion.getLargoSerieSimcard());
		this.setLargoSerieTerminal(parametrosValidacion.getLargoSerieTerminal());
		this.setEstadoNuevoSimcard(parametrosValidacion.getEstadoNuevoSimcard());
		this.setUsoVentaHibrido(parametrosValidacion.getUsoVentaHibrido());
		this.setUsoVentaPostpago(parametrosValidacion.getUsoVentaPostpago());		
		this.setNumeroSerieKit(parametrosValidacion.getNumeroSerieKit());
	}

	
	public int getCodigoCentral() {
		return codigoCentral;
	}
	public void setCodigoCentral(int codigoCentral) {
		this.codigoCentral = codigoCentral;
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
	public String getGlosaEstado() {
		return glosaEstado;
	}
	public void setGlosaEstado(String glosaEstado) {
		this.glosaEstado = glosaEstado;
	}
	public boolean isSerieProgramada() {
		return serieProgramada;
	}
	public void setSerieProgramada(boolean serieProgramada) {
		this.serieProgramada = serieProgramada;
	}
	
	public String getCodigoBodegaSimcard() {
		return codigoBodegaSimcard;
	}
	public void setCodigoBodegaSimcard(String codigoBodegaSimcard) {
		this.codigoBodegaSimcard = codigoBodegaSimcard;
	}
	public String getCodigoBodegaTerminal() {
		return codigoBodegaTerminal;
	}
	public void setCodigoBodegaTerminal(String codigoBodegaTerminal) {
		this.codigoBodegaTerminal = codigoBodegaTerminal;
	}
	public String getCapcodeSimcard() {
		return capcodeSimcard;
	}
	public void setCapcodeSimcard(String capcodeSimcard) {
		this.capcodeSimcard = capcodeSimcard;
	}
	public String getCapcodeTerminal() {
		return capcodeTerminal;
	}
	public void setCapcodeTerminal(String capcodeTerminal) {
		this.capcodeTerminal = capcodeTerminal;
	}
	public String getCodigoArticuloSimcard() {
		return codigoArticuloSimcard;
	}
	public void setCodigoArticuloSimcard(String codigoArticuloSimcard) {
		this.codigoArticuloSimcard = codigoArticuloSimcard;
	}
	public String getCodigoArticuloTerminal() {
		return codigoArticuloTerminal;
	}
	public void setCodigoArticuloTerminal(String codigoArticuloTerminal) {
		this.codigoArticuloTerminal = codigoArticuloTerminal;
	}
	public String getTipoArticuloSimcard() {
		return tipoArticuloSimcard;
	}
	public void setTipoArticuloSimcard(String tipoArticuloSimcard) {
		this.tipoArticuloSimcard = tipoArticuloSimcard;
	}
	public String getTipoArticuloTerminal() {
		return tipoArticuloTerminal;
	}
	public void setTipoArticuloTerminal(String tipoArticuloTerminal) {
		this.tipoArticuloTerminal = tipoArticuloTerminal;
	}
	public String getIndProcEqSimcard() {
		return indProcEqSimcard;
	}
	public void setIndProcEqSimcard(String indProcEqSimcard) {
		this.indProcEqSimcard = indProcEqSimcard;
	}
	public String getIndProcEqTerminal() {
		return indProcEqTerminal;
	}
	public void setIndProcEqTerminal(String indProcEqTerminal) {
		this.indProcEqTerminal = indProcEqTerminal;
	}
	public String getTipoStockSimcard() {
		return tipoStockSimcard;
	}
	public void setTipoStockSimcard(String tipoStockSimcard) {
		this.tipoStockSimcard = tipoStockSimcard;
	}
	public String getTipoStockTerminal() {
		return tipoStockTerminal;
	}
	public void setTipoStockTerminal(String tipoStockTerminal) {
		this.tipoStockTerminal = tipoStockTerminal;
	}
	public String getDesArticuloSimcard() {
		return desArticuloSimcard;
	}
	public void setDesArticuloSimcard(String desArticuloSimcard) {
		this.desArticuloSimcard = desArticuloSimcard;
	}
	public String getDesArticuloTerminal() {
		return desArticuloTerminal;
	}
	public void setDesArticuloTerminal(String desArticuloTerminal) {
		this.desArticuloTerminal = desArticuloTerminal;
	}
	public String getCodigoSubAlmSimcard() {
		return codigoSubAlmSimcard;
	}
	public void setCodigoSubAlmSimcard(String codigoSubAlmSimcard) {
		this.codigoSubAlmSimcard = codigoSubAlmSimcard;
	}
	public String getCodigoEstadoSimcard() {
		return codigoEstadoSimcard;
	}
	public void setCodigoEstadoSimcard(String codigoEstadoSimcard) {
		this.codigoEstadoSimcard = codigoEstadoSimcard;
	}
	public String getCodigoEstadoTerminal() {
		return codigoEstadoTerminal;
	}
	public void setCodigoEstadoTerminal(String codigoEstadoTerminal) {
		this.codigoEstadoTerminal = codigoEstadoTerminal;
	}
	
}//fin SalidaValidacionLogisticaDTO
