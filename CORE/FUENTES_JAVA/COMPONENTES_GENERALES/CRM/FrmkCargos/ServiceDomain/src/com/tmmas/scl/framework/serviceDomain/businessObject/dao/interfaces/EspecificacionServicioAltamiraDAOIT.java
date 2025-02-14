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
 * 04-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioAltamiraListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.FreqAltamiraListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public interface EspecificacionServicioAltamiraDAOIT 
{
	public RetornoDTO crear(FreqAltamiraListDTO listFrecAlt) throws ServiceSpecEntitiesException;
	public RetornoDTO notificar(VentaDTO venta) throws ServiceSpecEntitiesException;
	public EspecServicioAltamiraListDTO obtenerEspecServicioAltamira(EspecServicioClienteListDTO espSerCliList) throws ServiceSpecEntitiesException;
}
