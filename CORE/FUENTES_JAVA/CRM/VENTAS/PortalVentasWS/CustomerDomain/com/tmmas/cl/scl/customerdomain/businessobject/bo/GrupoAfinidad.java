/**
 * Copyright � 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 16/01/2007     H�ctor Hermosilla      					Versi�n Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosComercialesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoAfinidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.GrupoAfinidadDAO;

public class GrupoAfinidad  {
	
	private GrupoAfinidadDAO grupoAfinidadDAO  = new GrupoAfinidadDAO();
	private static Category cat = Category.getInstance(GrupoAfinidad.class);
	
	/**
	 * Obtiene listado de Grupos de Afinidad. No se define c�digo y descripci�n 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Grupos de Afinidad. 
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public GrupoAfinidadDTO[] getListadoGrupoAfinidad(DatosComercialesDTO datos) throws CustomerDomainException {
		cat.debug("getListadoGrupoAfinidad():start");
		GrupoAfinidadDTO[] resultado = grupoAfinidadDAO.getListadoGrupoAfinidad(datos);
		cat.debug("getListadoGrupoAfinidad():end");
		return resultado;
	}
	

}
