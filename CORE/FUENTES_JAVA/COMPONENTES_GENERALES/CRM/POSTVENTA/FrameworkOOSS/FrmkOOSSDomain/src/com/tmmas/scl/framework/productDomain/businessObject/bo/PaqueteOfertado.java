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
 * 18/07/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PaqueteOfertadoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ProductoOfertadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ProductoOfertadoIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.PaqueteOfertadoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.PaqueteOfertadoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;

public class PaqueteOfertado implements PaqueteOfertadoIT
{
	PaqueteOfertadoDAOIT paqueteOfertadoDAO = new PaqueteOfertadoDAO();
	ProductoOfertadoBOFactoryIT prodOferFactory=new ProductoOfertadoBOFactory();
	ProductoOfertadoIT prodOferBO=prodOferFactory.getBusinessObject1();

	private final Logger logger = Logger.getLogger(PaqueteOfertado.class);
	private Global global = Global.getInstance();
		

	public ProductoOfertadoListDTO obtenerProductosOfertablesPorPaquete(PaqueteDTO paquete) throws ProductOfferingException {
		ProductoOfertadoListDTO resultado = new ProductoOfertadoListDTO();
		logger.debug("Inicio:obtenerProductosOfertablesPorPaquete()");
		if(!"".equals(paquete.getCodProdPadre()))
		{
			resultado = paqueteOfertadoDAO.obtenerProductosOfertablesPorPaquete(paquete);
			resultado = prodOferBO.obtenerDetalleProductos(resultado);
		}
		else
		{
			resultado.setProductoList(new ProductoOfertadoDTO[0]);
		}
		logger.debug("Fin:obtenerProductosOfertablesPorPaquete()");
		return resultado;
	}
	
}
