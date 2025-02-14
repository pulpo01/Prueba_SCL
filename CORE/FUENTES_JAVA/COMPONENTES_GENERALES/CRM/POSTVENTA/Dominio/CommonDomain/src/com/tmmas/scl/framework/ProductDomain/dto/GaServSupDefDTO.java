package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;
import java.sql.Timestamp;

public class GaServSupDefDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codServicio;
	private String codServicioDef;
	private String codServicioOrig;
	private String nomUsuario;
	private int tipRelacion;
	private Timestamp fecHasta;
	private Timestamp fecDesde;
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public String getCodServicioDef() {
		return codServicioDef;
	}
	public void setCodServicioDef(String codServicioDef) {
		this.codServicioDef = codServicioDef;
	}
	public String getCodServicioOrig() {
		return codServicioOrig;
	}
	public void setCodServicioOrig(String codServicioOrig) {
		this.codServicioOrig = codServicioOrig;
	}
	public Timestamp getFecDesde() {
		return fecDesde;
	}
	public void setFecDesde(Timestamp fecDesde) {
		this.fecDesde = fecDesde;
	}
	public Timestamp getFecHasta() {
		return fecHasta;
	}
	public void setFecHasta(Timestamp fecHasta) {
		this.fecHasta = fecHasta;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public int getTipRelacion() {
		return tipRelacion;
	}
	public void setTipRelacion(int tipRelacion) {
		this.tipRelacion = tipRelacion;
	}

}
