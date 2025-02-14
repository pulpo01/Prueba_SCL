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
package com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dao.CiudadDAO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO;


public class CiudadBO  {
	
	private CiudadDAO ciudadDAO  = new CiudadDAO();
	private final Logger logger = Logger.getLogger(CiudadBO.class);
	
	/**
	 * Obtiene listado de Ciudades. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Ciudades
	 * 
	 * @param 
	 * @return resultado
	 * @throws GeneralException
	 */
	public CiudadDTO[] getListadoCiudades(ProvinciaDTO provincia) throws GeneralException {
		logger.debug("getListadoCiudades():start");
		CiudadDTO[] resultado = ciudadDAO.getListadoCiudades(provincia);
		logger.debug("getListadoCiudades():end");
		return resultado;
	}
	
	public CiudadDireccionDTO getListadoCiudades(CiudadDireccionDTO ciudadDireccionDTO) throws GeneralException {
		logger.debug("getListadoCiudades():start");
		CiudadDireccionDTO resultado = ciudadDAO.getListadoCiudades(ciudadDireccionDTO);
		logger.debug("getListadoCiudades():end");
		return resultado;
	}

}
