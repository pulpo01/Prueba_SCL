/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 13/11/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;

public class IntegraProdCPUDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long clienteOrigen;
	private long abonadoOrigen;
	private String planTarifOrigen;
	private long clienteDestino;
	private long abonadoDestino;
	private String planTarifDestino;
	private Timestamp fechaActivacionPlanes;
	private Timestamp fechaDesactivacionPlanes;
	private long numMovCentral;
	private long numProceso;
	private String origenProceso;
	
	
	public String getOrigenProceso() {
		return origenProceso;
	}
	public void setOrigenProceso(String origenProceso) {
		this.origenProceso = origenProceso;
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
	public long getAbonadoDestino() {
		return abonadoDestino;
	}
	public void setAbonadoDestino(long abonadoDestino) {
		this.abonadoDestino = abonadoDestino;
	}
	public long getAbonadoOrigen() {
		return abonadoOrigen;
	}
	public void setAbonadoOrigen(long abonadoOrigen) {
		this.abonadoOrigen = abonadoOrigen;
	}
	public long getClienteDestino() {
		return clienteDestino;
	}
	public void setClienteDestino(long clienteDestino) {
		this.clienteDestino = clienteDestino;
	}
	public long getClienteOrigen() {
		return clienteOrigen;
	}
	public void setClienteOrigen(long clienteOrigen) {
		this.clienteOrigen = clienteOrigen;
	}
	public Timestamp getFechaActivacionPlanes() {
		return fechaActivacionPlanes;
	}
	public void setFechaActivacionPlanes(Timestamp fechaActivacionPlanes) {
		this.fechaActivacionPlanes = fechaActivacionPlanes;
	}
	public Timestamp getFechaDesactivacionPlanes() {
		return fechaDesactivacionPlanes;
	}
	public void setFechaDesactivacionPlanes(Timestamp fechaDesactivacionPlanes) {
		this.fechaDesactivacionPlanes = fechaDesactivacionPlanes;
	}
	public long getNumMovCentral() {
		return numMovCentral;
	}
	public void setNumMovCentral(long numMovCentral) {
		this.numMovCentral = numMovCentral;
	}
	public long getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(long numProceso) {
		this.numProceso = numProceso;
	}
	
}
