/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 30/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.ClienteDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.ClienteDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;


public class Cliente implements ClienteIT
{

	private ClienteDAOIT clienteDAO = new ClienteDAO();
	
	private AbonadoBOFactoryIT abonadoFactory=new AbonadoBOFactory();
	private AbonadoIT abonadoBO=abonadoFactory.getBusinessObject1();
	
	private RegistroFacturacionBOFactoryIT regFactFactory=new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT regFactBO=regFactFactory.getBusinessObject1();
	
	private final Logger logger = Logger.getLogger(Cliente.class);
	private Global global = Global.getInstance();	
	
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
	
	public ClienteDTO obtenerCategoriaTributaria(ClienteDTO cliente) throws CustomerException{
		ClienteDTO retorno = null;
		try {
			logger.debug("obtenerCategoriaTributaria():start");
			retorno = clienteDAO.obtenerCategoriaTributaria(cliente);
			logger.debug("obtenerCategoriaTributaria():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retorno;		
	}
	/**
	 *Obtiene Datos del Cliente
	 * 
	 * @param cliente
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO getCliente(ClienteDTO cliente) throws CustomerException {
		ClienteDTO resultado = new ClienteDTO();
		logger.debug("getCliente():start");
		resultado = clienteDAO.getCliente(cliente);
		logger.debug("getCliente():end");
		return resultado;
	}

	
	
}
