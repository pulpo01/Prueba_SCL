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
 * 10-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

public class RestriccionesContratacionDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String tipoPlataforma;
	private String indAplica;
	private String tipoComportamiento;
	private String codProducto;
	private Date   fecInicio;
	private int    cantidadMaxima;
	private String montoMaximo;
	private String minimoCiclos;
	private Date   fecTermino;	
	
	public Object[] getStruct_PF_RESTR_CONTRATA_TD_QT()
	{
		Object[] obj={	tipoPlataforma,
						indAplica,
						tipoComportamiento,
						new Integer(codProducto),
						fecInicio!=null?new Timestamp(fecInicio.getTime()):null,
						new Integer(cantidadMaxima),
						montoMaximo,
						minimoCiclos,
						fecTermino!=null?new Timestamp(fecTermino.getTime()):null
					  };
		return obj;
	}
	
	public RestriccionesContratacionDTO()
	{
		Calendar cal=Calendar.getInstance();
		cal.set(3000, 11, 31);
		fecInicio=new Date();
		fecTermino=new Date(cal.getTimeInMillis());
	}
	
	public int getCantidadMaxima() {
		return cantidadMaxima;
	}
	public void setCantidadMaxima(int cantidadMaxima) {
		this.cantidadMaxima = cantidadMaxima;
	}
	public String getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}
	public Date getFecInicio() {
		return fecInicio;
	}
	public void setFecInicio(Date fecInicio) {
		this.fecInicio = fecInicio;
	}
	public Date getFecTermino() {
		return fecTermino;
	}
	public void setFecTermino(Date fecTermino) {
		this.fecTermino = fecTermino;
	}
	public String getIndAplica() {
		return indAplica;
	}
	public void setIndAplica(String indAplica) {
		this.indAplica = indAplica;
	}
	public String getMinimoCiclos() {
		return minimoCiclos;
	}
	public void setMinimoCiclos(String minimoCiclos) {
		this.minimoCiclos = minimoCiclos;
	}
	public String getMontoMaximo() {
		return montoMaximo;
	}
	public void setMontoMaximo(String montoMaximo) {
		this.montoMaximo = montoMaximo;
	}
	public String getTipoComportamiento() {
		return tipoComportamiento;
	}
	public void setTipoComportamiento(String tipoComportamiento) {
		this.tipoComportamiento = tipoComportamiento;
	}
	public String getTipoPlataforma() {
		return tipoPlataforma;
	}
	public void setTipoPlataforma(String tipoPlataforma) {
		this.tipoPlataforma = tipoPlataforma;
	}
	
		

}
