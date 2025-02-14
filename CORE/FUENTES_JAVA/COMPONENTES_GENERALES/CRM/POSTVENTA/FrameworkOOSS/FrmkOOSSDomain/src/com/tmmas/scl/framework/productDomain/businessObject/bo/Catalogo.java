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
 * 09-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.bo;

import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CatalogoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CategoriaPlanBasicoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CategoriaPlanBasicoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ProductoOfertadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ProductoOfertadoIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.CatalogoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.CatalogoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CatalogoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CategoriaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CategoriaListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DescuentoProductoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingPriceException;

public class Catalogo implements CatalogoIT
{
	private CategoriaPlanBasicoBOFactoryIT catPlanBasFactory=new CategoriaPlanBasicoBOFactory();
	private CategoriaPlanBasicoIT catPlanBasBO=catPlanBasFactory.getBusinessObject1();
	
	private ProductoOfertadoBOFactoryIT prodOfeFactory=new ProductoOfertadoBOFactory();
	private ProductoOfertadoIT prodOfeBO=prodOfeFactory.getBusinessObject1();
	
	private CargoBOFactoryIT cargoFactory=new CargoBOFactory();
	private CargoIT	cargo=cargoFactory.getBusinessObject1();
	
	
	private final Logger logger = Logger.getLogger(Catalogo.class);
	private Global global = Global.getInstance();
	private CatalogoDAOIT catalogoDAO=new CatalogoDAO();
	
	public CargoListDTO obtenerCargosProductos(ProductoOfertadoListDTO prodOferList) throws ProductOfferingPriceException  
	{		
		CargoListDTO resultado = new CargoListDTO();
		
		
		logger.debug("Inicio:obtenerCargosProductos()");
		
		//resultado = catalogoDAO.obtenerCargosProductos(prodOferList);
				
		resultado=cargo.obtenerDetalleCargos(resultado);		
		
		logger.debug("Fin:obtenerCargosProductos()");
		
		return resultado;
	}

	public ProductoOfertadoListDTO obtenerProductosOfertables(AbonadoDTO abonado) throws ProductOfferingException  
	{
		logger.debug("Inicio:obtenerProductosOfertables()");	
		
		ProductoOfertadoListDTO productosPorCanal = null;
		ProductoOfertadoListDTO productosPorCanalCategoria = new ProductoOfertadoListDTO();
		CategoriaListDTO categorias=null;
		CargoListDTO cargos=null;
		DescuentoProductoListDTO descuentosCargo=null;
		PlanTarifarioDTO planTarifario=abonado.getPlanTarifario();		
		planTarifario.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
		planTarifario.setCodCliente(String.valueOf(abonado.getCodCliente()));
		
		ProductoOfertadoDTO prod=null;
		ProductoOfertadoDTO[] prodList=null;
		CategoriaDTO cat=null;
		ArrayList prodOfertadosFiltrados=new ArrayList();
		
		productosPorCanal = catalogoDAO.obtenerProductosOfertables(abonado);		
		categorias=catPlanBasBO.obtenerCategoriaPlanBasico(planTarifario);	
		
		/**
		 * Se filtran los productos que esten dentro de las categorias asociadas al abonado
		 */
		for(int i=0;i<productosPorCanal.getProductoList().length;i++)
		{
			 prod=null;
			 prod=productosPorCanal.getProductoList()[i];
			 boolean match=false;
			 
			 for(int j=0;(j<categorias.getCategoriaList().length && !match);j++)
			 {
				 cat=null;
				 cat=categorias.getCategoriaList()[j];
				 match=cat.getIdCategoria().equals(prod.getCodCategoria())?true:false;
			 }
			 
			 if(match)
				 prodOfertadosFiltrados.add(prod);
		}
		
		prodList=(ProductoOfertadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(prodOfertadosFiltrados.toArray(), ProductoOfertadoDTO.class);		
		productosPorCanalCategoria.setProductoList(prodList);		
		
		productosPorCanalCategoria=prodOfeBO.obtenerDetalleProductos(productosPorCanalCategoria);
			
		/** 
		 * Bucle para obtener los cargos asociados a un producto 
		 */
		CatalogoDTO catalogo=abonado.getCatalogo();
		
		for(int i=0;i<productosPorCanalCategoria.getProductoList().length;i++)
		{
			prod=null;
			prod=productosPorCanalCategoria.getProductoList()[i];			
			catalogo.setCodProdOfertado(prod.getIdProductoOfertado());
			
			
			cargos=catalogoDAO.obtenerCargosProductos(catalogo);
			
			if(cargos!=null && cargos.getCargoList()!=null)
			{
				for(int j=0;j<cargos.getCargoList().length;j++)
				{
					catalogo.setCodConcepto(cargos.getCargoList()[j].getCodConcepto());
					descuentosCargo=catalogoDAO.obtenerDescuentosCargo(catalogo);
					cargos.getCargoList()[j].setDescuentos(descuentosCargo);
				}
			}
			//cargos.getCargoList()[0].
			productosPorCanalCategoria.getProductoList()[i].setCargoList(cargos);			
		}		
			
		logger.debug("Fin:obtenerProductosOfertables()");
		return productosPorCanalCategoria;
	}

}
