package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class ReglaCompatibilidadSSDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	private String codProducto;
	private String codServicio;
	private String codServdef;
	private String nomIsuario;
	private String codServorig;
	private String tipRelacion;
	private String codActabo;
	
	public String getCodActabo() {
		return codActabo;
	}
	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}
	public String getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodServdef() {
		return codServdef;
	}
	public void setCodServdef(String codServdef) {
		this.codServdef = codServdef;
	}
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public String getCodServorig() {
		return codServorig;
	}
	public void setCodServorig(String codServorig) {
		this.codServorig = codServorig;
	}
	public String getNomIsuario() {
		return nomIsuario;
	}
	public void setNomIsuario(String nomIsuario) {
		this.nomIsuario = nomIsuario;
	}
	public String getTipRelacion() {
		return tipRelacion;
	}
	public void setTipRelacion(String tipRelacion) {
		this.tipRelacion = tipRelacion;
	}
	
	}
