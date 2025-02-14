/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 30/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.bo;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.dao.ClienteDAO;
import com.tmmas.scl.framework.customerDomain.dao.interfaces.ClienteDAOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.customerDomain.helper.Global;


public class Cliente implements ClienteIT
{

	private ClienteDAOIT clienteDAO = new ClienteDAO();
	private final Global global = Global.getInstance();		
	private final Logger logger = Logger.getLogger(Cliente.class);
	
	
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CustomerException{
		
		ClienteDTO respuesta = null;
		try {
			logger.debug("obtenerDatosCliente():start");
			respuesta = clienteDAO.obtenerDatosCliente(cliente);
			logger.debug("obtenerDatosCliente():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return respuesta;	
	}


	/**
	 * Obtiene los datos del cliente para las OOSS Aviso y Anulacion de Siniestro.
	 * Package: PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE2_PR
	 * @param cliente del tipo ClienteDTO
	 * @return ClienteDTO
	 * @throws CustomerException
	 * @author Santiago Ventura
	 * @date 15-04-2010 
	 */
	public ClienteDTO obtenerDatosCliente2(ClienteDTO cliente) throws CustomerException {
		ClienteDTO respuesta = null;
		try {
			logger.debug("obtenerDatosCliente2():start");
			respuesta = clienteDAO.obtenerDatosCliente2(cliente);
			logger.debug("obtenerDatosCliente2():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return respuesta;	
	}
	

}
