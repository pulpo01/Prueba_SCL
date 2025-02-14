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

import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.CausalDescuentoDAO;

public class CausalDescuento  {
	
	private CausalDescuentoDAO CausalDescuentoDAO  = new CausalDescuentoDAO();
	private static Category cat = Category.getInstance(CausalDescuento.class);
	
	/**
	 * Obtiene listado de Causales de Descuento. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Causales de Descuento 
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CausalDescuentoDTO[] getListadoCausalDescuento(Long codUso) 
		throws CustomerDomainException 
	{
		cat.debug("getListadoCausalDescuento():start");
		CausalDescuentoDTO[] resultado = CausalDescuentoDAO.getListadoCausalDescuento(codUso);
		cat.debug("getListadoCausalDescuento():end");
		return resultado;
	}
	
	public void actualizarDsctosManuales(CargoSolicitudDTO entrada)
		throws CustomerDomainException 
	{
		cat.debug("actualizarDsctosManuales():start");
		CausalDescuentoDAO.actualizarDsctosManuales(entrada);
		cat.debug("actualizarDsctosManuales():end");		
	}
	
}
