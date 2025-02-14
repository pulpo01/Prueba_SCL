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
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;

public class EspecServicioAltamiraDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idPlanAltamira;
	private String nombre;
	private String desPlanAltamira;
	private String tipoPlataforma;
	private String cantidadBonificada;
	private String tipoUnidadBonificacion;
	private String codListaAltamira;
	private Date   fecInicioVigencia;
	private Date   fecTerminoVigencia;
	private String tipoPlanAltamira;	
		
	public Object[] toStruct()
	{
		Object[] obj={	idPlanAltamira,
						nombre,
						desPlanAltamira,
						tipoPlataforma,
						cantidadBonificada,
						tipoUnidadBonificacion,
						codListaAltamira
					 };
		return obj;
	}
	
	public EspecServicioAltamiraDTO()
	{
		Calendar cal=Calendar.getInstance();
		cal.set(3000, 11, 31);
		this.fecInicioVigencia=new Date();
		this.fecTerminoVigencia=new Date(cal.getTimeInMillis());
	}
	
	
	public Date getFecInicioVigencia() {
		return fecInicioVigencia;
	}
	public void setFecInicioVigencia(Date fecInicioVigencia) {
		this.fecInicioVigencia = fecInicioVigencia;
	}
	public Date getFecTerminoVigencia() {
		return fecTerminoVigencia;
	}
	public void setFecTerminoVigencia(Date fecTerminoVigencia) {
		this.fecTerminoVigencia = fecTerminoVigencia;
	}



	public String getTipoPlanAltamira() {
		return tipoPlanAltamira;
	}



	public void setTipoPlanAltamira(String tipoPlanAltamira) {
		this.tipoPlanAltamira = tipoPlanAltamira;
	}



	public String getCantidadBonificada() {
		return cantidadBonificada;
	}
	public void setCantidadBonificada(String cantidadBonificada) {
		this.cantidadBonificada = cantidadBonificada;
	}
	public String getCodListaAltamira() {
		return codListaAltamira;
	}
	public void setCodListaAltamira(String codListaAltamira) {
		this.codListaAltamira = codListaAltamira;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getTipoPlataforma() {
		return tipoPlataforma;
	}
	public void setTipoPlataforma(String tipoPlataforma) {
		this.tipoPlataforma = tipoPlataforma;
	}
	public String getTipoUnidadBonificacion() {
		return tipoUnidadBonificacion;
	}
	public void setTipoUnidadBonificacion(String tipoUnidadBonificacion) {
		this.tipoUnidadBonificacion = tipoUnidadBonificacion;
	}

	public String getDesPlanAltamira() {
		return desPlanAltamira;
	}

	public void setDesPlanAltamira(String desPlanAltamira) {
		this.desPlanAltamira = desPlanAltamira;
	}

	public String getIdPlanAltamira() {
		return idPlanAltamira;
	}

	public void setIdPlanAltamira(String idPlanAltamira) {
		this.idPlanAltamira = idPlanAltamira;
	}
}
