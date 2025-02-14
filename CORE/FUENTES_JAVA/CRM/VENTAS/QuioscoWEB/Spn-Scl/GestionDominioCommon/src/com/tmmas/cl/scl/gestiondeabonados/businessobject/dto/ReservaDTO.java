package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class ReservaDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long numeroSolicitud;
	private String numeroSerie;
	private int codArticulo;
	private int codUso;
	private String estadoReserva;
	private long codVendedor;
	private String nomUsuario;
	
	public int getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(int codArticulo) {
		this.codArticulo = codArticulo;
	}
	public int getCodUso() {
		return codUso;
	}
	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getEstadoReserva() {
		return estadoReserva;
	}
	public void setEstadoReserva(String estadoReserva) {
		this.estadoReserva = estadoReserva;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}
	public long getNumeroSolicitud() {
		return numeroSolicitud;
	}
	public void setNumeroSolicitud(long numeroSolicitud) {
		this.numeroSolicitud = numeroSolicitud;
	}
	
	

}
