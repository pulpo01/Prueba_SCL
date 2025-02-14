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
 * 08/02/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class EstadoProcesoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoProceso;
	private String progreso;
	private String indiceSubProceso;
	private String totalSubProceso;
	private String codigoError;
	private String descripcionError;
	public String getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(String codigoError) {
		this.codigoError = codigoError;
	}
	public String getCodigoProceso() {
		return codigoProceso;
	}
	public void setCodigoProceso(String codigoProceso) {
		this.codigoProceso = codigoProceso;
	}
	public String getDescripcionError() {
		return descripcionError;
	}
	public void setDescripcionError(String descripcionError) {
		this.descripcionError = descripcionError;
	}
	public String getIndiceSubProceso() {
		return indiceSubProceso;
	}
	public void setIndiceSubProceso(String indiceSubProceso) {
		this.indiceSubProceso = indiceSubProceso;
	}
	public String getProgreso() {
		return progreso;
	}
	public void setProgreso(String progreso) {
		this.progreso = progreso;
	}
	public String getTotalSubProceso() {
		return totalSubProceso;
	}
	public void setTotalSubProceso(String totalSubProceso) {
		this.totalSubProceso = totalSubProceso;
	}

}
