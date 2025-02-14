package com.tmmas.scl.operations.crm.o.csr.manprooffinv.srv;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.CatalogoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.PaqueteOfertadoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.ProductoOfertadoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.SCLPlanBasicoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.CatalogoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.CatalogoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.PaqueteOfertadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.PaqueteOfertadoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.ProductoOfertadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.ProductoOfertadoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaPlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoScoringListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.EspecificacionProductoBOFactory;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.LimiteConsumoPlanAdicionalBOFactory;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.interfaces.EspecificacionProductoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.interfaces.EspecificacionProductoIT;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.interfaces.LimiteConsumoPlanAdicionalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.interfaces.LimiteConsumoPlanAdicionalIT;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoProductoDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoProductoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.TipoComportamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.EspecificacionServicioListaBOFactory;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionServicioListaBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionServicioListaIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioListaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ReglasListaNumerosListDTO;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.srv.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.srv.interfaces.GestionProductoSrvIF;

public class GestionProductoSrv implements GestionProductoSrvIF {

	private final Logger logger = Logger.getLogger(GestionProductoSrv.class);
	
	private SCLPlanBasicoBOFactoryIT factoryBO1 = new SCLPlanBasicoBOFactory();
	private SCLPlanBasicoIT planBO = factoryBO1.getBusinessObject1();
	
	private ProductoOfertadoBOFactoryIT factoryBO2 = new ProductoOfertadoBOFactory();
	private ProductoOfertadoIT prodOfertadoBO = factoryBO2.getBusinessObject1();	
	
	private PaqueteOfertadoBOFactoryIT factoryBO3= new PaqueteOfertadoBOFactory();
	private PaqueteOfertadoIT	paqueteOfertadoBO= factoryBO3.getBusinessObject1();
	
	private CatalogoBOFactoryIT factoryBO4=new CatalogoBOFactory();
	private CatalogoIT catalogoBO= factoryBO4.getBusinessObject1();
	
	private LimiteConsumoPlanAdicionalBOFactoryIT factoryBO6 = new LimiteConsumoPlanAdicionalBOFactory();
	private LimiteConsumoPlanAdicionalIT LimiteConsumoBO= factoryBO6.getBusinessObject1(); 
	
	private EspecificacionServicioListaBOFactoryIT factoryBO5=new EspecificacionServicioListaBOFactory();
	private EspecificacionServicioListaIT   especificacionServicioListaBO=factoryBO5.getBusinessObject();

	private EspecificacionProductoBOFactoryIT factoryBO7=new EspecificacionProductoBOFactory();
	private EspecificacionProductoIT   especificacionProductoBO=factoryBO7.getBusinessObject();

	
	private Global global = Global.getInstance();
	
