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

public class TransaccionDTOServiceImpl implements TransaccionDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(TransaccionDTOServiceImpl.class);
	private com.tmmas.gte.pagoonlinebo.dao.TransaccionDTODAO transaccionDTODAO = new com.tmmas.gte.pagoonlinebo.dao.TransaccionDTODAOImpl();

	public TransaccionDTOServiceImpl() {
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlineservice/properties/PagoOnLineService.properties");
	}

	/**
	* Obtiene Secuencia para Numero de Transaccion
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.TransaccionDTO obtenerTransaccion()
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		UtilLog.setLog(config.getString("PagoOnLineService.log"));
		logger.info("obtenerTransaccion:start()");
		logger.info("obtenerTransaccion:antes()");
		com.tmmas.gte.pagoonlinecommon.dto.TransaccionDTO outParam0 = transaccionDTODAO.obtenerTransaccion();
		logger.info("obtenerTransaccion:despues()");
		logger.info("obtenerTransaccion:end()");
		return outParam0;
	}

}