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
 * 06/09/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.helper;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.ProductoContratadoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.ProductoContratadoDAOIT;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class Secuenciador 
{
	private static Secuenciador  instance=null;
	private ProductoContratadoDAOIT productoDAO = new ProductoContratadoDAO();
	
	public static Secuenciador getInstance()
	{
		if(instance==null)
			instance=new Secuenciador();
		
		return instance;			
	}
	
	private Secuenciador()
	{
		
	}
	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws ProductException
	{
		SecuenciaDTO respuesta = null;
		try {			
			respuesta = productoDAO.obtenerSecuencia(secuencia);			
		} catch (Exception e) {			
			throw new ProductException(e);
		}		
		return respuesta;			
	}
	
}
