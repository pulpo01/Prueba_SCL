package com.tmmas.scl.operations.crm.o.csr.supcusintman.srv;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.ProductoContratadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ContratanteBeneficiarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RestriccionesContratacionDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RestriccionesContratacionListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.RestriccionOtorgamientoBOFactory;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.interfaces.RestriccionOtorgamientoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.interfaces.RestriccionOtorgamientoIT;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.CategoriasNumeroDestinoBOFactory;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.CategoriasNumeroDestinoBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.CategoriasNumeroDestinoIT;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.common.exception.SupCusIntManException;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.srv.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.srv.interfaces.GestionValidacionesSrvIF;

public class GestionValidacionesSrv implements GestionValidacionesSrvIF {

	private final Logger logger = Logger.getLogger(GestionValidacionesSrv.class);
	
	private ProductoContratadoBOFactoryIT factoryBO1 = new ProductoContratadoBOFactory();
	private ProductoContratadoIT productoBO = factoryBO1.getBusinessObject1();
	
	private CategoriasNumeroDestinoBOFactoryIT factoryBO2=new CategoriasNumeroDestinoBOFactory();
	private CategoriasNumeroDestinoIT catNumDestBO=factoryBO2.getBusinessObject();
	
	private ClienteBOFactoryIT factoryBO3 = new ClienteBOFactory();
	private ClienteIT clienteBO = factoryBO3.getBusinessObject1();
	
	private RestriccionOtorgamientoBOFactoryIT factoryBO4 = new RestriccionOtorgamientoBOFactory();
	private RestriccionOtorgamientoIT restriccionBO = factoryBO4.getBusinessObject1();
	
	private Global global = Global.getInstance();
	
	public GestionValidacionesSrv(){
		String log = global.getValor("service.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}
	
	public RetornoDTO validaCuentaPersonal(CuentaPersonalDTO cuenta)
			throws SupCusIntManException {
		RetornoDTO retorno = null;
		try {
			
			logger.debug("validaCuentaPersonal():start");
			retorno = productoBO.validaCuentaPersonal(cuenta);
			logger.debug("validaCuentaPersonal():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupCusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupCusIntManException(e);
		}
		return retorno;	
	}

	public NumeroDTO obtenerTipoNumero(NumeroDTO numero) throws SupCusIntManException 
	{
		NumeroDTO retorno = null;
		try {
			logger.debug("obtenerTipoNumero():start");
			retorno = catNumDestBO.obtenerTipoNumero(numero);
			logger.debug("obtenerTipoNumero():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupCusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupCusIntManException(e);
		}
		return retorno;	
	}

	public ClienteDTO validarCliente(ClienteDTO cliente) throws SupCusIntManException 
	{
		ClienteDTO retorno = null;
		try {
			logger.debug("validarCliente():start");
			retorno = clienteBO.obtenerDatosCliente(cliente);
			logger.debug("validarCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupCusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupCusIntManException(e);
		}
		return retorno;	
	}
	 
	
	public RestriccionesContratacionListDTO obtenerRestriccionesContratacion(RestriccionesContratacionDTO restricciones) throws SupCusIntManException 
	{
		RestriccionesContratacionListDTO retorno = null;
		try {
			logger.debug("validarCliente():start");
			retorno = restriccionBO.obtenerRestriccionesContratacion(restricciones);
			logger.debug("validarCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupCusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupCusIntManException(e);
		}
		return retorno;	
	}
	
	public RetornoDTO validarContratanteBeneficiario(ContratanteBeneficiarioDTO contratanteBeneficiarioDTO) throws SupCusIntManException {
		RetornoDTO retorno = null;
		try {
			logger.debug("validaCuentaPersonal():start");
			retorno = productoBO.validarContratanteBeneficiario(contratanteBeneficiarioDTO);
			logger.debug("validaCuentaPersonal():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupCusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupCusIntManException(e);
		}
		return retorno;	
	}

}
