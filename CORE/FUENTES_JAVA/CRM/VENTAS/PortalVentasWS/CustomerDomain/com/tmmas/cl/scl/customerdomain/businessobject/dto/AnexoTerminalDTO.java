package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class AnexoTerminalDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String desEquipo;
	private String numSerie;
	private String desPlan;
	private String prcVenta;
	private String formaPago;
	private String periodoContrato;
	private String marca;
	private String modelo;
	private String precioPrepago;
	private String oficina;
	//JLGN
	private String penalidad;
	
	public String getPenalidad() {
		return penalidad;
	}
	public void setPenalidad(String penalidad) {
		this.penalidad = penalidad;
	}
	public String getOficina() {
		return oficina;
	}
	public void setOficina(String oficina) {
		this.oficina = oficina;
	}
	public String getMarca() {
		return marca;
	}
	public void setMarca(String marca) {
		this.marca = marca;
	}
	public String getModelo() {
		return modelo;
	}
	public void setModelo(String modelo) {
		this.modelo = modelo;
	}
	public String getDesEquipo() {
		return desEquipo;
	}
	public void setDesEquipo(String desEquipo) {
		this.desEquipo = desEquipo;
	}
	public String getDesPlan() {
		return desPlan;
	}
	public void setDesPlan(String desPlan) {
		this.desPlan = desPlan;
	}
	public String getFormaPago() {
		return formaPago;
	}
	public void setFormaPago(String formaPago) {
		this.formaPago = formaPago;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getPeriodoContrato() {
		return periodoContrato;
	}
	public void setPeriodoContrato(String periodoContrato) {
		this.periodoContrato = periodoContrato;
	}
	public String getPrcVenta() {
		return prcVenta;
	}
	public void setPrcVenta(String prcVenta) {
		this.prcVenta = prcVenta;
	}
	public String getPrecioPrepago() {
		return precioPrepago;
	}
	public void setPrecioPrepago(String precioPrepago) {
		this.precioPrepago = precioPrepago;
	}
}
