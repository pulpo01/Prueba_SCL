/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 14/08/2007	     	Esteban Conejeros        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class OrdenServicioDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long idOrdenServicio;
	private String numOrdenServicio;
	private ClienteDTO cliente;
	private String tipoComportamiento;
	
	
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public long getIdOrdenServicio() {
		return idOrdenServicio;
	}
	public void setIdOrdenServicio(long idOrdenServicio) {
		this.idOrdenServicio = idOrdenServicio;
	}
	public String getNumOrdenServicio() {
		return numOrdenServicio;
	}
	public void setNumOrdenServicio(String numOrdenServicio) {
		this.numOrdenServicio = numOrdenServicio;
	}
	public String getTipoComportamiento() {
		return tipoComportamiento;
	}
	public void setTipoComportamiento(String tipoComportamiento) {
		this.tipoComportamiento = tipoComportamiento;
	}
	
}
