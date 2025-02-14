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
 * 14/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ArticuloFCBOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.ArticuloFCDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.ArticuloFCDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;


//import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerBillException;
//import com.tmmas.cl.scl.productdomain.businessobject.dao.ArticuloDAO;
//import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloDTO;
//import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloOutDTO;
//import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

//public class ArticuloFCBO extends ProductComponent{
public class ArticuloFCBO implements ArticuloFCBOIT{
	private ArticuloFCDAOIT articuloDAO  = new ArticuloFCDAO();
	private final Logger logger = Logger.getLogger(ArticuloFCBO.class);
	Global global = Global.getInstance();


	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerBillException
	 */

	public ArticuloDTO getArticulo(ArticuloDTO entrada)
	throws CustomerBillException{
		ArticuloDTO resultado = new ArticuloDTO();
		logger.debug("Inicio:getArticulo()");
		resultado = articuloDAO.getArticulo(entrada); 
		logger.debug("Fin:getArticulo()");
		return resultado;
	}//fin getArticulo

	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return N/A
	 * @throws CustomerBillException
    */
	/*public void insReservaArticulo(ArticuloDTO entrada) 
	throws CustomerBillException{
		logger.debug("Inicio:insReservaArticulo()");
		articuloDAO.insReservaArticulo(entrada); 
		logger.debug("Fin:insReservaArticulo()");
	}//fin insReservaArticulo

	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerBillException
	*/
   /* public ArticuloDTO ActualizaStock(ArticuloDTO entrada) 
	throws CustomerBillException{
		ArticuloDTO resultado = new ArticuloDTO();
		logger.debug("Inicio:ActualizaStock()");
		resultado = articuloDAO.ActualizaStock(entrada); 
		logger.debug("Fin:ActualizaStock()");
		return resultado;    	
    }//fin ActualizaStock
    
	/**
	 * Obtiene Listado de articulos 
	 * @param 
	 * @return resultado
	 * @throws CustomerBillException
	*/
  /*  public ArticuloOutDTO[] getListadoArticulos() 
	throws CustomerBillException{
    	ArticuloOutDTO[] resultado ;
		logger.debug("Inicio:getListadoArticulo()");
		resultado = articuloDAO.getListadoArticulos(); 
		logger.debug("Fin:getListadoArticulo()");
		return resultado;    	
    }//fin getListadoArticulo

	/** Servicios Activaciones WEB - Colombia
	 * MAYORISTAS
	 * Obtine indicador valorar
	 * @param ArticuloDTO (entrada)
	 * @return ArticuloDTO (resultado)
	 * @throws CustomerBillException
     * wjrc - Agosto 2007 */    
	/*public ArticuloDTO getIndicadorValorar(ArticuloDTO entrada) 
	throws CustomerBillException{
		logger.debug("getIndicadorValorar():start");
		ArticuloDTO resultado = articuloDAO.getIndicadorValorar(entrada);
		logger.debug("getIndicadorValorar():end");
		return resultado;		
	}*///fin getIndicadorValorar  
	
}//fin class Articulo
