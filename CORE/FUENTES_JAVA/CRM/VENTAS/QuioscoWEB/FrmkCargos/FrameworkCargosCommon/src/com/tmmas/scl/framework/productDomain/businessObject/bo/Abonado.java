package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.itermediario.AbonadoDTOInt;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.AbonadoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.AbonadoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroVentaDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class Abonado implements AbonadoIT {

	private AbonadoDAOIT abonadoDAO = new AbonadoDAO();
	
	private final Logger logger = Logger.getLogger(Abonado.class);
	private Global global = Global.getInstance();

	public AbonadoListDTO obtenerListaAbonados(ClienteDTO cliente)
			throws ProductException {

		AbonadoListDTO planes = null;
		try {
			logger.debug("obtenerListaAbonados():start");
			planes = abonadoDAO.obtenerListaAbonados(cliente);
			logger.debug("obtenerListaAbonados():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return planes;	
		
	}

	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws ProductException{
		
		AbonadoDTO respuesta = null;
		try {
			logger.debug("obtenerDatosAbonado():start");
			respuesta = abonadoDAO.obtenerDatosAbonado(abonado);
			logger.debug("obtenerDatosAbonado():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;	
		
	}		
	
	public void updCodigoSituacion(AbonadoDTO abonado) throws ProductException {
		try {
			logger.debug("updCodigoSituacion():start");
			abonadoDAO.updCodigoSituacion(abonado);
			logger.debug("updCodigoSituacion():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
	}
	
	public AbonadoDTOInt[] getListaAbonadosVenta(RegistroVentaDTO registroventa) throws ProductException{
		AbonadoDTOInt[] retValue=null;
		try{
			retValue=abonadoDAO.getListaAbonadosVenta(registroventa);
		}catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return retValue;
	}
	
	public AbonadoDTOInt[] getListaAbonadosVentaNoKit(RegistroVentaDTO registroventa) throws ProductException{
		AbonadoDTOInt[] retValue=null;
		try{
			retValue=abonadoDAO.getListaAbonadosVentaNoKit(registroventa);
		}catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return retValue;
	}
	
	public AbonadoDTOInt[] getListaAbonadosVentaKit(RegistroVentaDTO registroventa) throws ProductException{
		AbonadoDTOInt[] retValue=null;
		try{
			retValue=abonadoDAO.getListaAbonadosVentaKit(registroventa);
		}catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return retValue;
	}

}
