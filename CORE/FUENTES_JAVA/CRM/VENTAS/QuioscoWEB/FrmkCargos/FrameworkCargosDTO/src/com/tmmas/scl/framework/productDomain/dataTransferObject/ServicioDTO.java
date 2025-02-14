package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class ServicioDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codServicio;
	private int codServSupl;
	private int codNivel;
	private String marca;
	private String cadenaServicio;
	private String numeroAbonado;
	private String codigoPlan;
	private String codigoConcepto;
	private String numeroTerminal;
	private String codigoProducto;
	private String codigoPlanServicio;
	private String codigoActuacion;

	//-- PARA CENTRAL
	private int indicadorEstado;
		
	//-- MANEJO DE ERRORES
	private Long codigoError;
	private String descripcionError;
	private Long numeroEvento;
	
	public String getCadenaServicio() {
		return cadenaServicio;
	}
	public void setCadenaServicio(String cadenaServicio) {
		this.cadenaServicio = cadenaServicio;
	}
	public int getCodNivel() {
		return codNivel;
	}
	public void setCodNivel(int codNivel) {
		this.codNivel = codNivel;
	}
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public int getCodServSupl() {
		return codServSupl;
	}
	public void setCodServSupl(int codServSupl) {
		this.codServSupl = codServSupl;
	}
	public String getMarca() {
		return marca;
	}
	public void setMarca(String marca) {
		this.marca = marca;
	}
	public String getCodigoActuacion() {
		return codigoActuacion;
	}
	public void setCodigoActuacion(String codigoActuacion) {
		this.codigoActuacion = codigoActuacion;
	}
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
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
	public String getDescripcionError() {
		return descripcionError;
	}
	public void setDescripcionError(String descripcionError) {
		this.descripcionError = descripcionError;
	}
	public int getIndicadorEstado() {
		return indicadorEstado;
	}
	public void setIndicadorEstado(int indicadorEstado) {
		this.indicadorEstado = indicadorEstado;
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

	
}
