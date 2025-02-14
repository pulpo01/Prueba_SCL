package com.tmmas.cl.scl.BillingProductCharge.BillingProductCharge.service.servicios;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.BillingProductCharge.ProdPriceCharge.businesobject.bo.ProdPriceCharge;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CargosRecCliAboDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.BillingProductChargeException;

public class BillingProductChargeSrv {
 	private ProdPriceCharge bo = new ProdPriceCharge();
	private static Category cat = Category.getInstance(BillingProductChargeSrv.class);
	
// INICIO MA 69363 RRG 04-11-2008
	
	private CompositeConfiguration config;

	private void setPropFile() {
//		 inicio MA
		String strArchivoLog;
		String strRuta = "com/tmmas/cl/Billing/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + "webservice.Billing.properties";
		System.out.println("strRutaArchivoExterno:"+strRutaArchivoExterno);
		//config = UtilProperty.getConfigurationfromExternalFile(strRutaArchivoExterno);
		config = UtilProperty.getConfiguration(strRutaArchivoExterno,strRutaArchivoExterno);
		System.out.println("config.isEmpty():" + config.isEmpty());
		strArchivoLog = config.getString("billing.webservice.log");
		System.out.println("strArchivoLog:"+strRuta+strArchivoLog);
		UtilLog.setLog("/" + strRuta+ strArchivoLog);
		// fin MA	
	}
//	 FIN MA 69363 RRG 04-11-2008
	
	public void setBillingProductCharge(CargosRecCliAboDTO list) 
		throws BillingProductChargeException
	{
		setPropFile();
		
		cat.info("setBillingProductCharge():start");
		bo.installBillingProductCharge(list);
		cat.info("setBillingProductCharge():end");
	}
}
