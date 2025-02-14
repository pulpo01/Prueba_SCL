package com.tmmas.cl.scl.pv.customerorder.service.servicios;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ParametroProcesoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.tol.ServiceBundle.businessobject.bo.ProcesoAsincrono;
import com.tmmas.cl.scl.tol.ServiceBundle.businessobject.bo.ServiceBundleSpec;

public class ProcesoAsincronoSrv {
	private static Category cat = Category.getInstance(ServiceBundleSpec.class);
	private ProcesoAsincrono bo = new ProcesoAsincrono();
	
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
	
	
	public ParametroProcesoDTO inscribeProceso(ParametroProcesoDTO dto) throws TOLException
	{
		
		setPropFile();
		
		ParametroProcesoDTO respuesta;
		cat.debug("inscribeProceso:star");
		respuesta = bo.inscribeProceso(dto);
		cat.debug("inscribeProceso:end");
		return respuesta;
		
	}
	
	public ParametroProcesoDTO actualizaProceso(ParametroProcesoDTO dto) throws TOLException
	{
		
		setPropFile();
		
		ParametroProcesoDTO respuesta;
		cat.debug("inscribeProceso:star");
		respuesta = bo.actualizaProceso(dto);
		cat.debug("inscribeProceso:end");
		return respuesta;
	}
}
