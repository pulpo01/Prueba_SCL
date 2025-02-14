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
 * 10/04/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class AtributosCargoDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private boolean recurrente;
	private boolean obligatorio;
	private int cuotas;
	private String fechaAplicacion;
	private boolean ciclo;
	private int tipoProducto;
	private int claseProducto;
	private int cicloFacturacion;
	private String codigoArticuloServicio;
	
	public String getCodigoArticuloServicio() {
		return codigoArticuloServicio;
	}
	public void setCodigoArticuloServicio(String codigoArticuloServicio) {
		this.codigoArticuloServicio = codigoArticuloServicio;
	}
	public int getCicloFacturacion() {
		return cicloFacturacion;
	}
	public void setCicloFacturacion(int cicloFacturacion) {
		this.cicloFacturacion = cicloFacturacion;
	}
	public boolean isCiclo() {
		return ciclo;
	}
	public void setCiclo(boolean ciclo) {
		this.ciclo = ciclo;
	}
	public int getCuotas() {
		return cuotas;
	}
	public void setCuotas(int cuotas) {
		this.cuotas = cuotas;
	}
	public String getFechaAplicacion() {
		return fechaAplicacion;
	}
	public void setFechaAplicacion(String fechaAplicacion) {
		this.fechaAplicacion = fechaAplicacion;
	}
	public boolean isObligatorio() {
		return obligatorio;
	}
	public void setObligatorio(boolean obligatorio) {
		this.obligatorio = obligatorio;
	}
	public boolean isRecurrente() {
		return recurrente;
	}
	public void setRecurrente(boolean recurrente) {
		this.recurrente = recurrente;
	}
	public int getTipoProducto() {
		return tipoProducto;
	}
	public void setTipoProducto(int tipoProducto) {
		this.tipoProducto = tipoProducto;
	}
	public int getClaseProducto() {
		return claseProducto;
	}
	public void setClaseProducto(int claseProducto) {
		this.claseProducto = claseProducto;
	}
	

}
