/**
 * Copyright � 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 09/01/2007     H�ctor Hermosilla      					Versi�n Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class GrupoCobroServicioDTO  implements Serializable{
	
	
	private static final long serialVersionUID = 1L;
	private String codigoGrupoCobroServicio;
	private String descripcionGrupoCobroServicio;
	
	
	public String getCodigoGrupoCobroServicio(){
		return codigoGrupoCobroServicio;
	}
	public void setCodigoGrupoCobroServicio(String codigoGrupoCobroServicio){
		this.codigoGrupoCobroServicio = codigoGrupoCobroServicio;
	}
	public String getDescripcionGrupoCobroServicio(){
		return descripcionGrupoCobroServicio;
	}
	
	public void setDescripcionGrupoCobroServicio(String descripcionGrupoCobroServicio){
		this.descripcionGrupoCobroServicio = descripcionGrupoCobroServicio;
	}
		

	
}
