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

public class InterfazPagoDTOServiceImpl implements InterfazPagoDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(InterfazPagoDTOServiceImpl.class);
	private com.tmmas.gte.pagoonlinebo.dao.InterfazPagoDTODAO interfazPagoDTODAO = new com.tmmas.gte.pagoonlinebo.dao.InterfazPagoDTODAOImpl();

	public InterfazPagoDTOServiceImpl() {
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlineservice/properties/PagoOnLineService.properties");
	}

	/**
	* Ingresa registro de Pago en la interfaz de Pagos (CO_INTERFAZ_PAGOS)
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO ingresaPagoInterfaz(com.tmmas.gte.pagoonlinecommon.dto.InterfazPagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		UtilLog.setLog(config.getString("PagoOnLineService.log"));
		logger.info("ingresaPagoInterfaz:start()");
		logger.info("ingresaPagoInterfaz:antes()");
		com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO outParam0 = interfazPagoDTODAO.ingresaPagoInterfaz(inParam0);
		logger.info("ingresaPagoInterfaz:despues()");
		logger.info("ingresaPagoInterfaz:end()");
		return outParam0;
	}

}