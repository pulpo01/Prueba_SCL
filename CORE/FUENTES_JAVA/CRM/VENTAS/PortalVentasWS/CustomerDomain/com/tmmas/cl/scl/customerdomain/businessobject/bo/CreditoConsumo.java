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

import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoConsumoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.CreditoConsumoDAO;

public class CreditoConsumo  {
	
	private CreditoConsumoDAO CreditoConsumoDAO  = new CreditoConsumoDAO();
	private static Category cat = Category.getInstance(CreditoConsumo.class);
	
	/**
	 * Obtiene listado de Creditos de Consumo. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Creditos de Consumo.
	 * 
	 * @param 
	 * @return resultado
	 * @throws VentasException
	 */
	public CreditoConsumoDTO[] getListadoCreditoConsumo(CreditoConsumoDTO creditoConsumoDTO) throws CustomerDomainException {
		cat.debug("getListadoCreditoConsumo():start");
		CreditoConsumoDTO[] resultado = CreditoConsumoDAO.getListadoCreditoConsumo(creditoConsumoDTO);
		cat.debug("getListadoCreditoConsumo():end");
		return resultado;
	}
	

}
