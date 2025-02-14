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

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;



public class ParamAbonBenefRegOSDTO extends OrdenServicioBaseDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private AbonadoBeneficiarioListDTO abonadosBenefiariosNuevos;
	private AbonadoBeneficiarioListDTO abonadosBenefiariosEliminar;
	public AbonadoBeneficiarioListDTO getAbonadosBenefiariosEliminar() {
		return abonadosBenefiariosEliminar;
	}
	public void setAbonadosBenefiariosEliminar(
			AbonadoBeneficiarioListDTO abonadosBenefiariosEliminar) {
		this.abonadosBenefiariosEliminar = abonadosBenefiariosEliminar;
	}
	public AbonadoBeneficiarioListDTO getAbonadosBenefiariosNuevos() {
		return abonadosBenefiariosNuevos;
	}
	public void setAbonadosBenefiariosNuevos(
			AbonadoBeneficiarioListDTO abonadosBenefiariosNuevos) {
		this.abonadosBenefiariosNuevos = abonadosBenefiariosNuevos;
	}

}
	
	