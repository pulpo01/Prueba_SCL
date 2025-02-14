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
 * 05/05/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class BitacoraDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private long numeroProcesosErrados;
	private long numeroProcesosEjecutadosExitosos;
	private ProcesoDTO[] procesos;
	public long getNumeroProcesosEjecutadosExitosos() {
		return numeroProcesosEjecutadosExitosos;
	}
	public void setNumeroProcesosEjecutadosExitosos(
			long numeroProcesosEjecutadosExitosos) {
		this.numeroProcesosEjecutadosExitosos = numeroProcesosEjecutadosExitosos;
	}
	public long getNumeroProcesosErrados() {
		return numeroProcesosErrados;
	}
	public void setNumeroProcesosErrados(long numeroProcesosErrados) {
		this.numeroProcesosErrados = numeroProcesosErrados;
	}
	public ProcesoDTO[] getProcesos() {
		return procesos;
	}
	public void setProcesos(ProcesoDTO[] procesos) {
		this.procesos = procesos;
	}
	

}
