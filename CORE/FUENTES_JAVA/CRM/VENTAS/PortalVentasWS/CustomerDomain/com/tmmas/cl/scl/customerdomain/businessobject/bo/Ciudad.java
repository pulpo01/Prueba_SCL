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
 * 06/02/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.dto.CiudadDireccionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CiudadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ProvinciaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.CiudadDAO;

public class Ciudad  {
	
	private CiudadDAO ciudadDAO  = new CiudadDAO();
	private static Category cat = Category.getInstance(Ciudad.class);
	
	/**
	 * Obtiene listado de Ciudades. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Ciudades
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CiudadDTO[] getListadoCiudades(ProvinciaDTO provincia) throws CustomerDomainException {
		cat.debug("getListadoCiudades():start");
		CiudadDTO[] resultado = ciudadDAO.getListadoCiudades(provincia);
		cat.debug("getListadoCiudades():end");
		return resultado;
	}
	
	public CiudadDireccionDTO getListadoCiudades(CiudadDireccionDTO ciudadDireccionDTO) throws CustomerDomainException {
		cat.debug("getListadoCiudades():start");
		CiudadDireccionDTO resultado = ciudadDAO.getListadoCiudades(ciudadDireccionDTO);
		cat.debug("getListadoCiudades():end");
		return resultado;
	}

}
