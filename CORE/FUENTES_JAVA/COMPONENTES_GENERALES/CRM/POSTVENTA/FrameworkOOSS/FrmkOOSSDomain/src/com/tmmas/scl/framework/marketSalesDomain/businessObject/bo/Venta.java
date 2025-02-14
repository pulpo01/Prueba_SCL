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
 * 03-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.marketSalesDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.businessObject.bo.interfaces.VentaIT;
import com.tmmas.scl.framework.marketSalesDomain.businessObject.dao.VentaDAO;
import com.tmmas.scl.framework.marketSalesDomain.businessObject.dao.interfaces.VentaDAOIT;
import com.tmmas.scl.framework.marketSalesDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.marketSalesDomain.exception.ContactLeadProspectException;

public class Venta implements VentaIT
{
	private VentaDAOIT ventaDAO = new VentaDAO();
	private final Logger logger = Logger.getLogger(Venta.class);
	private Global global = Global.getInstance();

	public RetornoDTO actualizarEstado(VentaDTO venta) throws ContactLeadProspectException 
	{
		RetornoDTO retorno = null;
		try {
			logger.debug("actualizarEstado():start");
			retorno = ventaDAO.actualizarEstado(venta);
			logger.debug("actualizarEstado():end");
		} catch (ContactLeadProspectException e) {
			logger.debug("ContactLeadProspectException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ContactLeadProspectException(e);
		}		
		return retorno;	
	}
}
