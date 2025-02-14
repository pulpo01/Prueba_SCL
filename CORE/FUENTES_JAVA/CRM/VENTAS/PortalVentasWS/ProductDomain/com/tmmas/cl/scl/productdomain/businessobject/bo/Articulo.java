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
package com.tmmas.cl.scl.productdomain.businessobject.bo;

import java.rmi.RemoteException;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ArticuloInDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.ArticuloDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloOutDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class Articulo extends ProductComponent{
	
	private ArticuloDAO articuloDAO  = new ArticuloDAO();
	private static Category cat = Category.getInstance(Articulo.class);
	Global global = Global.getInstance();


	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */

	public ArticuloDTO getArticulo(ArticuloDTO entrada)
		throws ProductDomainException
	{
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
	 * @throws ProductDomainException
    */
	public void insReservaArticulo(ArticuloDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:insReservaArticulo()");
		articuloDAO.insReservaArticulo(entrada); 
		cat.debug("Fin:insReservaArticulo()");
	}//fin insReservaArticulo

	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	*/
    public ArticuloDTO ActualizaStock(ArticuloDTO entrada) 
		throws ProductDomainException
	{
		ArticuloDTO resultado = new ArticuloDTO();
		cat.debug("Inicio:ActualizaStock()");
		resultado = articuloDAO.ActualizaStock(entrada); 
		cat.debug("Fin:ActualizaStock()");
		return resultado;    	
    }//fin ActualizaStock
    
	/**
	 * Obtiene Listado de articulos 
	 * @param 
	 * @return resultado
	 * @throws ProductDomainException
	*/
    public ArticuloOutDTO[] getListadoArticulos(ArticuloInDTO articulo) 
		throws ProductDomainException
	{
    	ArticuloOutDTO[] resultado ;
		cat.debug("Inicio:getListadoArticulo()");
		resultado = articuloDAO.getListadoArticulos(articulo); 
		cat.debug("Fin:getListadoArticulo()");
		return resultado;    	
    }//fin getListadoArticulo

	/** Servicios Activaciones WEB - Colombia
	 * MAYORISTAS
	 * Obtine indicador valorar
	 * @param ArticuloDTO (entrada)
	 * @return ArticuloDTO (resultado)
	 * @throws ProductDomainException
     * wjrc - Agosto 2007 */    
	public ArticuloDTO getIndicadorValorar(ArticuloDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("getIndicadorValorar():start");
		ArticuloDTO resultado = articuloDAO.getIndicadorValorar(entrada);
		cat.debug("getIndicadorValorar():end");
		return resultado;		
	}//fin getIndicadorValorar  

	/** Servicios Activaciones WEB - Colombia
	 * MAYORISTAS
	 * Obtine verificacion venta mayorista
	 * @param ArticuloDTO (entrada)
	 * @return ArticuloDTO (resultado)
	 * @throws ProductDomainException
     * wjrc - Agosto 2007 */    
	public ArticuloDTO getVentaMayorista(ArticuloDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("getVentaMayorista():start");
		ArticuloDTO resultado = articuloDAO.getVentaMayorista(entrada);
		cat.debug("getVentaMayorista():end");
		return resultado;		
	}//fin getVentaMayorista
	
	public ArticuloInDTO[] getArticulos(ArticuloInDTO articulo)	
		throws ProductDomainException
	{
		ArticuloInDTO[] resultado ;
		cat.debug("Inicio:getArticulos()");
		resultado = articuloDAO.getArticulos(articulo); 
		cat.debug("Fin:getArticulos()");
		return resultado;    	
    }//fin getListadoArticulo
	
	//Inicio P-CSR-11002 JLGN 27-04-2011
	public void actualizaUsoTerminal(ArticuloDTO entrada, String codUsoNuevo) throws ProductDomainException{
		cat.info("Inicio actualizaUsoTerminal");
		articuloDAO.actualizaUsoTerminal(entrada, codUsoNuevo);
		cat.info("Fin actualizaUsoTerminal");
	}
	//Fin P-CSR-11002 JLGN 27-04-2011
	
}//fin class Articulo
