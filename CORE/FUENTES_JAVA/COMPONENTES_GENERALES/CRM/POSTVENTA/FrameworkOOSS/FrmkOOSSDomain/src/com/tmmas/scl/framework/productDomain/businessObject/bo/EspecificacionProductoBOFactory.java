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
 * 11-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.EspecificacionProductoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.EspecificacionProductoIT;

public class EspecificacionProductoBOFactory implements EspecificacionProductoBOFactoryIT
{

	public EspecificacionProductoIT getBusinessObject() {		
		return new EspecificacionProducto();
	}
	
}
