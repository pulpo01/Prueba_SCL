package com.tmmas.scl.framework.customerDomain.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.VendedorBOIT;
import com.tmmas.scl.framework.customerDomain.dao.VendedorDAO;
import com.tmmas.scl.framework.customerDomain.dao.interfaces.VendedorDAOIT;
import com.tmmas.scl.framework.customerDomain.dto.VendedorDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;


public class VendedorBO implements VendedorBOIT{

	private VendedorDAOIT VendedorDAO = new VendedorDAO();
	private final Logger logger = Logger.getLogger(VendedorDAO.class);
	
	
	public VendedorDTO obtenerEstadoVendedor(VendedorDTO Vendedor) throws CustomerException {

		VendedorDTO respuesta = null;
		try {
			logger.debug("obtenerTiposDeContrato():start");
			respuesta = VendedorDAO.obtenerEstadoVendedor(Vendedor);
			logger.debug("obtenerTiposDeContrato():end");
		} catch (CustomerException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return respuesta;			

	}
	
	public void bloquearVendedor(VendedorDTO Vendedor) throws CustomerException {

		try {
			logger.debug("obtenerTiposDeContrato():start");
			VendedorDAO.bloquearVendedor(Vendedor);
			logger.debug("obtenerTiposDeContrato():end");
		} catch (CustomerException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}					
	}
	
	public void desbloquearVendedor(VendedorDTO Vendedor) throws CustomerException {

		try {
			logger.debug("obtenerTiposDeContrato():start");
			VendedorDAO.desbloquearVendedor(Vendedor);
			logger.debug("obtenerTiposDeContrato():end");
		} catch (CustomerException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
	}	
	
	public void validaVendedorbodega(VendedorDTO vendedor, SesionDTO sesion, BodegaDTO bodega) throws CustomerException{
		try {
			logger.debug("obtenervalidaVendedorbodegaTiposDeContrato():start");
			VendedorDAO.validaVendedorbodega(vendedor,sesion,bodega);
			logger.debug("validaVendedorbodega():end");
		} catch (CustomerException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
			
	}
	
}
