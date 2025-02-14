/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.pagoonlineservice.srv;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.framework20.util.UtilLog;

public class GedParametrosDTOServiceImpl implements GedParametrosDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(GedParametrosDTOServiceImpl.class);
	private com.tmmas.gte.pagoonlinebo.dao.GedParametrosDTODAO gedParametrosDTODAO = new com.tmmas.gte.pagoonlinebo.dao.GedParametrosDTODAOImpl();

	public GedParametrosDTOServiceImpl() {
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlineservice/properties/PagoOnLineService.properties");
	}

	/**
	* Obtiene Valor de un parametro en la GED_PARAMETROS
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.GedParametrosDTO obtenerParametro(com.tmmas.gte.pagoonlinecommon.dto.GedParametrosDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		UtilLog.setLog(config.getString("PagoOnLineService.log"));
		logger.info("obtenerParametro:start()");
		logger.info("obtenerParametro:antes()");
		com.tmmas.gte.pagoonlinecommon.dto.GedParametrosDTO outParam0 = gedParametrosDTODAO.obtenerParametro(inParam0);
		logger.info("obtenerParametro:despues()");
		logger.info("obtenerParametro:end()");
		return outParam0;
	}

}