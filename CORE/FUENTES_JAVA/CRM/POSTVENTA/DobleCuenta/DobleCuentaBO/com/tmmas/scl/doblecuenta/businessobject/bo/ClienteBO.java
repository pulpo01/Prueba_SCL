package com.tmmas.scl.doblecuenta.businessobject.bo;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.ClienteBOIT;
import com.tmmas.scl.doblecuenta.businessobject.dao.ClienteDAO;
import com.tmmas.scl.doblecuenta.businessobject.dao.interfaces.ClienteDAOIT;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClientesAsociadosDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.RetornoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;

public class ClienteBO implements ClienteBOIT{
	
	private final Logger logger = Logger.getLogger(ClienteBO.class);
	private ClienteDAOIT clienteDAO = new ClienteDAO();
	
    private CompositeConfiguration config; // MA
	
	private void setPropertieFile() {
//		  inicio MA
		     String strRuta = "/com/tmmas/cl/DobleCuentaBo/properties/";
		     String srtRutaDeploy = System.getProperty("user.dir");
		     String strArchivoProperties= "DobleCuentaBo.properties";
		     String strArchivoLog="DobleCuentaBo.log";
		     String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
		     config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		     UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		     // fin MA           
	}
	
	public ClienteDTO[] obtenerListaClientesAsociados(ClienteDTO cliente) throws ProyectoException {
		
		setPropertieFile();//MA
		
		System.out.println("entramos con exito obtenerListaClientesAsociadosBO");
		ClienteDTO[] clienteList = null;
		try{
			logger.debug("obtenerListaClientesAsociadosBO():start");
			clienteList = clienteDAO.obtenerListaClientesAsociados(cliente);
			logger.debug("obtenerListaClientesAsociadosBO():end");
		} catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito obtenerListaClientesAsociadosBO");
		return clienteList;
	}
	
	public ClienteDTO obtenerInformacionCliente(ClienteDTO clienteContratante) throws ProyectoException{
		
		
		setPropertieFile();//MA
		
		System.out.println("entramos con exito obtenerInformacionClienteBO");
		ClienteDTO cliente = null;
		try{
			logger.debug("obtenerInformacionClienteBO():start");
			cliente = clienteDAO.obtenerInformacionCliente(clienteContratante);
			logger.debug("obtenerInformacionClienteBO():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito obtenerInformacionClienteBO");
		return cliente;
	}

	public ClientesAsociadosDTO[] buscarClientesAsociados(ClienteDTO clienteContratante) throws ProyectoException {
		
		setPropertieFile();//MA
		
		System.out.println("entramos con exito buscarClientesAsociadosBO");
		ClientesAsociadosDTO[] clientes = null;
		try{
			logger.debug("buscarClientesAsociadosBO():start");
			clientes = clienteDAO.buscarClientesAsociados(clienteContratante);
			logger.debug("buscarClientesAsociadosBO():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito buscarClientesAsociadosBO");
		return clientes;
	}
	
	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO parametro) throws ProyectoException	{
		
		setPropertieFile();//MA
		
		System.out.println("entramos con exito obtenerSecuencia BO");
		SecuenciaDTO respuesta = null;
		try{
			logger.debug("obtenerInformacionClienteBO():start");
				respuesta = clienteDAO.obtenerSecuencia(parametro);
			logger.debug("obtenerInformacionClienteBO():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito  obtenerSecuencia BO");
		return respuesta;
	}	
}
