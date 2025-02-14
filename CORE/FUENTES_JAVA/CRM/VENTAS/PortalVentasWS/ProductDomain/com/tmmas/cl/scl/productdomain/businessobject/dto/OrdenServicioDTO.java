/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 28/08/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class OrdenServicioDTO 	implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long numeroAbonado = 0;
	private long numeroOrdenServicio;
	private long  ordenServicio;	
	private String comentario;
	private int tipo;
	private String userName;
	
	public int getTipo() {
		return tipo;
	}
	public void setTipo(int tipo) {
		this.tipo = tipo;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public long getNumeroAbonado() {
		return numeroAbonado;
	}
	public void setNumeroAbonado(long numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}
	public long getNumeroOrdenServicio() {
		return numeroOrdenServicio;
	}
	public void setNumeroOrdenServicio(long numeroOrdenServicio) {
		this.numeroOrdenServicio = numeroOrdenServicio;
	}
	public long getOrdenServicio() {
		return ordenServicio;
	}
	public void setOrdenServicio(long ordenServicio) {
		this.ordenServicio = ordenServicio;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	

}
