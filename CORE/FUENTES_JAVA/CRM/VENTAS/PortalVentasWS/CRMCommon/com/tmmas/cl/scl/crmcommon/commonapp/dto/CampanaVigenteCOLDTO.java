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

public class CampanaVigenteCOLDTO extends CampanaVigenteDTO  implements Serializable{	
	
	private static final long serialVersionUID = 1L;
	
	private String codPlantarif;
	private String tipEntidad;
	private String ind_default;
	private String formato_fecha;
	
	public String getCodPlantarif() {
		return codPlantarif;
	}
	public void setCodPlantarif(String codPlantarif) {
		this.codPlantarif = codPlantarif;
	}
	public String getFormato_fecha() {
		return formato_fecha;
	}
	public void setFormato_fecha(String formato_fecha) {
		this.formato_fecha = formato_fecha;
	}
	public String getInd_default() {
		return ind_default;
	}
	public void setInd_default(String ind_default) {
		this.ind_default = ind_default;
	}
	public String getTipEntidad() {
		return tipEntidad;
	}
	public void setTipEntidad(String tipEntidad) {
		this.tipEntidad = tipEntidad;
	}
	
}
