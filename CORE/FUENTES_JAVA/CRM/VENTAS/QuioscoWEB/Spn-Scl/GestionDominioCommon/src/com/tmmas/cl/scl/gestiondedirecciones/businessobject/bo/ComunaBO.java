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
 * 20/06/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dao.ComunaDAO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaSPNDTO;


public class ComunaBO  {
	
	private ComunaDAO comunaDAO  = new ComunaDAO();
	
	private final Logger logger = Logger.getLogger(ComunaBO.class);
	
	/**
	 * Obtiene listado de comunas. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de comunas
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ComunaDireccionDTO getListadoComunas(ComunaDireccionDTO comunaDireccionDTO) throws GeneralException {
		logger.debug("getListadoCiudades():start");
		ComunaDireccionDTO resultado = comunaDAO.getListadoComunas(comunaDireccionDTO);
		logger.debug("getListadoCiudades():end");
		return resultado;
	}
	
	public ComunaSPNDTO[] getListadoComunas(CiudadDTO ciudad) throws GeneralException {
		logger.debug("getListadoCiudades():start");
		ComunaSPNDTO[] resultado = comunaDAO.getListadoComunas(ciudad);
		logger.debug("getListadoCiudades():end");
		return resultado;
	}

}
