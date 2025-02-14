package com.tmmas.cl.scl.tol.ServiceBundle.negocio.jms;

import javax.jms.Message;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;

import com.tmmas.cl.framework.processmgr.AsyncProcessResponse;
import com.tmmas.cl.framework.processmgr.AsyncProcessStarterMDBBean;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;

public class OperacionMDBBean extends AsyncProcessStarterMDBBean {
	private static final long serialVersionUID = 1L;
	
// INICIO MA 69363 RRG 04-11-2008
	
	private CompositeConfiguration config;

	private void setPropFile() {
//		 inicio MA
		String strArchivoLog;
		String strRuta = "com/tmmas/cl/tol/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + "tol.webservice.properties";
		System.out.println("strRutaArchivoExterno:"+strRutaArchivoExterno);
		//config = UtilProperty.getConfigurationfromExternalFile(strRutaArchivoExterno);
		config = UtilProperty.getConfiguration(strRutaArchivoExterno,strRutaArchivoExterno);
		System.out.println("config.isEmpty():" + config.isEmpty());
		strArchivoLog = config.getString("tol.ejb.log");
		System.out.println("strArchivoLog:" + strRuta+strArchivoLog);
		UtilLog.setLog("/" +strRuta+strArchivoLog);
		// fin MA	
	}
//	 FIN MA 69363 RRG 04-11-2008
	
	
	private static Category cat = Category
			.getInstance(AsyncProcessStarterMDBBean.class);

	public void onMessage(Message message) {
		setPropFile();
		cat.debug("onMessage:start");
		super.onMessage(message);
		cat.debug("onMessage:end");
	}

	public void handleResult(AsyncProcessResponse resp) {
		setPropFile();
		cat.debug("handleResult:start");
		super.handleResult(resp);
		cat.debug("handleResult:end");
	}
}