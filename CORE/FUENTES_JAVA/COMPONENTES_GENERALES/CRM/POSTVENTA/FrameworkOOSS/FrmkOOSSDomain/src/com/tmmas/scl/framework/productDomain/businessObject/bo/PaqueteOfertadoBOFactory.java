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
 * 18/07/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PaqueteOfertadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PaqueteOfertadoIT;

public class PaqueteOfertadoBOFactory implements PaqueteOfertadoBOFactoryIT{

	public PaqueteOfertadoIT getBusinessObject1() {		
		return new PaqueteOfertado();
	}
	
}
