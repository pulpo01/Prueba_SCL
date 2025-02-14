package com.tmmas.cl.scl.tol.ServiceBundle.businessobject.bo;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ParametroProcesoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.tol.ServiceBundle.businessobject.dao.ProcesoAsincronoDAO;

public class ProcesoAsincrono {
	
	private static Category cat = Category.getInstance(ProcesoAsincrono.class);
	private ProcesoAsincronoDAO dao = new ProcesoAsincronoDAO();
	
	private CompositeConfiguration config;
	
	public ProcesoAsincrono() {
		setLogFile();
	} 
	
	private void setLogFile() {
//		 inicio MA
		String strArchivoLog;
		String strRuta = "com/tmmas/cl/tol/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + "tol.webservice.properties";
		System.out.println("strRutaArchivoExterno:"+strRutaArchivoExterno);
		//config = UtilProperty.getConfigurationfromExternalFile(strRutaArchivoExterno);
		config = UtilProperty.getConfiguration(strRutaArchivoExterno,strRutaArchivoExterno);
		System.out.println("config.isEmpty():" + config.isEmpty());
		strArchivoLog = config.getString("tol.bo.log");
		System.out.println("strArchivoLog:" + strRuta+strArchivoLog);
		UtilLog.setLog("/" +strRuta+strArchivoLog);
		// fin MA	
	}
	

	
	public ParametroProcesoDTO inscribeProceso(ParametroProcesoDTO dto) throws TOLException
	{
		ParametroProcesoDTO respuesta;
		cat.debug("inscribeProceso:star");
		respuesta = dao.inscribeProceso(dto);
		cat.debug("inscribeProceso:end");
		return respuesta;
		
	}
	
	public ParametroProcesoDTO actualizaProceso(ParametroProcesoDTO dto) throws TOLException
	{
		ParametroProcesoDTO respuesta;
		cat.debug("inscribeProceso:star");
		respuesta = dao.actualizaProceso(dto);
		cat.debug("inscribeProceso:end");
		return respuesta;
	}

}
