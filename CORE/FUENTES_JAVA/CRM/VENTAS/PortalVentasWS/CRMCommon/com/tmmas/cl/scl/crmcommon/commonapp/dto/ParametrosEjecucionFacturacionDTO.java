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

public class ParametrosEjecucionFacturacionDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String numeroVenta;
	private String numeroProcesoFacturacion;
	private String estadoDocumento;
	private String estadoProceso; //Resultado del proceso 0=Sin Procesar|1=Procesando|2=Terminado con Error|3=Terminado OK
	private String tipoFoliacion;
	private Long nroDiasVencimiento;
	
	
	public String getTipoFoliacion() {
		return tipoFoliacion;
	}
	public void setTipoFoliacion(String tipoFoliacion) {
		this.tipoFoliacion = tipoFoliacion;
	}
	public String getEstadoDocumento() {
		return estadoDocumento;
	}
	public void setEstadoDocumento(String estadoDocumento) {
		this.estadoDocumento = estadoDocumento;
	}
	public String getEstadoProceso() {
		return estadoProceso;
	}
	public void setEstadoProceso(String estadoProceso) {
		this.estadoProceso = estadoProceso;
	}
	public String getNumeroVenta() {
		return numeroVenta;
	}
	public String getNumeroProcesoFacturacion() {
		return numeroProcesoFacturacion;
	}
	public void setNumeroProcesoFacturacion(String numeroProcesoFacturacion) {
		this.numeroProcesoFacturacion = numeroProcesoFacturacion;
	}
	public void setNumeroVenta(String numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public Long getNroDiasVencimiento() {
		return nroDiasVencimiento;
	}
	public void setNroDiasVencimiento(Long nroDiasVencimiento) {
		this.nroDiasVencimiento = nroDiasVencimiento;
	}

}
