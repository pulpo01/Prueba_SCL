package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class MensajeDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private long numeroProceso;
	private String siglaMensaje;
	private String descMensaje;
	private String usuarioConectado;
	private long numVenta;
	
	public String getDescMensaje() {
		return descMensaje;
	}
	public void setDescMensaje(String descMensaje) {
		this.descMensaje = descMensaje;
	}
	public long getNumeroProceso() {
		return numeroProceso;
	}
	public void setNumeroProceso(long numeroProceso) {
		this.numeroProceso = numeroProceso;
	}
	public String getSiglaMensaje() {
		return siglaMensaje;
	}
	public void setSiglaMensaje(String siglaMensaje) {
		this.siglaMensaje = siglaMensaje;
	}
	public String getUsuarioConectado() {
		return usuarioConectado;
	}
	public void setUsuarioConectado(String usuarioConectado) {
		this.usuarioConectado = usuarioConectado;
	}
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
	
	
	
	
}