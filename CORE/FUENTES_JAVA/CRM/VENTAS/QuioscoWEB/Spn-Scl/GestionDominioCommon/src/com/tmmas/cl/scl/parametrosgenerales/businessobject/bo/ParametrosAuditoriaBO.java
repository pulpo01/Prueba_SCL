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
 * 05/06/2009     Sergio Munoz      					Versión Inicial
 */
package com.tmmas.cl.scl.parametrosgenerales.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dao.ParametrosAuditoriaDAO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.EstadoAsincDTO;

public class ParametrosAuditoriaBO {

	private ParametrosAuditoriaDAO parametrosAuditoriaDAO  = new ParametrosAuditoriaDAO();
	private static Category cat = Category.getInstance(DatosGeneralesBO.class);

	/**
	 * TODO modificar Comentario, explicando la funcionalidad
	 * @param estadoAsinc
	 * @throws GeneralException
	 */
	
	public void grabaEstadoAsinc(EstadoAsincDTO estadoAsinc) 
	throws GeneralException {
		cat.debug("Inicio:grabaEstadoAsinc()");
		parametrosAuditoriaDAO.grabaEstadoAsinc(estadoAsinc);
		cat.debug("Fin:grabaEstadoAsinc()");
	}
	
	public void grabaEstadoAsincSinSPNID(EstadoAsincDTO estadoAsinc) 
	throws GeneralException {
		cat.debug("Inicio:grabaEstadoAsinc()");
		parametrosAuditoriaDAO.grabaEstadoAsincSinSPNID(estadoAsinc);
		cat.debug("Fin:grabaEstadoAsinc()");
	}	
}//fin CLASS ParametrosAuditoriaBO