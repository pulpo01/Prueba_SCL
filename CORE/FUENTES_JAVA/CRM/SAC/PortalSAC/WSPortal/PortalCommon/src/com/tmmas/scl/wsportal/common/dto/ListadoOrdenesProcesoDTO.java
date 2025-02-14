package com.tmmas.scl.wsportal.common.dto;

import java.io.Serializable;

public class ListadoOrdenesProcesoDTO implements Serializable{
	/**
	 * 
	 */
	
	/*
	 * Modificacion
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evoluci�n Gestor Posventa MIX-10008
	 * Requisito: RSis_009
	 * Caso de uso: CU-016 Desplegar OOSS en ejecuci�n 
	 * Developer: Jorge Gonz�lez N.
	 * Fecha: 13/07/2010
	 * 
	 */		
	
	private static final long serialVersionUID = 1L;
	
	private OOSSProcesoDTO[] arrayOOSS;
	private String codError;
	private String desError;
	
	public OOSSProcesoDTO[] getArrayOOSS() {
		return arrayOOSS;
	}
	public void setArrayOOSS(OOSSProcesoDTO[] arrayOOSS) {
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
