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

import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoCobroServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.GrupoCobroServicioDAO;

public class GrupoCobroServicio  {
	
	private GrupoCobroServicioDAO GrupoCobroServicioDAO  = new GrupoCobroServicioDAO();
	private static Category cat = Category.getInstance(GrupoCobroServicio.class);
	
	/**
	 * Obtiene listado de Grupos de Cobro de Servicio. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Grupos de Cobro de Servicio. 
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public GrupoCobroServicioDTO[] getListadoGrupoCobroServicio() throws CustomerDomainException {
		cat.debug("getListadoGrupoCobroServicio():start");
		GrupoCobroServicioDTO[] resultado = GrupoCobroServicioDAO.getListadoGrupoCobroServicio();
		cat.debug("getListadoGrupoCobroServicio():end");
		return resultado;
	}
	
	/**
	 * Obtiene grupo servicio por defecto
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public GrupoCobroServicioDTO getGrupoCobroServicioDefault(Long entrada)throws CustomerDomainException
	{
		cat.debug("Inicio:getGrupoCobroServicioDefault()");
		GrupoCobroServicioDTO resultado = null;
		resultado = GrupoCobroServicioDAO.getGrupoCobroServicioDefault(entrada);
		cat.debug("Fin:getGrupoCobroServicioDefault()");
		return resultado;
	}//fin getCampanaVigente
	

}
