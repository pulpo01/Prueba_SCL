package com.tmmas.scl.operations.crm.osr.mancusinv.srv.gpc;

import java.util.ArrayList;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.ProductoContratadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CantidadProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PaqueteContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.LimiteConsumoPlanAdicionalBOFactory;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.interfaces.LimiteConsumoPlanAdicionalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.interfaces.LimiteConsumoPlanAdicionalIT;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.AbonoLimiteConsumoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.bo.ListaNumerosBOFactory;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.bo.interfaces.ListaNumerosBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.bo.interfaces.ListaNumerosIT;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.osr.mancusinv.common.exception.ManCusInvException;
import com.tmmas.scl.operations.crm.osr.mancusinv.srv.gpc.helper.Global;
import com.tmmas.scl.operations.crm.osr.mancusinv.srv.gpc.interfaces.GestionProductoContratadoSrvIF;


public class GestionProductoContratadoSrv implements GestionProductoContratadoSrvIF
{
	
	private Global global = Global.getInstance();
	private final Logger logger = Logger.getLogger(GestionProductoContratadoSrv.class);
	
	
	ProductoContratadoBOFactoryIT boObjectFactory = new ProductoContratadoBOFactory();
	ProductoContratadoIT ProductoContratadoBO =  boObjectFactory.getBusinessObject1();
	
	ListaNumerosBOFactoryIT listaNumerosObjectFactory = new ListaNumerosBOFactory();
	ListaNumerosIT listaNumerosBO =  listaNumerosObjectFactory.getBusinessObject1();
	
	private LimiteConsumoPlanAdicionalBOFactoryIT factoryBO = new LimiteConsumoPlanAdicionalBOFactory();
	private LimiteConsumoPlanAdicionalIT LimiteConsumoBO= factoryBO.getBusinessObject1(); 
	
