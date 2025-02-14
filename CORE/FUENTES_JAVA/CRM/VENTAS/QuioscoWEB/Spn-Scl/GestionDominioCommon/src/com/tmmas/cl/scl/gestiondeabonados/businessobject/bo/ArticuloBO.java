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
package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.ArticuloDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;


public class ArticuloBO {
	
	private ArticuloDAO articuloDAO  = new ArticuloDAO();
	private static Category cat = Category.getInstance(ArticuloBO.class);
	Global global = Global.getInstance();


	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */

	public ArticuloDTO getArticulo(ArticuloDTO entrada)
	throws GeneralException{
		ArticuloDTO resultado = new ArticuloDTO();
		cat.debug("Inicio:getArticulo()");
		resultado = articuloDAO.getArticulo(entrada); 
		cat.debug("Fin:getArticulo()");
		return resultado;
	}//fin getArticulo

	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return N/A
	 * @throws GeneralException
    */
	public void insReservaArticulo(ArticuloDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:insReservaArticulo()");
		articuloDAO.insReservaArticulo(entrada); 
		cat.debug("Fin:insReservaArticulo()");
	}//fin insReservaArticulo

	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	*/
    public ArticuloDTO ActualizaStock(ArticuloDTO entrada) 
	throws GeneralException{
		ArticuloDTO resultado = new ArticuloDTO();
		cat.debug("Inicio:ActualizaStock()");
		resultado = articuloDAO.ActualizaStock(entrada); 
		cat.debug("Fin:ActualizaStock()");
		return resultado;    	
    }//fin ActualizaStock
    
    public ArticuloDTO[] getListArticuloPorCodigo(ArticuloDTO articuloDTO)throws GeneralException{
    	ArticuloDTO[] retValue=null;
    	try{
    		retValue=articuloDAO.getListArticuloPorCodigo(articuloDTO);
    	}
    	catch(GeneralException e){
    		cat.error(e);
    		throw (e);
    	}
    	return retValue;
    }
    
    public String SalidaDefArticulo(String codArticulo, String nomUsuario, String numVenta, String codVendedor, int numCantidad, String codBodega) 
	throws GeneralException{
    	String retValue=null;    	
    	try{
    		retValue=articuloDAO.SalidaDefArticulo(codArticulo,nomUsuario,numVenta,codVendedor,numCantidad,codBodega);
    	}
    	catch(GeneralException e){
    		cat.error(e);
    		throw (e);
    	}
    	return retValue;    	
    }
    	
    
}//fin class Articulo
