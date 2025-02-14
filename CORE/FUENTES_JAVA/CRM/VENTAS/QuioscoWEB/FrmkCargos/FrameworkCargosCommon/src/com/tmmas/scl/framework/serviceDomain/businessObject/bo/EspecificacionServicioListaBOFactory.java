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
 * 11-07-2007     			 Esteban Conejeros              		Versi�n Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.bo;

import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioListaBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioListaIT;

public class EspecificacionServicioListaBOFactory implements EspecificacionServicioListaBOFactoryIT
{

	public EspecificacionServicioListaIT getBusinessObject() 
	{		
		return new EspecificacionServicioLista();
	}
	
}
