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
 * 10/07/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class PresupuestoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private long numProceso;
	private long numVenta;
	private Date fechaVcto;
	private String tipoFoliacion;
	private DetallePresupuestoDTO[] detalle;
	
	public DetallePresupuestoDTO[] getDetalle() {
		return detalle;
	}
	public void setDetalle(DetallePresupuestoDTO[] detalle) {
		this.detalle = detalle;
	}
	public String getTipoFoliacion() {
		return tipoFoliacion;
	}
	public void setTipoFoliacion(String tipoFoliacion) {
		this.tipoFoliacion = tipoFoliacion;
	}
	public long getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(long numProceso) {
		this.numProceso = numProceso;
	}
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
	public Date getFechaVcto() {
		return fechaVcto;
	}
	public void setFechaVcto(Date fechaVcto) {
		this.fechaVcto = fechaVcto;
	}
}
