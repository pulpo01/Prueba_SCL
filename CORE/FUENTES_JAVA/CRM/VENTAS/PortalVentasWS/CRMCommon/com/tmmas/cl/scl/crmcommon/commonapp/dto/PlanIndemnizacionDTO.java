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
 * 09/01/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class PlanIndemnizacionDTO  implements Serializable{
	
	
	private static final long serialVersionUID = 1L;
	private String codigoPlanIndemnizacion;
	private String descripcionPlanIndemnizacion;
	
	
	public String getCodigoPlanIndemnizacion(){
		return codigoPlanIndemnizacion;
	}
	public void setCodigoPlanIndemnizacion(String codigoPlanIndemnizacion){
		this.codigoPlanIndemnizacion = codigoPlanIndemnizacion;
	}
	public String getDescripcionPlanIndemnizacion(){
		return descripcionPlanIndemnizacion;
	}
	
	public void setDescripcionPlanIndemnizacion(String descripcionPlanIndemnizacion){
		this.descripcionPlanIndemnizacion = descripcionPlanIndemnizacion;
	}
		

	
}

