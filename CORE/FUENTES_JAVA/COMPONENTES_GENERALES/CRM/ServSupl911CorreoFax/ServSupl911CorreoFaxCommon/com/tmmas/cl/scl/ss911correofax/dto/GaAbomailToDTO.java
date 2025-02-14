package com.tmmas.cl.scl.ss911correofax.dto;

import java.io.Serializable;
import java.sql.Timestamp;

public class GaAbomailToDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected long numAbonado;
	protected String codProducto;
	protected String codServicio;
	protected String abomail;
	protected String username;
	protected String passworabo;
	protected String usuario;
	protected Timestamp fechaAlta;
	protected String indEstado;
	protected String observacion;
	protected String fecBaja;
	
	public String getAbomail() {
		return abomail;
	}
	public void setAbomail(String abomail) {
		this.abomail = abomail;
	}
	public String getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public String getFecBaja() {
		return fecBaja;
	}
	public void setFecBaja(String fecBaja) {
		this.fecBaja = fecBaja;
	}
	public Timestamp getFechaAlta() {
		return fechaAlta;
	}
	public void setFechaAlta(Timestamp fechaAlta) {
		this.fechaAlta = fechaAlta;
	}
	public String getIndEstado() {
		return indEstado;
	}
	public void setIndEstado(String indEstado) {
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
	public String getPassworabo() {
		return passworabo;
	}
	public void setPassworabo(String passworabo) {
		this.passworabo = passworabo;
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
