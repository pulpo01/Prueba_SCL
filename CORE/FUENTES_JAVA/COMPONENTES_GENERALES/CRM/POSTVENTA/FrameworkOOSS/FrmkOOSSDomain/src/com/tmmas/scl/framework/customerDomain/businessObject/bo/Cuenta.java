package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.CuentaIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.CuentaDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.CuentaDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteTipoPlanListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SubCuentaListDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;

public class Cuenta implements CuentaIT{
	
	private CuentaDAOIT cuentaDAO = new CuentaDAO();
	
	private final Logger logger = Logger.getLogger(Cuenta.class);
	private Global global = Global.getInstance();	
	
	public ClienteTipoPlanListDTO obtenerDatosClienteCuenta(ClienteDTO cliente) throws CustomerException{
		ClienteTipoPlanListDTO listaClientes = null;
		try {
			logger.debug("obtenerDatosClienteCuenta():start");
			listaClientes = cuentaDAO.obtenerDatosClienteCuenta(cliente);
			logger.debug("obtenerDatosClienteCuenta():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return listaClientes;			
	}

	
	public SubCuentaListDTO obtenerSubCuentas(ClienteDTO cliente) throws CustomerException{
		SubCuentaListDTO listaSubcuentas = null;
		try {
			logger.debug("obtenerSubCuentas():start");
			listaSubcuentas = cuentaDAO.obtenerSubCuentas(cliente);
			logger.debug("obtenerSubCuentas():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return listaSubcuentas;		
	}
	
}
