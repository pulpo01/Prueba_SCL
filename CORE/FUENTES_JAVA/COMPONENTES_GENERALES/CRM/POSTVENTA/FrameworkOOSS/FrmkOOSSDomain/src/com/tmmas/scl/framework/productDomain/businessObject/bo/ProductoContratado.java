/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 20/08/2007			Cristian Toledo							Version Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.bo;

import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ProductoContratadoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ProductoOfertadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ProductoOfertadoIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.ProductoContratadoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.ProductoOfertadoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.SCLProductoContratadoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.ProductoContratadoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.ProductoOfertadoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.SCLProductoContratadoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CambioPlanComercialDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CausaBajaListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DesactServFreDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ListaFrecuentesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PaqueteContratadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PaqueteContratadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanServicioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ReordenamientoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TraspasoPlanDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.ListaNumerosBOFactory;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.ListaNumerosBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.ListaNumerosIT;

public class ProductoContratado implements ProductoContratadoIT {

	private ProductoContratadoDAOIT productoDAO = new ProductoContratadoDAO();
	private SCLProductoContratadoDAOIT productoSCLDAO = new SCLProductoContratadoDAO();
	
	private ProductoOfertadoDAOIT productoOfertadoDAO = new ProductoOfertadoDAO();
	
	private ListaNumerosBOFactoryIT listaNumerosFactory=new ListaNumerosBOFactory();
	private ListaNumerosIT listaNumerosBO=listaNumerosFactory.getBusinessObject1();
	
	private ProductoOfertadoBOFactoryIT factoryBO2 = new ProductoOfertadoBOFactory();
	private ProductoOfertadoIT prodOfertadoBO = factoryBO2.getBusinessObject1();
	
	private final Logger logger = Logger.getLogger(ProductoContratado.class);
	private Global global = Global.getInstance();
	
