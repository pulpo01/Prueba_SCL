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
 * 07/09/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.pv.customerorder.service.servicios;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
//import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.businessobject.bo.InvolvementProductBundle;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.AbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;

public class InvolvementProductBundleService {
	private InvolvementProductBundle involvementProductBundle = new InvolvementProductBundle();

	//private static Category cat = Category.getInstance(InvolvementProductBundleService.class);

	/**
	 * Recupera los datos del abonado por numero de abonado asi como la
	 * informacion del cliente
	 * 
	 * @param abo
	 * @return
	 * @throws CustomerOrderException
	 */
	
	//private static Logger logger = Logger.getLogger(InvolvementProductBundle.class);
	private static Category logger = Category.getInstance(InvolvementProductBundleService.class);
	
	private CompositeConfiguration config;
	
	private void setLog() {
//		 inicio MA
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio CommentariesAction");
		// fin MA	
	}
	
	public InvolvementProductBundleService() {
		setLog();
	}
	
	public CustomerAccountDTO getInvolvementProductBundletData(AbonadoDTO abo)
			throws CustomerOrderException {
		logger.debug("getInvolvementProductBundletData():start");
		CustomerAccountDTO respuesta = involvementProductBundle
				.getInvolvementProductBundletData(abo);
		logger.debug("getInvolvementProductBundletData():end");
		return respuesta;
	}

	/**
	 * Obtiene la lista de servicios suplementarios contratados por abonado
	 * 
	 * @param abo
	 * @return
	 * @throws CustomerOrderException
	 */
	public ProductListDTO getInstalledInvolvementProductBundle(AbonadoDTO abo)
			throws CustomerOrderException {
		logger.debug("getInstalledInvolvementProductBundle():start");
		ProductListDTO respuesta = involvementProductBundle
				.getInstalledInvolvementProductBundle(abo);
		logger.debug("getInstalledInvolvementProductBundle():end");
		return respuesta;
	}
	
	/**
	 * Actualiza los servicios suplementarios por abonado
	 * 
	 * @param prodList
	 * @throws CustomerOrderException
	 */
	public void setInvolvementProductBundleAttributes(ProductListDTO prodList)
			throws CustomerOrderException {
		logger.debug("setInvolvementProductBundleAttributes():start");
		involvementProductBundle.setInvolvementProductBundleAttributes(prodList);
		logger.debug("setInvolvementProductBundleAttributes():end");
	}	
	
	
	

}
