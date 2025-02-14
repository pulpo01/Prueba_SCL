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
 * 16/03/2007     H&eacute;ctor Hermosilla				Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class PlanTarifarioDistListDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private boolean distribucionCompleta = false;
	private long numVenta;
	private PlanTarifarioDistDTO[] planesTarifarios;
	
	public PlanTarifarioDistDTO[] getPlanesTarifarios() {
		return planesTarifarios;
	}

	public void setPlanesTarifarios(PlanTarifarioDistDTO[] planesTarifarios) {
		this.planesTarifarios = planesTarifarios;
	}

	public boolean isDistribucionCompleta() {
		return distribucionCompleta;
	}

	public void setDistribucionCompleta(boolean distribucionCompleta) {
		this.distribucionCompleta = distribucionCompleta;
	}

	public long getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}

	
}