	public RetornoDTO registraReordenamientoPlan(ReordenamientoDTO datos)
			throws ProductException {
		RetornoDTO retorno = null;
		try {
			logger.debug("registraReordenamientoPlan():start");
			retorno = productoSCLDAO.registraReordenamientoPlan(datos);
			logger.debug("registraReordenamientoPlan():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;
	}
//	---------------------------------------------------------------------------------------------------
	public RetornoDTO registroCambPlanComer(CambioPlanComercialDTO datos) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("registroCambPlanComer():start");
			retorno = productoSCLDAO.registroCambPlanComer(datos);
			logger.debug("registroCambPlanComer():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;
	}
//	---------------------------------------------------------------------------------------------------
	public RetornoDTO validaDesacListaFrecuente(ListaFrecuentesDTO lista) throws ProductException{
			RetornoDTO retorno = null;
			try {
				logger.debug("validaDesacListaFrecuente():start");
				retorno = productoSCLDAO.validaDesacListaFrecuente(lista);
				logger.debug("validaDesacListaFrecuente():end");
			} catch (ProductException e) {
				logger.debug("ProductException[", e);
				throw e;
			}
			catch (Exception e) {
				logger.debug("Exception[", e);
				throw new ProductException(e);
			}		
			return retorno;
		}
//	---------------------------------------------------------------------------------------------------	
	public RetornoDTO registraTraspasoPlan(TraspasoPlanDTO traspaso) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("registraTraspasoPlan():start");
			retorno = productoSCLDAO.registraTraspasoPlan(traspaso);
			logger.debug("registraTraspasoPlan():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;
	}
//	---------------------------------------------------------------------------------------------------	
	public RetornoDTO registraDesActSerFre(DesactServFreDTO param) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("registraDesActSerFre():start");
			retorno = productoSCLDAO.registraDesActSerFre(param);
			logger.debug("registraDesActSerFre():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;		
	}
//	---------------------------------------------------------------------------------------------------	
	public RetornoDTO registroCambPlanServ(PlanServicioDTO plan) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("registroCambPlanServ():start");
			retorno = productoSCLDAO.registroCambPlanServ(plan);
			logger.debug("registroCambPlanServ():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;			
	}
//	---------------------------------------------------------------------------------------------------	
	public RetornoDTO validaCuentaPersonal(CuentaPersonalDTO cuenta) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("validaCuentaPersonal():start");
			retorno = productoSCLDAO.validaCuentaPersonal(cuenta);
			logger.debug("validaCuentaPersonal():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;	
	}
	
//---------------------------------------------------------------------------------------------------
	public RetornoDTO activar(PaqueteContratadoListDTO paquetes) throws ProductException 
	{
		RetornoDTO retorno = null;
		PaqueteContratadoDTO paq=null;
		
		try 
		{
			logger.debug("activar():start");			
			for(int i=0;i<paquetes.getPaqueteContratadoList().length;i++)
			{
				paq=paquetes.getPaqueteContratadoList()[i];
				paq.setIdProdContraPadre(new Long(0));
				productoDAO.activar(paq);
				
				for(int j=0;j<paq.getListaProductosContratados().getProductosContratadosDTO().length;j++)
				{
					paq.getListaProductosContratados().getProductosContratadosDTO()[j].setIdProdContraPadre(paq.getIdProdContratado());
					paq.getListaProductosContratados().getProductosContratadosDTO()[j].setIndCondicionContratacion(paq.getIndCondicionContratacion());
				}
				/**
				 * Aca se envia a activar cada uno de los productos Contratados Asociados al paquete.
				 */
				retorno=this.activar(paq.getListaProductosContratados());			
			}			
			logger.debug("activar():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;	
	}
	
//---------------------------------------------------------------------------------------------------
	
	public RetornoDTO activar(ProductoContratadoListDTO productos) throws ProductException 
	{
		RetornoDTO retorno = null;
		try {
			logger.debug("activar():start");			
			for(int i=0;i<productos.getProductosContratadosDTO().length;i++)
			{
				productoDAO.activar(productos.getProductosContratadosDTO()[i]);				
				if(productos.getProductosContratadosDTO()[i].getListaNumero()!=null && productos.getProductosContratadosDTO()[i].getListaNumero().getNumerosDTO().length>0)
				{					
					for(int listaNumIndex=0;listaNumIndex<productos.getProductosContratadosDTO()[i].getListaNumero().getNumerosDTO().length;listaNumIndex++)
					{
						productos.getProductosContratadosDTO()[i].getListaNumero().getNumerosDTO()[listaNumIndex].setFecInicioVigencia(productos.getProductosContratadosDTO()[i].getFechaInicioVigencia());
						productos.getProductosContratadosDTO()[i].getListaNumero().getNumerosDTO()[listaNumIndex].setFecTerminoVigencia(productos.getProductosContratadosDTO()[i].getFechaTerminoVigencia());
						productos.getProductosContratadosDTO()[i].getListaNumero().getNumerosDTO()[listaNumIndex].setNumProceso(productos.getProductosContratadosDTO()[i].getNumProceso());
						productos.getProductosContratadosDTO()[i].getListaNumero().getNumerosDTO()[listaNumIndex].setOrigenProceso(productos.getProductosContratadosDTO()[i].getOrigenProceso());
						productos.getProductosContratadosDTO()[i].getListaNumero().getNumerosDTO()[listaNumIndex].setFecProceso(productos.getProductosContratadosDTO()[i].getFechaProceso());
					}					
					listaNumerosBO.crear(productos.getProductosContratadosDTO()[i].getListaNumero());
				}
			}			
			logger.debug("activar():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;	
	}
//	---------------------------------------------------------------------------------------------------
	public RetornoDTO notificar(VentaDTO venta) throws ProductException {
		RetornoDTO retorno = null;
		try {
			logger.debug("notificar():start");
			retorno = productoDAO.notificar(venta);
			logger.debug("notificar():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;
	}
//	---------------------------------------------------------------------------------------------------
	public RetornoDTO actualizarEstado(VentaDTO venta) throws ProductException {
		RetornoDTO retorno = null;
		try {
			logger.debug("notificar():start");
			retorno = productoDAO.actualizarEstado(venta);
			logger.debug("notificar():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;
	}	
//	---------------------------------------------------------------------------------------------------	
	public AbonadoDTO obtenerDatosCambPlanServ(AbonadoDTO abonado) throws ProductException{
		AbonadoDTO retorno = null;
		try {
			logger.debug("obtenerDatosCambPlanServ():start");
			retorno = productoSCLDAO.obtenerDatosCambPlanServ(abonado);
			logger.debug("obtenerDatosCambPlanServ():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;		
	}
//	---------------------------------------------------------------------------------------------------	
	public ProductoContratadoListDTO  obtenerProductoContratado(OrdenServicioDTO ordenServicio) throws ProductException{
		ProductoContratadoListDTO retorno = null;
		try {
			logger.debug("registraReordenamientoPlan():start");
			retorno = productoDAO.obtenerProductosContratados(ordenServicio);
			retorno = llenarListaProductoContratado (retorno);
			logger.debug("registraReordenamientoPlan():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;
	}
	
//	---------------------------------------------------------------------------------------------------	
	public PaqueteContratadoDTO obtenerProductosContratadosPorPaquete(PaqueteContratadoDTO paqueteContratado) throws ProductException{
		PaqueteContratadoDTO retorno = null;
		try {
			logger.debug("registraReordenamientoPlan():start");
			
			retorno = productoDAO.obtenerProductosContratadosPorPaquete(paqueteContratado);
			retorno.setListaProductosContratados(llenarListaProductoContratado(retorno.getListaProductosContratados()));

			logger.debug("registraReordenamientoPlan():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;
	}
//	---------------------------------------------------------------------------------------------------
	public ProductoContratadoListDTO obtenerProductosContratadosVenta(VentaDTO venta) throws ProductException 
	{
		ProductoContratadoListDTO retorno=null;
		try {
			logger.debug("obtenerProductosContratadosVenta():start");
			retorno = productoDAO.obtenerProductosContratadosVenta(venta);
			logger.debug("obtenerProductosContratadosVenta():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;		
	}
//	---------------------------------------------------------------------------------------------------
	public RetornoDTO desactivar(ProductoContratadoListDTO listaProductosContratados) throws ProductException {
		RetornoDTO retorno=null;
		try 
		{
			logger.debug("desactivar():start");
			
			listaNumerosBO.eliminar(listaProductosContratados);			
			retorno = productoDAO.desactivar(listaProductosContratados);
			
			logger.debug("desactivar():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;		
	}
//	---------------------------------------------------------------------------------------------------	
	public CausaBajaListDTO obtenerCausaBaja() throws ProductException{
		CausaBajaListDTO retorno = null;
		try {
			logger.debug("obtenerCausaBaja():start");
			retorno = productoSCLDAO.obtenerCausaBaja();
			logger.debug("obtenerCausaBaja():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;	
	}

//	---------------------------------------------------------------------------------------------------

	public RetornoDTO descontratar(ProductoContratadoListDTO listaProductosContratados) throws ProductException {
		RetornoDTO retorno=null;
		try 
		{
			logger.debug("desactivar():start");
			
			retorno = listaNumerosBO.eliminaListaNumeros(listaProductosContratados);
			if ( retorno != null )
				retorno = productoDAO.descontratar(listaProductosContratados);			
			logger.debug("desactivar():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;		
	}
	
//	---------------------------------------------------------------------------------------------------
	private ProductoContratadoListDTO llenarListaProductoContratado( ProductoContratadoListDTO prodContratadoList ) throws ProductException
	{
		ProductoContratadoDTO[] aux = null;
		ProductoOfertadoDTO[] prodOfAuxArray = null;
		ProductoOfertadoListDTO prodOfAuxList = new ProductoOfertadoListDTO();
		try
		{
		
			aux = prodContratadoList.getProductosContratadosDTO();
			ArrayList arrayListAux = new ArrayList();
			for( int i=0; i<aux.length ; i++)
			{
				arrayListAux.add(aux[i].getProdOfertado());
				aux[i].setListaNumero(listaNumerosBO.obtenerListaNumeros(aux[i]));
			}
			prodOfAuxArray = new ProductoOfertadoDTO[aux.length];
			prodOfAuxArray = (ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(arrayListAux.toArray(), ProductoOfertadoDTO.class);
			prodOfAuxList.setProductoList(prodOfAuxArray);
			
			//----------------------------
			//prodOfAuxList = productoOfertadoDAO.obtenerDetalleProductos(prodOfAuxList);
			prodOfAuxList = prodOfertadoBO.obtenerDetalleProductos(prodOfAuxList);//<-------- deberia ser esto
			prodOfAuxArray = prodOfAuxList.getProductoList();
			
			for( int i=0; i<prodOfAuxArray.length ; i++)
			{
				aux[i].setProdOfertado(prodOfAuxArray[i]);
			}
			prodContratadoList.setProductosContratadosDTO(aux);
		}catch (Exception e) {
		logger.debug("Exception[", e);
		throw new ProductException(e);
		}		
		return prodContratadoList;
	}	
//-------------------------------------------------------------------------	
	public ProductoContratadoListDTO obtenerDetalleProductoContratado(ProductoContratadoListDTO listaProductos) throws ProductException 
	{		
		try 
		{
			logger.debug("obtenerDetalleProductoContratado():start");
			listaProductos = productoDAO.obtenerDetalleProductoContratado(listaProductos);		
			listaProductos = this.llenarListaProductoContratado(listaProductos);
			logger.debug("obtenerDetalleProductoContratado():end");
		}
		catch (ProductException e) 
		{
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return listaProductos;
	}
//-------------------------------------------------------------------------		
}
