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
 * 11-07-2007     			 Esteban Conejeros              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CategoriaPlanBasicoIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.CategoriaPlanBasicoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.CategoriaPlanBasicoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CategoriaListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;

public class CategoriaPlanBasico implements CategoriaPlanBasicoIT
{	
	private CategoriaPlanBasicoDAOIT catPlanBasDAO=new CategoriaPlanBasicoDAO();
	
	private final Logger logger = Logger.getLogger(EspecificacionProducto.class);
	private Global global = Global.getInstance();
	
	public CategoriaListDTO obtenerCategoriaPlanBasico(PlanTarifarioDTO planTarif) throws ProductOfferingException{
		CategoriaListDTO retorno = null;
		
			logger.debug("obtenerCategoriaPlanBasico():start");
			retorno= catPlanBasDAO.obtenerCategoriaPlanBasico(planTarif);
			logger.debug("obtenerCategoriaPlanBasico():end");
		
		return retorno;	
	}
}
