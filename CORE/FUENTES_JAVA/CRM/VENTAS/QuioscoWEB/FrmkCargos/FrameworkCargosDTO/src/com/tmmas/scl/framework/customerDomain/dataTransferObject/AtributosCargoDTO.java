package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;


public class AtributosCargoDTO  implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private boolean recurrente;
	private boolean obligatorio;
	private int cuotas;
	private String fechaAplicacion;
	private boolean ciclo;
	private int tipoProducto;
	private int claseProducto;
	private int cicloFacturacion;
	private String codigoArticuloServicio;
	//FrameworkCargos
	private String numAbonado;
	private String numCelular;
	private String numTerminal;
	private String numSerie;
	private String numImei;
	private String numContrato;
	private String codTecnologia;
		
	
	
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public String getNumImei() {
		return numImei;
	}
	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getNumTerminal() {
		return numTerminal;
	}
	public void setNumTerminal(String numTerminal) {
		this.numTerminal = numTerminal;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}

	public boolean isCiclo() {
		return ciclo;
	}
	public void setCiclo(boolean ciclo) {
		this.ciclo = ciclo;
	}
	public int getCicloFacturacion() {
		return cicloFacturacion;
	}
	public void setCicloFacturacion(int cicloFacturacion) {
		this.cicloFacturacion = cicloFacturacion;
	}
	public int getClaseProducto() {
		return claseProducto;
	}
	public void setClaseProducto(int claseProducto) {
		this.claseProducto = claseProducto;
	}
	public String getCodigoArticuloServicio() {
		return codigoArticuloServicio;
	}
	public void setCodigoArticuloServicio(String codigoArticuloServicio) {
		this.codigoArticuloServicio = codigoArticuloServicio;
	}
	public int getCuotas() {
		return cuotas;
	}
	public void setCuotas(int cuotas) {
		this.cuotas = cuotas;
	}
	public String getFechaAplicacion() {
		return fechaAplicacion;
	}
	public void setFechaAplicacion(String fechaAplicacion) {
		this.fechaAplicacion = fechaAplicacion;
	}
	public boolean isObligatorio() {
		return obligatorio;
	}
	public void setObligatorio(boolean obligatorio) {
		this.obligatorio = obligatorio;
	}
	public boolean isRecurrente() {
		return recurrente;
	}
	public void setRecurrente(boolean recurrente) {
		this.recurrente = recurrente;
	}
	public int getTipoProducto() {
		return tipoProducto;
	}
	public void setTipoProducto(int tipoProducto) {
		this.tipoProducto = tipoProducto;
	}
	public String getNumContrato() {
		return numContrato;
	}
	public void setNumContrato(String numContrato) {
		this.numContrato = numContrato;
	}
	
	
	
}
