package com.tmmas.scl.operations.crm.fab.cim.mancon.srvcta;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.CuentaBOFactory;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.CuentaBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.CuentaIT;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteTipoPlanListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.SubCuentaDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.SubCuentaListDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srvcta.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srvcta.interfaces.GestionCuentaSrvIF;

public class GestionCuentaSrv implements GestionCuentaSrvIF {

	private final Logger logger = Logger.getLogger(GestionCuentaSrv.class);
	
	private CuentaBOFactoryIT factoryBO1 = new CuentaBOFactory();	
	private CuentaIT cuentaBO = factoryBO1.getBusinessObject1();
	
	private AbonadoBOFactoryIT factoryBO2 = new AbonadoBOFactory();
	private AbonadoIT abonadoBO = factoryBO2.getBusinessObject1();
	
	private Global global = Global.getInstance();	
	
	public ClienteTipoPlanListDTO obtenerDatosClienteCuenta(ClienteDTO cliente) throws ManConException{
		ClienteTipoPlanListDTO listaClientes = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosClienteCuenta():start");
			listaClientes = cuentaBO.obtenerDatosClienteCuenta(cliente);
			logger.debug("obtenerDatosClienteCuenta():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return listaClientes;		
	}
	
	public SubCuentaListDTO obtenerSubCuentas(ClienteDTO cliente) throws ManConException{
		SubCuentaListDTO listaSubcuentas= null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerSubCuentas():start");
			listaSubcuentas = cuentaBO.obtenerSubCuentas(cliente);
			logger.debug("obtenerSubCuentas():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return listaSubcuentas;		
	}
	
	public RetornoDTO crearSubCuenta(SubCuentaDTO cuenta) throws ManConException{
		RetornoDTO retorno= null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			
			cuenta.setCodSubCuenta(cuenta.getCodCuenta() + ".1");
			logger.debug("obtenerSubCuentas():start");
			retorno = cuentaBO.crearSubCuenta(cuenta);
			logger.debug("obtenerSubCuentas():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return retorno;	
	}
	
	public int obtenerInfoPer(CuentaPersonalDTO cuentaPersonalDTO) throws ManConException{
		int retorno= 0;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			
			logger.debug("obtenerInfoPer():start");
			retorno = abonadoBO.obtenerInfoPer(cuentaPersonalDTO);
			logger.debug("obtenerInfoPer():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return retorno;	
	}
	
	public int validaPersonal(CuentaPersonalDTO cuentaPersonalDTO)throws ManConException{
		int retorno= 0;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			
			logger.debug("validaPersonal():start");
			retorno = abonadoBO.validaPersonal(cuentaPersonalDTO);
			logger.debug("validaPersonal():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return retorno;	
	}
	
	public Long obtenerNumClientesCuenta(ClienteDTO cliente)throws ManConException{
		Long retorno;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			
			logger.debug("obtenerNumClientesCuenta():start");
			retorno = cuentaBO.obtenerNumClientesCuenta(cliente);
			logger.debug("obtenerNumClientesCuenta():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return retorno;			
	}
	
	public ClienteListDTO listarClientesCuenta(ClienteDTO cliente)throws ManConException{
		ClienteListDTO retorno= null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			
			logger.debug("listarClientesCuenta():start");
			retorno = cuentaBO.listarClientesCuenta(cliente);
			logger.debug("listarClientesCuenta():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return retorno;		
	}
}
