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
 * 16/01/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PlanServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.PlanServicioDAO;

public class PlanServicio  {
	
	private PlanServicioDAO planServicioDAO  = new PlanServicioDAO();
	private static Category cat = Category.getInstance(PlanServicio.class);
	
	/**
	 * Obtiene listado de Planes de Servicios. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Planes de Servicios. 
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public PlanServicioDTO[] getListadoPlanServicio(PlanServicioDTO entrada) throws CustomerDomainException {
		cat.debug("getListadoPlanServicio():start");
		PlanServicioDTO[] resultado = planServicioDAO.getListadoPlanServicio(entrada);
		cat.debug("getListadoPlanServicio():end");
		return resultado;
	}
	

}
