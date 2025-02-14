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
 * 11-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.bo;

import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.EspecificacionProductoIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.EspecificacionProductoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.SCLEspecificacionProductoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.EspecificacionProductoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.SCLEspecificacionProductoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.EspecProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductSpecificationException;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.EspecificacionServicioClienteBOFactory;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.EspecificacionServicioListaBOFactory;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioClienteBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioClienteIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioListaBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioListaIT;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioListaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioListaListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ReglasListaNumerosListDTO;



public class EspecificacionProducto implements EspecificacionProductoIT
{
	private EspecificacionServicioClienteBOFactoryIT espServCliBOFactory= new EspecificacionServicioClienteBOFactory();
	private EspecificacionServicioClienteIT espServCliBO=espServCliBOFactory.getBusinessObject();
	
	private EspecificacionServicioListaBOFactoryIT factoryBO5=new EspecificacionServicioListaBOFactory();
	private EspecificacionServicioListaIT   especificacionServicioListaBO=factoryBO5.getBusinessObject();
	
	private final Logger logger = Logger.getLogger(EspecificacionProducto.class);
	private Global global = Global.getInstance();
	
	private EspecificacionProductoDAOIT espProdDAO = new EspecificacionProductoDAO();
	private SCLEspecificacionProductoDAOIT espProdSCLDAO = new SCLEspecificacionProductoDAO();
	
	public ProductoOfertadoListDTO obtenerEspecificacionProducto(ProductoOfertadoListDTO prodOfertadoList) throws ProductSpecificationException {
		ProductoOfertadoListDTO retorno = new ProductoOfertadoListDTO();
		try {
			logger.debug("obtenerEspecificacionProducto():start");
			
			ArrayList productoOfertadoArray=new ArrayList();
			ProductoOfertadoDTO prodDTO=null;
			
			
			for(int i=0;i<prodOfertadoList.getProductoList().length;i++)
			{
				prodDTO=prodOfertadoList.getProductoList()[i];
				prodDTO=espProdDAO.obtenerEspecificacionProducto(prodDTO);
				EspecProductoDTO especProd=null;
				ReglasListaNumerosListDTO reglasNumList=null;
				
				if(prodDTO.getEspecificacionProducto()!=null)
				{
					 especProd=espServCliBO.obtenerEspecificacionServicioCliente(prodDTO.getEspecificacionProducto());				
					 prodDTO.setEspecificacionProducto(especProd);					 
					 
					 if(especProd.getEspecServicioClienteList()!=null && especProd.getEspecServicioClienteList().getEspecSerLisList()!=null)
					 {
						 EspecServicioListaListDTO listaSerListaLIST=especProd.getEspecServicioClienteList().getEspecSerLisList();
						 for(int j=0;j<listaSerListaLIST.getEspecServicioListaList().length;j++)
						 {
								EspecServicioListaDTO dtoIn=listaSerListaLIST.getEspecServicioListaList()[j];			
								reglasNumList=especificacionServicioListaBO.obtenerReglasValidacion(dtoIn);
								prodDTO.setListaReglasNumeros(reglasNumList);
						 }
					 }					 
				}
				productoOfertadoArray.add(prodDTO);
			}
			
			ProductoOfertadoDTO[] dtoList=(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(productoOfertadoArray.toArray(), ProductoOfertadoDTO.class);
			retorno.setProductoList(dtoList);
			
			logger.debug("obtenerEspecificacionProducto():end");
		} catch (ProductSpecificationException e) {
			logger.debug("ProductSpecificationException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductSpecificationException(e);
		}		
		return retorno;	
	}
	
	public ReglasListaNumerosListDTO obtenerEspecificacionLista(EspecServicioListaDTO especServicioLista) throws ProductSpecificationException{
		ReglasListaNumerosListDTO retorno = null;		
		try {
			logger.debug("obtenerEspecificacionProducto():start");			
			retorno = espServCliBO.obtenerEspecificacionServicioLista(especServicioLista);
			logger.debug("obtenerEspecificacionProducto():end");
		}catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductSpecificationException(e);
		}		
		return retorno;	
	}
	
	public CuotasProductoDTO[] obtenerCuotasProducto() throws ProductSpecificationException
	{	    
		CuotasProductoDTO[] retorno = null;		
		try {
			logger.debug("obtenerCuotasProducto():start");			
			retorno = espProdSCLDAO.obtenerCuotasProducto();
			logger.debug("obtenerCuotasProducto():end");
		}catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductSpecificationException(e);
		}		
		return retorno;		
	}

	public CartaGeneralDTO obtenerTextoCarta(CartaGeneralDTO cartaGeneral) throws ProductSpecificationException {
		CartaGeneralDTO retorno= null;
		try {
			logger.debug("obtenerCuotasProducto():start");			
			retorno = espProdDAO.obtenerTextoCarta(cartaGeneral);
			logger.debug("obtenerCuotasProducto():end");
		}catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductSpecificationException(e);
		}
		return retorno;
	}
	
}
