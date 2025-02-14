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

public class InterfazReversaDTOServiceImpl implements InterfazReversaDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(InterfazReversaDTOServiceImpl.class);
	private com.tmmas.gte.pagoonlinebo.dao.InterfazReversaDTODAO interfazReversaDTODAO = new com.tmmas.gte.pagoonlinebo.dao.InterfazReversaDTODAOImpl();

	public InterfazReversaDTOServiceImpl() {
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlineservice/properties/PagoOnLineService.properties");
	}

	/**
	* Valida que el Pago a reversar exista (CO_INTERFAZ_PAGOS)
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO validaReversa(com.tmmas.gte.pagoonlinecommon.dto.InterfazReversaDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		UtilLog.setLog(config.getString("PagoOnLineService.log"));
		logger.info("validaReversa:start()");
		logger.info("validaReversa:antes()");
		com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO outParam0 = interfazReversaDTODAO.validaReversa(inParam0);
		logger.info("validaReversa:despues()");
		logger.info("validaReversa:end()");
		return outParam0;
	}

	/**
	* Inserta Reversa en la Interfaz de Pago (CO_INTERFAZ_PAGOS)
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO aplicaReversa(com.tmmas.gte.pagoonlinecommon.dto.InterfazReversaDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		UtilLog.setLog(config.getString("PagoOnLineService.log"));
		logger.info("aplicaReversa:start()");
		logger.info("aplicaReversa:antes()");
		com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO outParam0 = interfazReversaDTODAO.aplicaReversa(inParam0);
		logger.info("aplicaReversa:despues()");
		logger.info("aplicaReversa:end()");
		return outParam0;
	}

}