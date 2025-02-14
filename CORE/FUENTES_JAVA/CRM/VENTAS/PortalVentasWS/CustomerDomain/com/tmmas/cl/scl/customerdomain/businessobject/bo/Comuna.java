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
package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.dto.ComunaDireccionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.ComunaDAO;

public class Comuna  {
	
	private ComunaDAO comunaDAO  = new ComunaDAO();
	
	private static Category cat = Category.getInstance(Comuna.class);
	
	/**
	 * Obtiene listado de comunas. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de comunas
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ComunaDireccionDTO getListadoComunas(ComunaDireccionDTO comunaDireccionDTO) throws CustomerDomainException {
		cat.debug("getListadoCiudades():start");
		ComunaDireccionDTO resultado = comunaDAO.getListadoComunas(comunaDireccionDTO);
		cat.debug("getListadoCiudades():end");
		return resultado;
	}

}
