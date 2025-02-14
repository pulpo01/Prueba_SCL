package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;
import java.sql.Timestamp;

public class GaAboMailTODTO implements Serializable {
	
	private String abomail;
	private long codProducto;
	private String codServicio;
	private Timestamp fechaAlta;
	private Timestamp fecBaja;
	private long indEstado;
	private long numAbonado;
	private String observacion;
	private String passwAbo;
	private String username;
	private String usuario;
	
	public String getAbomail() {
		return abomail;
	}
	public void setAbomail(String abomail) {
		this.abomail = abomail;
	}
	public long getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(long codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public Timestamp getFecBaja() {
		return fecBaja;
	}
	public void setFecBaja(Timestamp fecBaja) {
		this.fecBaja = fecBaja;
	}
	public Timestamp getFechaAlta() {
		return fechaAlta;
	}
	public void setFechaAlta(Timestamp fechaAlta) {
		this.fechaAlta = fechaAlta;
	}
	public long getIndEstado() {
		return indEstado;
	}
	public void setIndEstado(long indEstado) {
		this.indEstado = indEstado;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getObservacion() {
		return observacion;
	}
	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}
	public String getPasswAbo() {
		return passwAbo;
	}
	public void setPasswAbo(String passwAbo) {
		this.passwAbo = passwAbo;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
}
