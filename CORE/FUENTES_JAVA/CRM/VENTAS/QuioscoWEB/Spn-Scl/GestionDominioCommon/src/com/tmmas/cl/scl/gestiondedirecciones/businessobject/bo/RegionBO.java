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
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dao.RegionDAO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDireccionDTO;


public class RegionBO{
	
	private RegionDAO regionDAO  = new RegionDAO();
	private final Logger logger = Logger.getLogger(RegionBO.class);
	
	/**
	 * Obtiene listado de Regiones. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Regiones 
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegionDTO[] getListadoRegiones() throws GeneralException {
		logger.debug("getListadoRegiones():start");
		RegionDTO[] resultado = regionDAO.getListadoRegiones();
		logger.debug("getListadoRegiones():end");
		return resultado;
	}
	
	/**
	 * Obtiene listado de Regiones de tipo objeto Direccion (Alta cliente).
	 * No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Regiones 
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegionDireccionDTO getListadoRegionesDireccion() throws GeneralException {
		logger.debug("getListadoRegionesDireccion():start");
		RegionDireccionDTO resultado = regionDAO.getListadoRegionesDireccion();
		logger.debug("getListadoRegionesDireccion():end");
		return resultado;
	}

}
