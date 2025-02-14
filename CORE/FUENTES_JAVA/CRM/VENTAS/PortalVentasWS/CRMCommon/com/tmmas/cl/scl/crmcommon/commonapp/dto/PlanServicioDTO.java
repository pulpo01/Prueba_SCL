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

public class PlanServicioDTO  implements Serializable{
	
	
	private static final long serialVersionUID = 1L;
	private String codigoPlanServicio;
	private String descripcionPlanServicio;
	
	
	private String codPlanTarif;
	private String codTecnologia;
	
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getCodigoPlanServicio(){
		return codigoPlanServicio;
	}
	public void setCodigoPlanServicio(String codigoPlanServicio){
		this.codigoPlanServicio = codigoPlanServicio;
	}
	public String getDescripcionPlanServicio(){
		return descripcionPlanServicio;
	}
	
	public void setDescripcionPlanServicio(String descripcionPlanServicio){
		this.descripcionPlanServicio = descripcionPlanServicio;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	
		

	
}
