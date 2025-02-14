package com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject;

import java.io.Serializable;

public class CambioPlanAdicionalDTO implements Serializable 
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	
	private String clienteOrigen;
	private String abonadoOrigen;
	private String planTarifOrigen;
	private String clienteDestino;
	private String abonadoDestino;
	private String planTarifDestino;
	private String fechaActivacionPlanes;
	private String fechaDesactivacionPlanes;
	private String numMovCentral;
	private String numProceso;
	private String origenProceso;
	private String codOSAnulada;
	
	public String getCodOSAnulada() {
		return codOSAnulada;
	}
	public void setCodOSAnulada(String codOSAnulada) {
		this.codOSAnulada = codOSAnulada;
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
	public String getFechaActivacionPlanes() {
		return fechaActivacionPlanes;
	}
	public void setFechaActivacionPlanes(String fechaActivacionPlanes) {
		this.fechaActivacionPlanes = fechaActivacionPlanes;
	}
	public String getFechaDesactivacionPlanes() {
		return fechaDesactivacionPlanes;
	}
	public void setFechaDesactivacionPlanes(String fechaDesactivacionPlanes) {
		this.fechaDesactivacionPlanes = fechaDesactivacionPlanes;
	}
	public String getNumMovCentral() {
		return numMovCentral;
	}
	public void setNumMovCentral(String numMovCentral) {
		this.numMovCentral = numMovCentral;
	}
	public String getPlanTarifDestino() {
		return planTarifDestino;
	}
	public void setPlanTarifDestino(String planTarifDestino) {
		this.planTarifDestino = planTarifDestino;
	}
	public String getPlanTarifOrigen() {
		return planTarifOrigen;
	}
	public void setPlanTarifOrigen(String planTarifOrigen) {
		this.planTarifOrigen = planTarifOrigen;
	}
	public String getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(String numProceso) {
		this.numProceso = numProceso;
	}
	public String getOrigenProceso() {
		return origenProceso;
	}
	public void setOrigenProceso(String origenProceso) {
		this.origenProceso = origenProceso;
	}	
}
