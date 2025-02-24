/**
 * Copyright � 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 19/07/2007     			Ra�l Lozano              		Versi�n Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroPreLiquidacionBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroPreLiquidacionIT;

public class RegistroPreLiquidacionBOFactory implements RegistroPreLiquidacionBOFactoryIT {

	public RegistroPreLiquidacionIT getBusinessObject1() {
		return new RegistroPreliquidacion();
	}

}
