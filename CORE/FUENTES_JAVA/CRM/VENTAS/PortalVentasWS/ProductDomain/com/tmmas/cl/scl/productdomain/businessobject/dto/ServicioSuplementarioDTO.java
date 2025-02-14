package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class ServicioSuplementarioDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String codigoServicio;
	private String numeroAbonado;
	private String codigoPlan;
	private String codigoServSupl;
	private String codigoNivel;
	private String codigoConcepto;
	private String numeroTerminal;
	private String codigoProducto;
	private String codigoPlanServicio;
	private String codigoActuacion;
	private String nomUsuario;
	private String cadSSNivel;
	
	//-- CENTRAL
	private int indicadorEstado;
	private int codigoSistema;
	private String tipoTerminal;
	private String codigoModulo;

	//-- ADICIONALES
	private String cadenaCodServs;
	private String cadenaServNivel;
	private String codTecnologia;
	
	//-- MANEJO DE ERRORES
	private Long codigoError;
	private String descripcionError;
	private Long numeroEvento;
	
	private String esCargoInstalacion="0";
	
	
	public String getEsCargoInstalacion() {
		return esCargoInstalacion;
	}
	public void setEsCargoInstalacion(String esCargoInstalacion) {
		this.esCargoInstalacion = esCargoInstalacion;
	}
	public Long getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(Long codigoError) {
		this.codigoError = codigoError;
	}
	public String getCodigoPlan() {
		return codigoPlan;
	}
	public void setCodigoPlan(String codigoPlan) {
		this.codigoPlan = codigoPlan;
	}
	public String getCodigoServicio() {
		return codigoServicio;
	}
	public void setCodigoServicio(String codigoServicio) {
		this.codigoServicio = codigoServicio;
	}
	public String getDescripcionError() {
		return descripcionError;
	}
	public void setDescripcionError(String descripcionError) {
		this.descripcionError = descripcionError;
	}
	public String getNumeroAbonado() {
		return numeroAbonado;
	}
	public void setNumeroAbonado(String numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}
	public Long getNumeroEvento() {
		return numeroEvento;
	}
	public void setNumeroEvento(Long numeroEvento) {
		this.numeroEvento = numeroEvento;
	}
	public String getNumeroTerminal() {
		return numeroTerminal;
	}
	public void setNumeroTerminal(String numeroTerminal) {
		this.numeroTerminal = numeroTerminal;
	}
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getCodigoNivel() {
		return codigoNivel;
	}
	public void setCodigoNivel(String codigoNivel) {
		this.codigoNivel = codigoNivel;
	}
	public String getCodigoServSupl() {
		return codigoServSupl;
	}
	public void setCodigoServSupl(String codigoServSupl) {
		this.codigoServSupl = codigoServSupl;
	}
	public String getCodigoPlanServicio() {
		return codigoPlanServicio;
	}
	public void setCodigoPlanServicio(String codigoPlanServicio) {
		this.codigoPlanServicio = codigoPlanServicio;
	}
	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getCodigoActuacion() {
		return codigoActuacion;
	}
	public void setCodigoActuacion(String codigoActuacion) {
		this.codigoActuacion = codigoActuacion;
	}
	public int getIndicadorEstado() {
		return indicadorEstado;
	}
	public void setIndicadorEstado(int indicadorEstado) {
		this.indicadorEstado = indicadorEstado;
	}
	public int getCodigoSistema() {
		return codigoSistema;
	}
	public void setCodigoSistema(int codigoSistema) {
		this.codigoSistema = codigoSistema;
	}
	public String getTipoTerminal() {
		return tipoTerminal;
	}
	public void setTipoTerminal(String tipoTerminal) {
		this.tipoTerminal = tipoTerminal;
	}
	public String getCodigoModulo() {
		return codigoModulo;
	}
	public void setCodigoModulo(String codigoModulo) {
		this.codigoModulo = codigoModulo;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getCadenaCodServs() {
		return cadenaCodServs;
	}
	public void setCadenaCodServs(String cadenaCodServs) {
		this.cadenaCodServs = cadenaCodServs;
	}
	public String getCadenaServNivel() {
		return cadenaServNivel;
	}
	public void setCadenaServNivel(String cadenaServNivel) {
		this.cadenaServNivel = cadenaServNivel;
	}
	public String getCadSSNivel() {
		return cadSSNivel;
	}
	public void setCadSSNivel(String cadSSNivel) {
		this.cadSSNivel = cadSSNivel;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}

}//fin ServicioSuplementarioDTO
