package com.tmmas.scl.operations.crm.b.bcm.mancol.srv;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.OrdenServicioBOFactory;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.SCLPlanBasicoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.CargoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.interfaces.CargoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ValidaPlanFreedomDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.EspecificacionProductoBOFactory;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.interfaces.EspecificacionProductoIT;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.exception.ProductSpecificationException;
import com.tmmas.scl.operations.crm.b.bcm.mancol.common.exception.ManColException;
import com.tmmas.scl.operations.crm.b.bcm.mancol.srv.helper.Global;
import com.tmmas.scl.operations.crm.b.bcm.mancol.srv.interfaces.GestionRecopilacionInformacionSrvIF;

public class GestionRecopilacionInformacionSrv implements
		GestionRecopilacionInformacionSrvIF {

	private final Logger logger = Logger.getLogger(GestionRecopilacionInformacionSrv.class);
	private Global global = Global.getInstance();

	private CargoBOFactoryIT factoryBO1 = new CargoBOFactory();
	private CargoIT cargoBO = factoryBO1.getBusinessObject1();
	
	private OrdenServicioBOFactoryIT factoryBO2 = new OrdenServicioBOFactory();
	private OrdenServicioIT ordenServicioBO = factoryBO2.getBusinessObject1();

	private ClienteBOFactoryIT factoryBO3 = new ClienteBOFactory();
	private ClienteIT clienteBO = factoryBO3.getBusinessObject1();

	private EspecificacionProductoBOFactory factoryBO4 = new EspecificacionProductoBOFactory();
	private EspecificacionProductoIT especificacionProducto = factoryBO4.getBusinessObject();
	
	private SCLPlanBasicoBOFactory factoryBO5 = new SCLPlanBasicoBOFactory();
	private SCLPlanBasicoIT planBO = factoryBO5.getBusinessObject1();


	public DocumentoListDTO obtenerTiposDocumentos(BusquedaTiposDocumentoDTO param) throws ManColException{
		
		DocumentoListDTO documentos = null;
		try{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerTiposDocumentos():start");
			param.setIndAgente(global.getValor("valor.columna.ind_agente"));
			param.setIndSituacion(global.getValor("valor.columna.ind_situacion"));
			param.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
			param.setCodAmiCiclo(global.getValor("parametro.amiciclo"));
			param.setCodModulo(global.getValor("codigo.modulo.GA"));
			documentos = cargoBO.obtenerTiposDocumentos(param);
			logger.debug("obtenerTiposDocumentos():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManColException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManColException(e);
		}
		return documentos;			
	}
	
	public FormaPagoListDTO obtenerFormasPago(BusquedaFormasPagoDTO param) throws ManColException{
		FormaPagoListDTO documentos = new FormaPagoListDTO();
		try{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerFormasPago():start");
			
			int codProducto = Integer.parseInt(global.getValor("codigo.producto"));
			String codModulo = global.getValor("codigo.modulo.GA");
			String paramMostrarTipoPago = global.getValor("parametro.mostrartipopago");
			String paramCodigoOrdenCompra = global.getValor("parametro.codigoordencompra");
			
			//Obtencion parametro mostrar tipo de pago
			ParametroDTO parametro = new ParametroDTO();
			parametro.setCodProducto(codProducto);
			parametro.setCodModulo(codModulo);
			parametro.setNomParametro(paramMostrarTipoPago);
			parametro = ordenServicioBO.obtenerParametroGeneral(parametro);
		
			if (parametro.getValor().equalsIgnoreCase("1")){
				ParametroDTO parametroCodOrdCompra = new ParametroDTO();
				
		 		ClienteDTO cliente = new ClienteDTO();
		 		cliente.setCodCliente(param.getCodCliente()); //parametro de entrada
		 		
				// 1.- Ver si la venta tiene planes freedom asociados
				boolean existePlanFreedomEnVenta  = planBO.validaFreedom(cliente).isResultado();

				// 2.- Consultar la categoria tributaria del cliente (Factura F, o Boleta B)
		 		cliente =  clienteBO.obtenerCategoriaTributaria(cliente);
				
				// 3.- Obtener el parametro orden de compra. 
		 		parametroCodOrdCompra.setCodProducto(codProducto);
		 		parametroCodOrdCompra.setCodModulo(codModulo);
		 		parametroCodOrdCompra.setNomParametro(paramCodigoOrdenCompra);
		 		parametroCodOrdCompra = ordenServicioBO.obtenerParametroGeneral(parametroCodOrdCompra);

				// Obtencion de las formas de pago
		 		param.setExistePlanFreedom((existePlanFreedomEnVenta?"TRUE":"FALSE"));
		 		param.setCategoriaTributaria(cliente.getCodCategoria());
		 		param.setParamOrdenCompraValor(parametroCodOrdCompra.getValor());
		 		documentos = cargoBO.obtenerFormasPago(param);
			}
			
			logger.debug("obtenerFormasPago():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManColException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManColException(e);
		}
		return documentos;	
	}
	
	public CuotasProductoDTO[] obtenerCuotasProducto() throws ManColException {
		String log = global.getValor("service.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCuotasProducto():start");
		logger.debug("obtenerCuotasProducto():end");
		CuotasProductoDTO[] cuotasProducto = null;
		
			try {
				cuotasProducto = especificacionProducto.obtenerCuotasProducto();
			} catch (ProductSpecificationException e) {
				logger.debug("GeneralException[", e);
				throw new ManColException(e);
			}catch (Exception e) {
				logger.debug("Exception[", e);
				throw new ManColException(e);
			}

		
		return cuotasProducto;
	}

	public int obtenerInfoAtl(CuentaPersonalDTO cuentaPersonalDTO) throws ManColException {
		int retorno = 0;
			try {
				String log = global.getValor("service.log");
				log = global.getPathInstancia() + log;
				PropertyConfigurator.configure(log);		
				logger.debug("obtenerInfoAtl():start");				
				retorno = planBO.obtenerInfoAtl(cuentaPersonalDTO);
				logger.debug("obtenerInfoAtl():end");				
			} catch (GeneralException e) {
				logger.debug("GeneralException[", e);
				throw new ManColException(e);
			}catch (Exception e) {
				logger.debug("Exception[", e);
				throw new ManColException(e);
			}

		
		return retorno;
	}
}
