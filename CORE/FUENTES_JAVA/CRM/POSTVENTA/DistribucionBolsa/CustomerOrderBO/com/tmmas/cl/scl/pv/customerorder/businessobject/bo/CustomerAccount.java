/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 14/08/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.pv.customerorder.businessobject.bo;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
//import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.businessobject.dao.CustomerAccountDAO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.SecurityDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;
//import com.tmmas.cl.scl.pv.customerorder.negocio.cliente.ClienteEjb;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.ProductDomainException;

public class CustomerAccount {
	private CustomerAccountDAO customerAccountDAO  = new CustomerAccountDAO();
	//private static Category cat = Category.getInstance(CustomerAccount.class);
	
	/**
	 * Obtiene la lista de servicios suplementarios contratados
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */
	
	
	//private static Logger logger = Logger.getLogger(CustomerAccount.class);
	private static Category logger = Category.getInstance(CustomerAccount.class);
	private CompositeConfiguration config;
	
	private void setLog() {
//		 inicio MA
		String strRuta = "/com/tmmas/cl/CustomerOrderBO/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderBO.properties";
		String strArchivoLog="CustomerOrderBO.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio CommentariesAction");
		// fin MA	
	}
	
	private void CustomerAccount() { // MA
		setLog(); //MA
	}
	
	
	public ProductListDTO getInstalledCustomerAccountProductBundle(CustomerAccountDTO cust) throws CustomerOrderException {
		ProductListDTO resultado = null;
		logger.debug("getInstalledCustomerAccountProductBundle():start");
		
		if(cust.isSinLC())
		{
			logger.debug("Consultar solo servicios con limite de consumo (SLC)");
			resultado = customerAccountDAO.getInstalledCustomerAccountProductBundleSLC(cust);	//SLC significa que consule los servicios pero que omita los que no tienen limite de consumo
		}else{
			logger.debug("Consultar todos los servicios");
			resultado = customerAccountDAO.getInstalledCustomerAccountProductBundle(cust);
		}
		logger.debug("getInstalledCustomerAccountProductBundle():end");
		return resultado;
	}
	

	/**
	 * Guarda la lista de servicios suplementarios contratados
	 * @param prodList
	 * @throws CustomerOrderException
	 */
	public void setInstalledCustomerAccountProductBundle(ProductListDTO prodList) throws CustomerOrderException {
		logger.debug("setInstalledCustomerAccountProductBundle():start");
		customerAccountDAO.setInstalledCustomerAccountProductBundle(prodList);
		logger.debug("setInstalledCustomerAccountProductBundle():end");		
	}

	
	/**
	 * Obtiene una lista de servicios no contratados
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */	
	public ProductListDTO getUnInstalledCustomerAccountProductBundle(CustomerAccountDTO cust) throws CustomerOrderException {
		logger.debug("getUnInstalledCustomerAccountProductBundle():start");
		ProductListDTO resultado = customerAccountDAO.getUnInstalledCustomerAccountProductBundle(cust);
		logger.debug("getUnInstalledCustomerAccountProductBundle():end");
		return resultado;
	}	
	
	
	/**
	 * Obtiene los datos del cliente
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */
	public CustomerAccountDTO getCustomerAccountData(CustomerAccountDTO cust) throws CustomerOrderException {
		logger.debug("getCustomerAccountData():start");
		CustomerAccountDTO resultado = customerAccountDAO.getCustomerAccountData(cust);
		logger.debug("getCustomerAccountData():end");
		return resultado;
	}

	/**
	 * Valida la seguridad dado un id de seguridad
	 * @param seg
	 * @return
	 * @throws CustomerOrderException
	 */
	public SecurityDTO getSecurityData(SecurityDTO seg) throws CustomerOrderException {
		logger.debug("getSecurityData():start");
		SecurityDTO resultado = customerAccountDAO.getSecurityData(seg);
		logger.debug("getSecurityData():end");
		return resultado;
	}

	/**
	 * Guarda la lista de servicios contratados
	 * @param prodList
	 * @throws CustomerOrderException
	 */
	public void setInstalledProductBundleList(ProductListDTO prodList) throws CustomerOrderException {
		logger.debug("setInstalledProductBundleList():start");
		customerAccountDAO.setInstalledProductBundleList(prodList);
		logger.debug("setInstalledProductBundleList():end");		
	}	

	/**
	 * Guarda la lista de servicios no contratados
	 * @param prodList
	 * @throws CustomerOrderException
	 */
	public void setUnInstallProductBundleList(ProductListDTO prodList) throws CustomerOrderException {
		logger.debug("setUnInstallProductBundleList():start");
		customerAccountDAO.setUnInstallProductBundleList(prodList);
		logger.debug("setUnInstallProductBundleList():end");		
	}	

	/**
	 * Obtiene los Planes Distribuidos para el cliente
	 * @param prodList
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO[] obtenerPlanesDistribuidos(Long codigoCliente) throws ProductDomainException
	{
		logger.info("obtenerPlanesDistribuidos:star");
		PlanTarifarioDTO[]  resultado = customerAccountDAO.obtenerPlanesDistribuidos(codigoCliente);
		logger.info("obtenerPlanesDistribuidos:star");		
		return resultado;
	}
	
	/**
	 * Obtiene Datos de la Bolsa
	 * @param codPlanTarif
	 * @throws ProductDomainException
	 */
	public DistribucionBolsaDTO obtenerDatosBolsa(String codPlanTarif) throws ProductDomainException
	{
		logger.info("obtenerDatosBolsa:star");
		DistribucionBolsaDTO  resultado = customerAccountDAO.obtenerDatosBolsa(codPlanTarif);
		logger.info("obtenerDatosBolsa:star");		
		return resultado;
	}
	
}
