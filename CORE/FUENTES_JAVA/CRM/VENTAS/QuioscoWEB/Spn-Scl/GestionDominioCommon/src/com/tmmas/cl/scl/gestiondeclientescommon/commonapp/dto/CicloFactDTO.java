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
 * 07/08/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class CicloFactDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	//fa_ciclos
	private int codCiclo;   //COD_CICLO  NUMBER(2) 
	private String desCiclo;//DES_CICLO  VARCHAR2(40 BYTE) 
	private int digD;       //DIG_D      NUMBER(1) 
	private int digC;       //DIG_C      NUMBER(1)
	private int digSec;     //DIG_SEC    NUMBER(6)
	public int getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(int codCiclo) {
		this.codCiclo = codCiclo;
	}
	public String getDesCiclo() {
		return desCiclo;
	}
	public void setDesCiclo(String desCiclo) {
		this.desCiclo = desCiclo;
	}
	public int getDigC() {
		return digC;
	}
	public void setDigC(int digC) {
		this.digC = digC;
	}
	public int getDigD() {
		return digD;
	}
	public void setDigD(int digD) {
		this.digD = digD;
	}
	public int getDigSec() {
		return digSec;
	}
	public void setDigSec(int digSec) {
		this.digSec = digSec;
	}

}
