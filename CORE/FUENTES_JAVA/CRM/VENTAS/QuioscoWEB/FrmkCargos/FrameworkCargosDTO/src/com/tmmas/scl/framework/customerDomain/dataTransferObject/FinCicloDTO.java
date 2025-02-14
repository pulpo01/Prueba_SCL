/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class FinCicloDTO implements Serializable {
	private static final long serialVersionUID = 1L;	

	private long idOSS;
	private String codOOSS;
	private String fechaEjecucion;
	private long codCliente;
	private long numAbonado;
	
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(String codOOSS) {
		this.codOOSS = codOOSS;
	}
	public String getFechaEjecucion() {
		return fechaEjecucion;
	}
	public void setFechaEjecucion(String fechaEjecucion) {
		this.fechaEjecucion = fechaEjecucion;
	}
	public long getIdOSS() {
		return idOSS;
	}
	public void setIdOSS(long idOSS) {
		this.idOSS = idOSS;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}

}
