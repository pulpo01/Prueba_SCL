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
package com.tmmas.cl.scl.pv.customerorder.service.servicios;

import org.apache.log4j.Category;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.businessobject.bo.CustomerAccount;
import com.tmmas.cl.scl.pv.customerorder.businessobject.bo.CustomerOrder;
import com.tmmas.cl.scl.pv.customerorder.businessobject.bo.ProductBundle;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.OrdenServicioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ReglasSSDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.SecurityDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.ProductDomainException;
//import com.tmmas.cl.scl.pv.customerorder.web.action.CommentariesAction;

//INICIO MA
//import org.apache.log4j.Category;
import org.apache.commons.configuration.CompositeConfiguration;
	
public class CustomerOrderService {
	private CustomerAccount customerAccountBO = new CustomerAccount();

	private CustomerOrder customerOrderBO = new CustomerOrder();
	
	private ProductBundle productBundleBO = new ProductBundle();


	/**
	 * Obtiene la lista de servicios suplementarios contratados
	 * 
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */
	
	private static Category logger = Category.getInstance(CustomerOrderService.class);
	private CompositeConfiguration config;
	
	private void setLog() {
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio CommentariesAction");	
	}
	
	public ProductListDTO getInstalledCustomerAccountProductBundle(CustomerAccountDTO cust) 
		throws CustomerOrderException 
	{		
		setLog();		
		logger.debug("getInstalledCustomerAccountProductBundle():start");
		ProductListDTO resultado = customerAccountBO.getInstalledCustomerAccountProductBundle(cust);
		logger.debug("getInstalledCustomerAccountProductBundle():end");
		return resultado;
	}



	/**
	 * Guarda la lista de servicios suplementarios contratados
	 * 
	 * @param prodList
	 * @throws CustomerOrderException
	 */
	public void setInstalledCustomerAccountProductBundle(ProductListDTO prodList)
		throws CustomerOrderException 
	{		
		setLog();		
		logger.debug("setInstalledCustomerAccountProductBundle():start");
		customerAccountBO.setInstalledCustomerAccountProductBundle(prodList);
		logger.debug("setInstalledCustomerAccountProductBundle():end");
	}

	/**
	 * Obtiene una lista de servicios no contratados
	 * 
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */
	public ProductListDTO getUnInstalledCustomerAccountProductBundle(CustomerAccountDTO cust) 
		throws CustomerOrderException 
	{		
		setLog();		
		logger.debug("getUnInstalledCustomerAccountProductBundle():start");
		ProductListDTO resultado = customerAccountBO.getUnInstalledCustomerAccountProductBundle(cust);
		logger.debug("getUnInstalledCustomerAccountProductBundle():end");
		return resultado;
	}

	/**
	 * Obtiene las reglas de validacion de servicios suplementarios
	 * 
	 * @return
	 * @throws CustomerOrderException
	 */
	public ReglasSSDTO[] getReglasdeValidacionSS()
		throws CustomerOrderException 
	{		
		setLog();		
		logger.debug("getReglasdeValidacionSS():start");
		ReglasSSDTO[] resultado = productBundleBO.getReglasdeValidacionSS();
		logger.debug("getReglasdeValidacionSS():end");
		return resultado;
	}

	/**
	 * Obtiene los datos del cliente
	 * 
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */
	public CustomerAccountDTO getCustomerAccountData(CustomerAccountDTO cust)
		throws CustomerOrderException 
	{		
		setLog();		
		logger.debug("getCustomerAccountData():start");
		CustomerAccountDTO resultado = customerAccountBO.getCustomerAccountData(cust);
		logger.debug("getCustomerAccountData():end");
		return resultado;
	}

	/**
	 * Valida la seguridad dado un id de seguridad
	 * 
	 * @param seg
	 * @return
	 * @throws CustomerOrderException
	 */
	public SecurityDTO getSecurityData(SecurityDTO seg)
		throws CustomerOrderException 
	{		
		setLog();		
		logger.debug("getSecurityData():start");
		SecurityDTO resultado = customerAccountBO.getSecurityData(seg);
		logger.debug("getSecurityData():end");
		return resultado;
	}

	/**
	 * Guarda la lista de servicios contratados y no contratados
	 * 
	 * @param prodList
	 * @throws CustomerOrderException
	 */
	public void setCustomerAccountProductBundle(ProductListDTO prodList)
			throws CustomerOrderException 
	{		
		setLog();		
		logger.debug("setCustomerAccountProductBundle():start");
		logger.debug("setInstalledProductBundleList():start");
		customerAccountBO.setInstalledProductBundleList(prodList);
		logger.debug("setInstalledProductBundleList():end");
		logger.debug("setUnInstallProductBundleList():start");
		customerAccountBO.setUnInstallProductBundleList(prodList);
		logger.debug("setUnInstallProductBundleList():end");
		logger.debug("setCustomerAccountProductBundle():end");
	}

	/**
	 * Guarda la informacion de la orden de servicio
	 * @param oS
	 * @throws CustomerOrderException
	 */
	public void saveCustomerOrderProduct(OrdenServicioDTO oS)
		throws CustomerOrderException 
	{		
		setLog();		
		logger.debug("saveCustomerOrderProduct():start");
		customerOrderBO.saveCustomerOrderProduct(oS);
		logger.debug("saveCustomerOrderProduct():end");
	}
	
	/**
	 * Obtiene los Planes Distribuidos para el cliente
	 * @param prodList
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO[] obtenerPlanesDistribuidos(Long codigoCliente) 
		throws ProductDomainException
	{
		setLog();
		logger.debug("obtenerPlanesDistribuidos():Inicio");		
		PlanTarifarioDTO[] resultado = customerAccountBO.obtenerPlanesDistribuidos(codigoCliente);		
		logger.debug("obtenerPlanesDistribuidos():Fin");	
		return resultado;
	}
	
	/**
	 * Obtiene Datos de la Bolsa
	 * @param codPlanTarif
	 * @throws ProductDomainException
	 */
	public DistribucionBolsaDTO obtenerDatosBolsa(String codPlanTarif) throws ProductDomainException
	{
		setLog();
		logger.debug("obtenerDatosBolsa():Inicio");		
		DistribucionBolsaDTO resultado = customerAccountBO.obtenerDatosBolsa(codPlanTarif);		
		logger.debug("obtenerDatosBolsa():Fin");	
		return resultado;
	}
	
}
