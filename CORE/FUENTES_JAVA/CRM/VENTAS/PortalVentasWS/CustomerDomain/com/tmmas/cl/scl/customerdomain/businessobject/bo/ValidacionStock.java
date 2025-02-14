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
 * 04/04/2007     Nicolás Contreras      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.ValidacionStockDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ParametrosValidacionStockDTO;


public class ValidacionStock   
{
	private ValidacionStockDAO validacionStockDAO  = new ValidacionStockDAO();
	private static Category cat = Category.getInstance(ValidacionStockDAO.class);	
	
	/**
	 * Realiza Validacion de tipo de Stock segun el canal del Vendedor, como parametros se envia el canal del vendedor y la serie, 
	 * esta puede ser Simcard o equipo   
	 * En caso de no que el vendedor no pueda vender con este tipo de stock se indicará con error y no se continuará con la venta.  
	 * 
	 * @param 
	 * @return resultado
	 * @throws FrameworkValidacionException
	 */

	public ParametrosValidacionStockDTO ValidaStock(ParametrosValidacionStockDTO entrada) 
		throws CustomerDomainException
	{		   
		cat.debug("Inicio:ValidacionStockDAO()");
		ParametrosValidacionStockDTO resultado=null;		  
		cat.debug("Restringe Stock :Llamado a funciones antes");				  
		validacionStockDAO.ValidaStock(entrada);		
		return resultado;	
	}
}