	public GestionProductoSrv(){
		String log = global.getValor("service.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
	}

	public PlanTarifarioListDTO obtenerPlanesTarifarios(
			BusquedaPlanTarifarioDTO param) throws ManProOffInvException {
		
		PlanTarifarioListDTO planes = null;
		try {
					
			logger.debug("obtenerPlanesTarifarios():start");
			planes = planBO.obtenerPlanesTarifarios(param);
			logger.debug("obtenerPlanesTarifarios():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManProOffInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return planes;
		
	}

	public PlanTarifarioDTO obtenerTipoCobroPlanTarifario(
			PlanTarifarioDTO plan) throws ManProOffInvException {
		try {
					
			logger.debug("obtenerTipoCobroPlanTarifario():start");
			plan = planBO.obtenerTipoCobroPlanTarifario(plan);
			logger.debug("obtenerTipoCobroPlanTarifario():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManProOffInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return plan;
		
	}
	
	public ProductoOfertadoListDTO obtenerDetalleProductos(ProductoOfertadoListDTO productoOfertadoLista) throws ManProOffInvException {
		ProductoOfertadoListDTO prodOfertado = null;
		try {
					
			logger.debug("obtenerDetalleProductos():start");
			prodOfertado = prodOfertadoBO.obtenerDetalleProductos(productoOfertadoLista);
			logger.debug("obtenerDetalleProductos():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManProOffInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return prodOfertado;
	}
	public ProductoOfertadoListDTO obtenerProductosOfertablesPorPaquete(PaqueteDTO paquete) throws ManProOffInvException {
		ProductoOfertadoListDTO prodOfertado = null;
		try {
				
			logger.debug("obtenerDetalleProductos():start");
			prodOfertado = paqueteOfertadoBO.obtenerProductosOfertablesPorPaquete(paquete);
						
			for(int i=0;i<prodOfertado.getProductoList().length;i++)
			{
				prodOfertado.getProductoList()[i].setIndCondicionContratacion("O");												
			}	
			
			
			logger.debug("obtenerDetalleProductos():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManProOffInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return prodOfertado;
	}
	
	public ProductoOfertadoListDTO obtenerProductosOfertablesPaquetePorDefecto(PaqueteDTO paquete) throws ManProOffInvException {
		ProductoOfertadoListDTO prodOfertado = null;
		try {
			
			logger.debug("obtenerProductosOfertablesPaquetePorDefecto():start");
			prodOfertado = this.obtenerProductosOfertablesPorPaquete(paquete);
			int cantidadProductosTotal=0;
			
			
			for(int i=0;i<prodOfertado.getProductoList().length;i++)
			{
				prodOfertado.getProductoList()[i].setIndCondicionContratacion("D");
				prodOfertado.getProductoList()[i].setCantidadContratado(prodOfertado.getProductoList()[i].getCantidadDesplegado());
				cantidadProductosTotal=cantidadProductosTotal+prodOfertado.getProductoList()[i].getCantidadDesplegado();				
			}	
			
			ProductoOfertadoDTO listaOriginalProductos[]=new ProductoOfertadoDTO[cantidadProductosTotal];
			int indiceTotal=0;
			
			for(int i=0;i<prodOfertado.getProductoList().length;i++)
			{				
				for(int j=0;j<prodOfertado.getProductoList()[i].getCantidadContratado();j++)
				{
					listaOriginalProductos[indiceTotal]=prodOfertado.getProductoList()[i];
					indiceTotal++;
				}								
			}			
			
			prodOfertado.setProductoList(listaOriginalProductos);
			
			logger.debug("obtenerProductosOfertablesPaquetePorDefecto():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManProOffInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return prodOfertado;
	}

	public ReglasListaNumerosListDTO obtenerRestriccionesLista(EspecServicioListaDTO especServicioLista) throws ManProOffInvException {
		ReglasListaNumerosListDTO regListNumList =  null;
		try {
					
			logger.debug("obtenerDetalleProductos():start");
			regListNumList = especificacionServicioListaBO.obtenerReglasValidacion(especServicioLista);
			logger.debug("obtenerDetalleProductos():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManProOffInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return regListNumList;
	}
	
	public ProductoOfertadoListDTO obtenerProductosPorDefecto(AbonadoDTO abonado)throws ManProOffInvException {
		ProductoOfertadoListDTO prodOfertado = null;
		try {
			
			logger.debug("obtenerProductosOfertablesPorPaquete():start");
			prodOfertado = paqueteOfertadoBO.obtenerProductosOfertablesPorPaquete(abonado.getPlanTarifario().getPaqueteDefault());			
		
			logger.debug("obtenerProductosOfertablesPorPaquete():end");
			
			logger.debug("obtenerProductosPorDefecto():start");
			//resultado = prodOfertadoBO.obtenerDetalleProductos(prodOfertado); /* Se comenta pues ya se llamaba en el BO */
			
			for(int i=0;i<prodOfertado.getProductoList().length;i++)
			{
				prodOfertado.getProductoList()[i].setIndCondicionContratacion("D");												
			}	
			
			logger.debug("obtenerProductosPorDefecto():end");
			
		}
		catch(NullPointerException e)
		{
			logger.debug("NullPointerException[", e);
			logger.debug("No se ingreso el plan tarifario del abonado o el paquete por default en este");
		}
		catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManProOffInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return prodOfertado;
	}
	
	public ProductoOfertadoListDTO obtenerProductosOfertables(AbonadoDTO abonado) throws ManProOffInvException 
	{
		ProductoOfertadoListDTO prodOfertado = null;
		try {
				
			logger.debug("obtenerProductosOfertables():start");
			prodOfertado = catalogoBO.obtenerProductosOfertables(abonado);
			
			for(int i=0;i<prodOfertado.getProductoList().length;i++)
			{
				prodOfertado.getProductoList()[i].setIndCondicionContratacion("O");												
			}	
			
			logger.debug("obtenerProductosOfertables():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManProOffInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return prodOfertado;
	}

	public PlanTarifarioDTO obtenerDetallePlanTarif(PlanTarifarioDTO planTarif) throws ManProOffInvException 
	{		
		try {
				
			logger.debug("obtenerDetallePlanTarif():start");
			planTarif = planBO.obtenerDetallePlanTarif(planTarif);			
			logger.debug("obtenerDetallePlanTarif():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManProOffInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return planTarif;
	}

	public ProductoOfertadoListDTO obtenerProductosOfertablesporCanal(AbonadoDTO abonado) throws ManProOffInvException {
		ProductoOfertadoListDTO resultado = null;
		try {
			
			logger.debug("obtenerProductosOfertablesporCanal():start");
			resultado = catalogoBO.obtenerProductosOfertablesporCanal(abonado);			
			logger.debug("obtenerProductosOfertablesporCanal():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManProOffInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return resultado;
	}
	
	public ProductoOfertadoListDTO obtenerLCplanAdicional(ProductoOfertadoListDTO productoOfertadoLista) throws ManProOffInvException, GeneralException
	{
		
		ProductoOfertadoListDTO resultado = null;
		try {
			
			logger.debug("obtenerLimiteConsumoPlanAdicional():start");
			resultado = LimiteConsumoBO.obtenerLCplanAdicional(productoOfertadoLista);			
			logger.debug("obtenerLimiteConsumoPlanAdicional():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return resultado;
		
		
		
	}
	
	public LimiteConsumoProductoListDTO consultaAbonoLcProducto(LimiteConsumoProductoDTO limiteConsumoProducto)
	{
		
		LimiteConsumoProductoListDTO resultado = null;
		try {
			
			logger.debug("consultaAbonoLcProducto():start");
			resultado = LimiteConsumoBO.consultaAbonoLcProducto(limiteConsumoProducto);			
			logger.debug("consultaAbonoLcProducto():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			e.printStackTrace();
		}
		return resultado;
		
	}
	
	public TipoComportamientoListDTO obtenerTiposComportamiento() throws ManProOffInvException
	{
		
		TipoComportamientoListDTO resultado = null;
		try {
			
			logger.debug("obtenerTiposComportamiento():start");
			resultado = especificacionProductoBO.obtenerTiposComportamiento();			
			logger.debug("obtenerTiposComportamiento():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManProOffInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return resultado;
		
	}
	
	public ProductoScoringListDTO obtenerProductosScoring(Long numAbonado) throws ManProOffInvException
	{
		ProductoScoringListDTO resultado = null;
		try {
			
			logger.debug("obtenerProductosScoring():start");
			resultado = prodOfertadoBO.obtenerProductosScoring(numAbonado);			
			logger.debug("obtenerProductosScoring():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManProOffInvException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManProOffInvException(e);
		}
		return resultado;
	}
	
}
