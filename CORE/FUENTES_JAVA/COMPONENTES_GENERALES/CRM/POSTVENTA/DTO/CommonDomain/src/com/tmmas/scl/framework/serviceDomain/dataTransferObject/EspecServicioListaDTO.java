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
 * 25/07/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

public class EspecServicioListaDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idPerfilList;
	private String nomPerfil;
	private String desPerfil;
	private String indTipoPlataforma;
	
	private Date fecIniVig;
	private Date fecTerVig;
	
	private String numMaximoLista;
	private String indTipoComportamiento;
	private String indAutoAfinidad;	
	
	public Object[] getStruct_SE_PERFIL_LISTA_TD_QT()
	{
		Object[] obj={	idPerfilList,
						nomPerfil,
						desPerfil,
						indTipoPlataforma,
						fecIniVig!=null?new Timestamp(fecIniVig.getTime()):null,
						fecTerVig!=null?new Timestamp(fecTerVig.getTime()):null,
						numMaximoLista,
						indTipoComportamiento,
						indAutoAfinidad
					};
		return obj;
	}
	
	public Object[] getStruct_SE_DETALLE_PERFIL_TD_QT()
	{
		Object[] obj={
					  idPerfilList,
					  null,
					  numMaximoLista
					 };
		return obj;
	}	

	public EspecServicioListaDTO()
	{
		Calendar cal=Calendar.getInstance();
		cal.set(3000, 11, 31);
		this.fecIniVig=new Date();
		this.fecTerVig=new Date(cal.getTimeInMillis());
	}
	
	public Date getFecIniVig() {
		return fecIniVig;
	}

	public void setFecIniVig(Date fecIniVig) {
		this.fecIniVig = fecIniVig;
	}

	public Date getFecTerVig() {
		return fecTerVig;
	}

	public void setFecTerVig(Date fecTerVig) {
		this.fecTerVig = fecTerVig;
	}

	public String getDesPerfil() {
		return desPerfil;
	}
	public void setDesPerfil(String desPerfil) {
		this.desPerfil = desPerfil;
	}
	public String getIdPerfilList() {
		return idPerfilList;
	}
	public void setIdPerfilList(String idPerfilList) {
		this.idPerfilList = idPerfilList;
	}
	public String getIndAutoAfinidad() {
		return indAutoAfinidad;
	}
	public void setIndAutoAfinidad(String indAutoAfinidad) {
		this.indAutoAfinidad = indAutoAfinidad;
	}
	public String getIndTipoComportamiento() {
		return indTipoComportamiento;
	}
	public void setIndTipoComportamiento(String indTipoComportamiento) {
		this.indTipoComportamiento = indTipoComportamiento;
	}
	public String getIndTipoPlataforma() {
		return indTipoPlataforma;
	}
	public void setIndTipoPlataforma(String indTipoPlataforma) {
		this.indTipoPlataforma = indTipoPlataforma;
	}
	public String getNomPerfil() {
		return nomPerfil;
	}
	public void setNomPerfil(String nomPerfil) {
		this.nomPerfil = nomPerfil;
	}
	public String getNumMaximoLista() {
		return numMaximoLista;
	}
	public void setNumMaximoLista(String numMaximoLista) {
		this.numMaximoLista = numMaximoLista;
	}
	
	
	
	
}
