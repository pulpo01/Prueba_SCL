package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ProcesoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private boolean  estadoValidacion;
	private boolean estadoEjecucion;
	private long codigoError;
	private long evento;
	private String tipoProceso;
	private long identificadorProceso;
	private String mensajeError;
	
	public long getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(long codigoError) {
		this.codigoError = codigoError;
	}
	public boolean isEstadoEjecucion() {
		return estadoEjecucion;
	}
	public void setEstadoEjecucion(boolean estadoEjecucion) {
		this.estadoEjecucion = estadoEjecucion;
	}
	public boolean isEstadoValidacion() {
		return estadoValidacion;
	}
	public void setEstadoValidacion(boolean estadoValidacion) {
		this.estadoValidacion = estadoValidacion;
	}
	public long getEvento() {
		return evento;
	}
	public void setEvento(long evento) {
		this.evento = evento;
	}
	public long getIdentificadorProceso() {
		return identificadorProceso;
	}
	public void setIdentificadorProceso(long identificadorProceso) {
		this.identificadorProceso = identificadorProceso;
	}
	public String getMensajeError() {
		return mensajeError;
	}
	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}
	public String getTipoProceso() {
		return tipoProceso;
	}
	public void setTipoProceso(String tipoProceso) {
		this.tipoProceso = tipoProceso;
	}
	
}
