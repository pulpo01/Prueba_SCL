/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 28/07/2009	     	Patricio Vargas        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class EventoNumFrecDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long numAbonado;
	private long codCliente;
	private long codOOSS;
	private long numOOSS;
	private int numeroEventos;
	private long montoEvento;
	private long codConcepto;
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(long codOOSS) {
		this.codOOSS = codOOSS;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public int getNumeroEventos() {
		return numeroEventos;
	}
	public void setNumeroEventos(int numeroEventos) {
		this.numeroEventos = numeroEventos;
	}
	public long getNumOOSS() {
		return numOOSS;
	}
	public void setNumOOSS(long numOOSS) {
		this.numOOSS = numOOSS;
	}
	public long getMontoEvento() {
		return montoEvento;
	}
	public void setMontoEvento(long montoEvento) {
		this.montoEvento = montoEvento;
	}
	public long getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(long codConcepto) {
		this.codConcepto = codConcepto;
	}
}
