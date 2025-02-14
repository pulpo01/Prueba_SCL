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

import com.tmmas.cl.scl.commonbusinessentities.dto.RegionDireccionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.RegionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.RegionDAO;

public class Region{
	
	private RegionDAO regionDAO  = new RegionDAO();
	private static Category cat = Category.getInstance(Region.class);
	
	/**
	 * Obtiene listado de Regiones. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Regiones 
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegionDTO[] getListadoRegiones() throws CustomerDomainException {
		cat.debug("getListadoRegiones():start");
		RegionDTO[] resultado = regionDAO.getListadoRegiones();
		cat.debug("getListadoRegiones():end");
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
	public RegionDireccionDTO getListadoRegionesDireccion() throws CustomerDomainException {
		cat.debug("getListadoRegionesDireccion():start");
		RegionDireccionDTO resultado = regionDAO.getListadoRegionesDireccion();
		cat.debug("getListadoRegionesDireccion():end");
		return resultado;
	}

}
