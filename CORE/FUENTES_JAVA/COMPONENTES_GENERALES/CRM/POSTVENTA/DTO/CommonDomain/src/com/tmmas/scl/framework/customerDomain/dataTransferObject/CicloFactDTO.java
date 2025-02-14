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
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class CicloFactDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int codCiclo;
	private String fecCicloFecDesdeLlam;
	private int perCicloCodCiclFact;
	private long numAbonado;
	
	public int getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(int codCiclo) {
		this.codCiclo = codCiclo;
	}
	public String getFecCicloFecDesdeLlam() {
		return fecCicloFecDesdeLlam;
	}
	public void setFecCicloFecDesdeLlam(String fecCicloFecDesdeLlam) {
		this.fecCicloFecDesdeLlam = fecCicloFecDesdeLlam;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public int getPerCicloCodCiclFact() {
		return perCicloCodCiclFact;
	}
	public void setPerCicloCodCiclFact(int perCicloCodCiclFact) {
		this.perCicloCodCiclFact = perCicloCodCiclFact;
	}
	
}
