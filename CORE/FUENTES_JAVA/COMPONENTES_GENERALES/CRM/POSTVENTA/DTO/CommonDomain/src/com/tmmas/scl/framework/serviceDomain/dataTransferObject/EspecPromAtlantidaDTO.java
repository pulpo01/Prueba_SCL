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

public class EspecPromAtlantidaDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idCodPlanAtl; 
	private String nombrePlanAtl;
	private String descripcionPlanAtl;
	private String CodAtl;
	private String tipoPlataforma;
	
	/**
	 * 
	A.COD_PLAN_ATL, A.NOM_PLAN_ATL, A.DES_PLAN_ATL, A.COD_ATLANTIDA, A.IND_TIPO_PLATAFORMA
	 * 
	 */
	
	public Object[] toStruct()
	{
		Object[] obj={idCodPlanAtl,nombrePlanAtl,descripcionPlanAtl,CodAtl,tipoPlataforma};
		return obj;
	}

	public String getCodAtl() {
		return CodAtl;
	}

	public void setCodAtl(String codAtl) {
		CodAtl = codAtl;
	}

	public String getDescripcionPlanAtl() {
		return descripcionPlanAtl;
	}

	public void setDescripcionPlanAtl(String descripcionPlanAtl) {
		this.descripcionPlanAtl = descripcionPlanAtl;
	}

	public String getIdCodPlanAtl() {
		return idCodPlanAtl;
	}

	public void setIdCodPlanAtl(String idCodPlanAtl) {
		this.idCodPlanAtl = idCodPlanAtl;
	}

	public String getNombrePlanAtl() {
		return nombrePlanAtl;
	}

	public void setNombrePlanAtl(String nombrePlanAtl) {
		this.nombrePlanAtl = nombrePlanAtl;
	}

	public String getTipoPlataforma() {
		return tipoPlataforma;
	}

	public void setTipoPlataforma(String tipoPlataforma) {
		this.tipoPlataforma = tipoPlataforma;
	}
	

	
	
}
