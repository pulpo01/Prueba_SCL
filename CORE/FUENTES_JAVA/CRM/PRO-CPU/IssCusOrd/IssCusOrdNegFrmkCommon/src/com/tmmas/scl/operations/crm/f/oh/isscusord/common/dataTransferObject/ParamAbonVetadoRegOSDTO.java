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
 * 29/10/2007     			 Raúl Lozano              		Versión Inicial
 */
package com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoVetadoListDTO;



public class ParamAbonVetadoRegOSDTO extends OrdenServicioBaseDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private AbonadoVetadoListDTO agregarAbonados;
	private AbonadoVetadoListDTO actualizarAbonados;
	
	public AbonadoVetadoListDTO getActualizarAbonados() {
		return actualizarAbonados;
	}
	public void setActualizarAbonados(AbonadoVetadoListDTO actualizarAbonados) {
		this.actualizarAbonados = actualizarAbonados;
	}
	public AbonadoVetadoListDTO getAgregarAbonados() {
		return agregarAbonados;
	}
	public void setAgregarAbonados(AbonadoVetadoListDTO agregarAbonados) {
		this.agregarAbonados = agregarAbonados;
	}
	
}
	
	