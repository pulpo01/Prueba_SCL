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
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dao.ProvinciaDAO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO;


public class ProvinciaBO{
	
	private ProvinciaDAO provinciaDAO  = new ProvinciaDAO();
	private final Logger logger = Logger.getLogger(ProvinciaBO.class);
	
	/**
	 * Obtiene listado de Provincias. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Provincias 
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ProvinciaDTO[] getListadoProvincias(RegionDTO region) throws GeneralException {
		logger.debug("getListadoProvincias():start");
		ProvinciaDTO[] resultado = provinciaDAO.getListadoProvincias(region);
		logger.debug("getListadoProvincias():end");
		return resultado;
	}
	
	public ProvinciaDireccionDTO getListadoProvincias(ProvinciaDireccionDTO provinciaDireccionDTO) throws GeneralException {
		logger.debug("getListadoProvincias():start");
		ProvinciaDireccionDTO resultado = provinciaDAO.getListadoProvincias(provinciaDireccionDTO);
		logger.debug("getListadoProvincias():end");
		return resultado;
	}

}
