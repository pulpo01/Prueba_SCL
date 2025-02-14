/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 10-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.CategoriasNumeroDestinoIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.CategoriasNumeroDestinoDAO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.CategoriasNumeroDestinoDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public class CategoriasNumeroDestino implements CategoriasNumeroDestinoIT
{
	private final Logger logger = Logger.getLogger(CategoriasNumeroDestino.class);
	private Global global = Global.getInstance();
	private CategoriasNumeroDestinoDAOIT catalogoDAO=new CategoriasNumeroDestinoDAO();
	
	public NumeroDTO obtenerTipoNumero(NumeroDTO numero) throws ServiceSpecEntitiesException 
	{	
		NumeroDTO resultado=new NumeroDTO();
		logger.debug("Inicio:obtenerTipoNumero()");
		resultado = catalogoDAO.obtenerTipoNumero(numero);
		logger.debug("Fin:obtenerTipoNumero()");
		return resultado;
	}

}
