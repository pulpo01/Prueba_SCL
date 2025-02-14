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
 * 13/09/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.pv.customerorder.businessobject.bo;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
//import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.businessobject.dao.ProductBundleDAO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ReglasSSDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;

public class ProductBundle {
	//private static Category cat = Category.getInstance(ProductBundle.class);
	ProductBundleDAO productBundleDAO = new ProductBundleDAO();
	/**
	 * Obtiene las reglas de validacion de servicios suplementarios
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
	

	public ReglasSSDTO[] getReglasdeValidacionSS() throws CustomerOrderException {
		setLog();
		logger.debug("getReglasdeValidacionSS():start");
		ReglasSSDTO[] resultado = productBundleDAO.getReglasdeValidacionSS();
		logger.debug("getReglasdeValidacionSS():end");
		return resultado;
	}	

}
