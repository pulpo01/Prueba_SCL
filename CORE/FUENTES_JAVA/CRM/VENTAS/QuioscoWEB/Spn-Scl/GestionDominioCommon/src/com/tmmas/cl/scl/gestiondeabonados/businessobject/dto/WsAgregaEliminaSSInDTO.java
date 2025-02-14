package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class WsAgregaEliminaSSInDTO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoServicio;
	private String descripcionServicioS;
	private String codigoServSupl;
	private String codigoNivel;
	private String codigoConcepto;
	private String duracion;
	
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getCodigoNivel() {
		return codigoNivel;
	}
	public void setCodigoNivel(String codigoNivel) {
		this.codigoNivel = codigoNivel;
	}
	public String getCodigoServicio() {
		return codigoServicio;
	}
	public void setCodigoServicio(String codigoServicio) {
		this.codigoServicio = codigoServicio;
	}
	public String getCodigoServSupl() {
		return codigoServSupl;
	}
	public void setCodigoServSupl(String codigoServSupl) {
		this.codigoServSupl = codigoServSupl;
	}
	public String getDescripcionServicioS() {
		return descripcionServicioS;
	}
	public void setDescripcionServicioS(String descripcionServicioS) {
		this.descripcionServicioS = descripcionServicioS;
	}
	public String getDuracion() {
		return duracion;
	}
	public void setDuracion(String duracion) {
		this.duracion = duracion;
	}	
}
