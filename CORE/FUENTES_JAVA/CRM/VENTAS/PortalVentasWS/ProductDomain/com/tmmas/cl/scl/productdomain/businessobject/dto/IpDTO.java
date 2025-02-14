/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 14/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class IpDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long numAbonado;
	private long numCelular;
	private int codProducto;
	private String codServicio;
	private String fecAlta;
	private String codSS;
	private long codNivel;
	private String accion;
	private int estadoOld;
	private int estadoNew;
	
	
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public String getAccion() {
		return accion;
	}
	public void setAccion(String accion) {
		this.accion = accion;
	}
	public long getCodNivel() {
		return codNivel;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
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
	public String getCodSS() {
		return codSS;
	}
	public void setCodSS(String codSS) {
		this.codSS = codSS;
	}
	public int getEstadoNew() {
		return estadoNew;
	}
	public void setEstadoNew(int estadoNew) {
		this.estadoNew = estadoNew;
	}
	public int getEstadoOld() {
		return estadoOld;
	}
	public void setEstadoOld(int estadoOld) {
		this.estadoOld = estadoOld;
	}
	public String getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(String fecAlta) {
		this.fecAlta = fecAlta;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
		
}