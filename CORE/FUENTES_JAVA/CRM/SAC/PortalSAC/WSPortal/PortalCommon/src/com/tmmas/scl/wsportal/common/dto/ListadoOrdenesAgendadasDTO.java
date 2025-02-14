/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class ListadoOrdenesAgendadasDTO implements Serializable{
	/**
	 * 
	 */
	
	/*
	 * Modificacion
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_005
	 * Caso de uso: CU-009 Obtener OOSS Agendadas 
	 * Developer: Jorge González N.
	 * Fecha: 13/07/2010
	 * 
	 */	
	
	private static final long serialVersionUID = 1L;
	
	private OOSSAgendadaDTO [] arrayOOSS;
	private String codError;
	private String desError;
	
	public OOSSAgendadaDTO[] getArrayOOSS() {
		return arrayOOSS;
	}
	public void setArrayOOSS(OOSSAgendadaDTO[] arrayOOSS) {
		this.arrayOOSS = arrayOOSS;
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getDesError() {
		return desError;
	}
	public void setDesError(String desError) {
		this.desError = desError;
	}
}
