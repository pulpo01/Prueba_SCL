/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 30/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.operations.crm.fab.cim.mancon.srv;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.DatosClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.IntegracionInClasificacionDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.PlanEvaluacionRiesgoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srv.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srv.interfaces.GestionClienteSrvIF;


public class GestionClienteSrv implements GestionClienteSrvIF {

	private final Logger logger = Logger.getLogger(GestionClienteSrv.class);
	
	private ClienteBOFactoryIT factoryBO1 = new ClienteBOFactory();
	private ClienteIT clienteBO = factoryBO1.getBusinessObject1();
	
	private AbonadoBOFactoryIT factoryBO2 = new AbonadoBOFactory();
	private AbonadoIT abonadoBO = factoryBO2.getBusinessObject1();
	
	private Global global = Global.getInstance();	
	
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws ManConException {
		ClienteDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosCliente():start");
			respuesta = clienteBO.obtenerDatosCliente(cliente);
			logger.debug("obtenerDatosCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;
	}

	public ClienteListDTO buscarCliente(NumeroDTO numero) throws ManConException 
	{		
		ClienteListDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("buscarCliente():start");
			respuesta = clienteBO.buscarCliente(numero);
			logger.debug("buscarCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;
	}
	
	public ClienteListDTO buscarCliente(ClienteDTO cliente) throws ManConException 
	{		
		ClienteListDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("buscarCliente():start");
			respuesta = clienteBO.buscarCliente(cliente);
			logger.debug("buscarCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;
	}


	public ClienteDTO buscarDatosClientePorVenta(VentaDTO venta) throws ManConException 
	{		
		ClienteDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("buscarDatosClientePorVenta():start");
			respuesta = clienteBO.obtenerDatosPorVenta(venta);			
			logger.debug("buscarDatosClientePorVenta():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;
	}
   
	
	public int validaAtlantidaCliente(ClienteDTO cliente) throws ManConException {
		int respuesta = 0;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaAtlantidaCliente():start");
			respuesta = abonadoBO.validaAtlantidaCliente(cliente);			
			logger.debug("validaAtlantidaCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;
	}
	
	
	public int validaAtlantida(AbonadoDTO abonado) throws ManConException {
		int respuesta = 0;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaAtlantida():start");
			respuesta = abonadoBO.validaAtlantida(abonado);			
			logger.debug("validaAtlantida():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;
	}

	public ClienteDTO obtenerCliente(CuentaPersonalDTO cuentaPersonalDTO) throws ManConException {
		ClienteDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerCliente():start");
			respuesta = abonadoBO.obtenerCliente(cuentaPersonalDTO);			
			logger.debug("obtenerCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;
	}	
	
	public ClienteDTO obtenerNumAbonadosCliente(ClienteDTO cliente) throws ManConException{
		ClienteDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerNumAbonadosCliente():start");
			respuesta = clienteBO.obtenerNumAbonadosCliente(cliente);			
			logger.debug("obtenerNumAbonadosCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;		
	}
	
	public RetornoDTO actualizarLineasPorPlan(PlanEvaluacionRiesgoDTO planEval) throws ManConException {
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarLineasPorPlan():start");
			respuesta = clienteBO.actualizarLineasPorPlan(planEval);
			logger.debug("actualizarLineasPorPlan():end");
		} 
		catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;
	}

	public DatosClienteDTO obtenerDatosAdicCliente(Long codCliente) throws ManConException {
		DatosClienteDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosAdicCliente():start");
			respuesta = clienteBO.obtenerDatosAdicCliente(codCliente);
			logger.debug("obtenerDatosAdicCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;
	}

	
	 public IntegracionInClasificacionDTO consultaClasificacionCliente(IntegracionInClasificacionDTO integracionInClasificacionDTO) throws ManConException{
		 IntegracionInClasificacionDTO retValue = null;
			try {
				String log = global.getValor("service.log");
				log = System.getProperty("user.dir") + log;
				PropertyConfigurator.configure(log);		
				logger.debug("consultaClasificacionCliente():start");
				retValue = clienteBO.consultaClasificacionCliente(integracionInClasificacionDTO);
				logger.debug("consultaClasificacionCliente():end");
			} 
			catch (GeneralException e) {
				logger.debug("GeneralException[", e);
				throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			}
			catch (Exception e) {
				logger.debug("Exception[", e);
				throw new ManConException(e);
			}
			return retValue;
	 }

	public ClienteDTO getCliente(ClienteDTO cliente) throws ManConException 
	{		
		ClienteDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getCliente():start");
			respuesta = clienteBO.getCliente(cliente);			
			logger.debug("getCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;
	}
}
