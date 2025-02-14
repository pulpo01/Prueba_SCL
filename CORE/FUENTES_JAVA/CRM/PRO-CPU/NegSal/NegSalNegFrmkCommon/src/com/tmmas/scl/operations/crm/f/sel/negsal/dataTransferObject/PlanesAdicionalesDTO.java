package com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject;

import java.io.Serializable;

public class PlanesAdicionalesDTO implements Serializable 
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String clienteOrigen;
	private String abonadoOrigen;
	private String clienteDestino;
	private String abonadoDestino;
	private String numProceso;
	private String origenProceso;
	private String numProducto;
	private String accion;
	private String fechaDesde;
	private String fechaHasta;
	private String condicionContratacion;
	
	public PlanesAdicionalesDTO()
	{
		clienteOrigen="";
		abonadoOrigen="";
		clienteDestino="";
		abonadoDestino="";
		numProceso="";
		origenProceso="";
		numProducto="";
		accion="";
		fechaDesde="";
		fechaHasta="";
		condicionContratacion="";
	}
	public String getAbonadoDestino() {
		return abonadoDestino;
	}
	public void setAbonadoDestino(String abonadoDestino) {
		this.abonadoDestino = abonadoDestino;
	}
	public String getAbonadoOrigen() {
		return abonadoOrigen;
	}
	public void setAbonadoOrigen(String abonadoOrigen) {
		this.abonadoOrigen = abonadoOrigen;
	}
	public String getAccion() {
		return accion;
	}
	public void setAccion(String accion) {
		this.accion = accion;
	}
	public String getClienteDestino() {
		return clienteDestino;
	}
	public void setClienteDestino(String clienteDestino) {
		this.clienteDestino = clienteDestino;
	}
	public String getClienteOrigen() {
		return clienteOrigen;
	}
	public void setClienteOrigen(String clienteOrigen) {
		this.clienteOrigen = clienteOrigen;
	}
	public String getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(String numProceso) {
		this.numProceso = numProceso;
	}
	public String getNumProducto() {
		return numProducto;
	}
	public void setNumProducto(String numProducto) {
		this.numProducto = numProducto;
	}
	public String getOrigenProceso() {
		return origenProceso;
	}
	public void setOrigenProceso(String origenProceso) {
		this.origenProceso = origenProceso;
	}
	public String getCondicionContratacion() {
		return condicionContratacion;
	}
	public void setCondicionContratacion(String condicionContratacion) {
		this.condicionContratacion = condicionContratacion;
	}
	public String getFechaDesde() {
		return fechaDesde;
	}
	public void setFechaDesde(String fechaDesde) {
		this.fechaDesde = fechaDesde;
	}
	public String getFechaHasta() {
		return fechaHasta;
	}
	public void setFechaHasta(String fechaHasta) {
		this.fechaHasta = fechaHasta;
	}
	
}
