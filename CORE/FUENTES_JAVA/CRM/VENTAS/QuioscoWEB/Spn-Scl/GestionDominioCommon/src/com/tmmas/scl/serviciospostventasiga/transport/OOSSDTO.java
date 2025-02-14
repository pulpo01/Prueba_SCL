package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 05/03/2008     H&eacute;ctor Hermosilla      			Versión Inicial 
 * 
 *
 *Objeto que permite transportar información desde la capa de presentación hacia la capa de negocio del sistema. 
 *Todas las ordenes de servicios agregan una extensión de este objeto como parametro de entrada y salida.
 *
 **/
public class OOSSDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String nroOOSS;
	private String codOOSS;
	private String producto;
	private String tipInter;
	private String codInter;
	private String nomUsuario;
	private String comentario;
	private String codModulo;
	private String idGestor;
	private String numMovimiento;
	private String codEstado;
	
	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public String getCodInter() {
		return codInter;
	}
	public void setCodInter(String codInter) {
		this.codInter = codInter;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public String getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(String codOOSS) {
		this.codOOSS = codOOSS;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public String getIdGestor() {
		return idGestor;
	}
	public void setIdGestor(String idGestor) {
		this.idGestor = idGestor;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNroOOSS() {
		return nroOOSS;
	}
	public void setNroOOSS(String nroOOSS) {
		this.nroOOSS = nroOOSS;
	}
	public String getNumMovimiento() {
		return numMovimiento;
	}
	public void setNumMovimiento(String numMovimiento) {
		this.numMovimiento = numMovimiento;
	}
	public String getProducto() {
		return producto;
	}
	public void setProducto(String producto) {
		this.producto = producto;
	}
	public String getTipInter() {
		return tipInter;
	}
	public void setTipInter(String tipInter) {
		this.tipInter = tipInter;
	}
	

}