	public GestionProductoContratadoSrv() {
		String log = global.getValor("service.log");;
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);	
	}
	
	
	public ProductoContratadoListDTO obtenerProductoContratado(OrdenServicioDTO ordenServicio) throws ManCusInvException 
	{
		ProductoContratadoListDTO retorno = null;
		try {
			
			
			logger.debug("obtenerCargosProductos():start");
			retorno = ProductoContratadoBO.obtenerProductoContratado(ordenServicio);
			logger.debug("obtenerCargosProductos():end");
		} catch (GeneralException e) {
			logger.debug("ManCusInvException[", e);
			throw new ManCusInvException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return retorno;	
	}
	
	public PaqueteContratadoDTO obtenerProductoContratadoPorPaquete(PaqueteContratadoDTO paqueteContratado) throws ManCusInvException 
	{
		PaqueteContratadoDTO retorno = null;
		try {
			
			
			logger.debug("obtenerCargosProductos():start");
			retorno = ProductoContratadoBO.obtenerProductosContratadosPorPaquete(paqueteContratado);
			logger.debug("obtenerCargosProductos():end");
		} catch (GeneralException e) {
			logger.debug("ProyectoException[", e);
			throw new ManCusInvException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return retorno;	
	}

	public NumeroDTO obtieneModificacionesProducto(ProductoContratadoDTO productoContratado) throws ManCusInvException 
	{
		NumeroDTO retorno = null;
		try {
			
			
			logger.debug("obtieneModificacionesProducto():start");
			retorno = listaNumerosBO.obtieneModificacionesProducto(productoContratado);
			logger.debug("obtieneModificacionesProducto():end");
		} catch (GeneralException e) {
			logger.debug("ManCusInvException[", e);
			throw new ManCusInvException(e.getCodigo(),e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return retorno;	
	}
	
	public RetornoDTO crearListaNumeros(NumeroListDTO numeros) throws ManCusInvException
	{
		RetornoDTO retorno=null;		
		try 
		{	
			
			logger.debug("crearListaNumeros():start");
			retorno = listaNumerosBO.crear(numeros);
			logger.debug("crearListaNumeros():end");
		}
		catch (Exception e) 
		{
			logger.debug("ManCusInvException[", e);
			throw new ManCusInvException(e);
		}		
		return retorno;
	}
	
	public RetornoDTO eliminarListaNumeros(NumeroListDTO numeros) throws ManCusInvException
	{
		RetornoDTO retorno=null;		
		try 
		{		
			
			
			logger.debug("eliminarListaNumeros():start");
			retorno = listaNumerosBO.eliminaListaNumeros(numeros);
			logger.debug("eliminarListaNumeros():end");
		}
		catch (Exception e) 
		{
			logger.debug("ManCusInvException[", e);
			throw new ManCusInvException(e);
		}		
		return retorno;
	}

	public ProductoContratadoListDTO obtenerDetalleProductoContratado(ProductoContratadoListDTO listaProductos) throws ManCusInvException 
	{		
		try {
			
			
			logger.debug("obtenerDetalleProductoContratado():start");
			listaProductos = ProductoContratadoBO.obtenerDetalleProductoContratado(listaProductos);
			logger.debug("obtenerDetalleProductoContratado():end");
		}
		catch (GeneralException e) 
		{
			logger.debug("ManCusInvException[", e);
			throw new ManCusInvException(e);
		}
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return listaProductos;	
	}

	public NumeroListDTO obtenerListaNumeros(ProductoContratadoDTO productoContratado) throws ManCusInvException{
		NumeroListDTO retorno=null;		
		try 
		{		
			
			
			logger.debug("obtenerListaNumeros():start");
			retorno = listaNumerosBO.obtenerListaNumeros(productoContratado);
			logger.debug("obtenerListaNumeros():end");
		} catch (GeneralException e) {
			logger.debug("ManCusInvException[", e);
			throw new ManCusInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}	
		return retorno;		
	}
	
	public CantidadProductoContratadoDTO obtieneCantidadProductosContratados(CantidadProductoContratadoDTO producto) throws ManCusInvException{
		CantidadProductoContratadoDTO retorno=null;		
		try 
		{		
			logger.debug("obtieneCantidadProductosContratados():start");
			retorno = ProductoContratadoBO.obtieneCantidadProductosContratados(producto);
			logger.debug("obtieneCantidadProductosContratados():end");
		} catch (GeneralException e) {
			logger.debug("ManCusInvException[", e);
			throw new ManCusInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}	
		return retorno;			
	}
	
	public RetornoDTO informarLC(LimiteConsumoPlanAdicionalListDTO LimConsLista) throws ManCusInvException
	{
		
		RetornoDTO resultado = null;
		try {
			logger.debug("------------------ini-----------------------");
			logger.debug("listaLimCons.getLimitesDeConsumo().length["+LimConsLista.getLimitesDeConsumo().length+"]");
			logger.debug("-----------------------------------------------");
			ArrayList lcArrList = new ArrayList();
			LimiteConsumoPlanAdicionalDTO[] lcArr= LimConsLista.getLimitesDeConsumo();
			LimiteConsumoPlanAdicionalDTO lc = null;
			for(int i=0;i<LimConsLista.getLimitesDeConsumo().length;i++)
			{
				lc = LimConsLista.getLimitesDeConsumo()[i];
				logger.debug("lc.CodLimCons()    ["+i+"]["+lc.getCodLimCons()+"]");
				logger.debug("lc.MtoConsuConfig()["+i+"]["+lc.getMtoConsumoConfigurado()+"]");
				logger.debug("lc.CodPlanTarif()  ["+i+"]["+lc.getCodPlanTarif()+"]");
				if(lc.getCodLimCons() == null){
					logger.debug("No se registra LC");
				}else{
					lcArrList.add(lc);
				}
				logger.debug("-----------------------------------------------");
			}
			lcArr = (LimiteConsumoPlanAdicionalDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lcArrList.toArray(), LimiteConsumoPlanAdicionalDTO.class);
			LimConsLista.setLimitesDeConsumo(lcArr);
			logger.debug("-----------------fin-------------------------");
			logger.debug("LimConsLista.getLimitesDeConsumo().length["+LimConsLista.getLimitesDeConsumo().length+"]");
			logger.debug("-----------------------------------------------");
			logger.debug("informarLimiteConsumo():start");
			resultado = LimiteConsumoBO.informarLC(LimConsLista);			
			logger.debug("informarLimiteConsumo():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return resultado;
		
	}
	
	public RetornoDTO actualizarLC(ProductoContratadoListDTO prodList) throws ManCusInvException
	{
		
		RetornoDTO resultado = null;
		try {
			
			logger.debug("actualizarLimiteConsumo():start");
			resultado = LimiteConsumoBO.actualizarLC(prodList);			
			logger.debug("actualizarLimiteConsumo():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return resultado;
		
	}
	
	public RetornoDTO cambiarLC(ProductoContratadoListDTO prodList) throws ManCusInvException
	{
		
		RetornoDTO resultado = null;
		try {
			
			logger.debug("actualizarLimiteConsumo():start");
			resultado = LimiteConsumoBO.cambiarLC(prodList);			
			logger.debug("actualizarLimiteConsumo():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return resultado;
		
	}
	
	public RetornoDTO informarAbonoLimiteConsumo(AbonoLimiteConsumoListDTO listaAbonoLimiteConsumo) throws ManCusInvException
	{
			
		RetornoDTO resultado = null;
		try {
			
			logger.debug("actualizarLimiteConsumo():start");
			resultado = LimiteConsumoBO.informarAbonoLimiteConsumo(listaAbonoLimiteConsumo);			
			logger.debug("actualizarLimiteConsumo():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusInvException(e);
		}
		return resultado;
		
	}
}
