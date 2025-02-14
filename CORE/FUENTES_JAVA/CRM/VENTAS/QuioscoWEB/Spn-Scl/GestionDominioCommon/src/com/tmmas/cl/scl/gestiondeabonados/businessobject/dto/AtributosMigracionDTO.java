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
 * 20/04/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;



public class AtributosMigracionDTO extends AtributosCargoDTO{

	private static final long serialVersionUID = 1L;
	private String ind_paquete;
	private String ind_cuota;
	private String ind_equipo;
	private String cod_tecnologia;

	public String getCod_tecnologia() {
		return cod_tecnologia;
	}
	public void setCod_tecnologia(String cod_tecnologia) {
		this.cod_tecnologia = cod_tecnologia;
	}
	public String getInd_cuota() {
		return ind_cuota;
	}
	public void setInd_cuota(String ind_cuota) {
		this.ind_cuota = ind_cuota;
	}
	public String getInd_equipo() {
		return ind_equipo;
	}
	public void setInd_equipo(String ind_equipo) {
		this.ind_equipo = ind_equipo;
	}
	public String getInd_paquete() {
		return ind_paquete;
	}
	public void setInd_paquete(String ind_paqute) {
		this.ind_paquete = ind_paqute;
	}
	
	

}
