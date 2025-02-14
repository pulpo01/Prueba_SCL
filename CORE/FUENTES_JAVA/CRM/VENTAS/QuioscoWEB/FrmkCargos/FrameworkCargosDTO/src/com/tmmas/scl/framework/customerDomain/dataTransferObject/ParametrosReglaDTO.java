package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ParametrosReglaDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String nombre;
	private String codigoEjecutivo;
	private float maxDescuento;
	private float minDescuento;
	private String codigoCliente;
	private String numProceso;
	private String numCelular;
	private String numAbonado;
	private String numSerie;
	private AtributosCargoDTO atributos;
	//No declarados en el diagrama de diseño
	/*private String codigoTecnologia;
	private String tipoCargo;
	private String idProducto;*/
	
	private ParametrosDescuentoDTO parametrosDescuento;
	
	
	public AtributosCargoDTO getAtributos() {
		return atributos;
	}
	public void setAtributos(AtributosCargoDTO atributos) {
		this.atributos = atributos;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoEjecutivo() {
		return codigoEjecutivo;
	}
	public void setCodigoEjecutivo(String codigoEjecutivo) {
		this.codigoEjecutivo = codigoEjecutivo;
	}
	public float getMaxDescuento() {
		return maxDescuento;
	}
	public void setMaxDescuento(float maxDescuento) {
		this.maxDescuento = maxDescuento;
	}
	public float getMinDescuento() {
		return minDescuento;
	}
	public void setMinDescuento(float minDescuento) {
		this.minDescuento = minDescuento;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(String numProceso) {
		this.numProceso = numProceso;
	}
	public ParametrosDescuentoDTO getParametrosDescuento() {
		return parametrosDescuento;
	}
	public void setParametrosDescuento(ParametrosDescuentoDTO parametrosDescuento) {
		this.parametrosDescuento = parametrosDescuento;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	
	
	
	
	
	
}

