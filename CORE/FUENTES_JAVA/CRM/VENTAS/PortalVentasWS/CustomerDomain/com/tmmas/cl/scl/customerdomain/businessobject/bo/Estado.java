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

import com.tmmas.cl.scl.commonbusinessentities.dto.EstadoDireccionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.EstadoDAO;

public class Estado  {
	
	private EstadoDAO estadoDAO  = new EstadoDAO();
	private static Category cat = Category.getInstance(Estado.class);
	
	/**
	 * Obtiene listado de Estados. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de estados 
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public EstadoDireccionDTO getListadoEstados() throws CustomerDomainException {
		cat.debug("getListadoEstados():start");
		EstadoDireccionDTO resultado = estadoDAO.getListadoEstados();
		cat.debug("getListadoEstados():end");
		return resultado;
	}

}
