package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

public class GaServSuPlDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long numAbonado;
	private String codServicio;
	private long codServsupl;
	private long codNivel;
	private String desServicio;
	private String tipServicio;
	private String estado;/*puede tomar o devolver cualquier parametro*/
	
	
	public long getCodNivel() {
		return codNivel;
	}
	public void setCodNivel(long codNivel) {
		this.codNivel = codNivel;
	}
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public long getCodServsupl() {
		return codServsupl;
	}
	public void setCodServsupl(long codServsupl) {
		this.codServsupl = codServsupl;
	}
	public String getDesServicio() {
		return desServicio;
	}
	public void setDesServicio(String desServicio) {
		this.desServicio = desServicio;
	}
	
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getTipServicio() {
		return tipServicio;
	}
	public void setTipServicio(String tipServicio) {
		this.tipServicio = tipServicio;
	}
}
