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
 * 22/03/2007     Héctor Hermosilla     					Versión Inicial
 */

package com.tmmas.cl.scl.resourcedomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.ResourceDomainException;
import com.tmmas.cl.scl.resourcedomain.businessobject.dao.CentralDAO;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CentralDTO;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CeldaDTO;

public class Central {
	private CentralDAO centralDAO  = new CentralDAO();
	private static Category cat = Category.getInstance(Central.class);

	
	/**
	 * Obtiene listado de centrales 
	 * @param entrada
	 * @return resultado
	 * @throws ResourceDomainException
	 */	
	public CentralDTO[] getListadoCentrales(CeldaDTO entrada)
		throws ResourceDomainException
	{
		CentralDTO[] resultado = null;
		cat.debug("Inicio:getListadoCentrales()");
		resultado = centralDAO.getListadoCentrales(entrada); 
		cat.debug("Fin:getListadoCentrales()");
		return resultado;
	}//getListadoCentrales

	/**
	 * Obtiene datos de la central 
	 * @param entrada
	 * @return resultado
	 * @throws ResourceDomainException
	 */
	public CentralDTO getCentral(CentralDTO entrada)
		throws ResourceDomainException
	{
		CentralDTO resultado = null;
		cat.debug("Inicio:getCentral()");
		resultado = centralDAO.getCentral(entrada); 
		cat.debug("Fin:getCentral()");
		return resultado;
	}//fin getCentral
	
	/**
	 * Obtiene listado de centrales 
	 * @param entrada
	 * @return resultado
	 * @throws ResourceDomainException
	 */	
	public CentralDTO[] getDatosCentral(CentralDTO entrada)
		throws ResourceDomainException
	{
		CentralDTO[] resultado = null;
		cat.debug("Inicio:getListadoCentral()");
		resultado = centralDAO.getDatosCentral(entrada); 
		cat.debug("Fin:getListadoCentral()");
		return resultado;
	}//fin getCentral
	
	public void validarActuacion(CentralDTO central)
		throws ResourceDomainException
	{
		cat.debug("Inicio:validarActuacion()");
		centralDAO.validarActuacion(central); 
		cat.debug("Fin:validarActuacion()");		
	}//fin validarActuacion

}//fin Central
