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

public class EmpresaRecaudacionDTOServiceImpl implements EmpresaRecaudacionDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(EmpresaRecaudacionDTOServiceImpl.class);
	private com.tmmas.gte.pagoonlinebo.dao.EmpresaRecaudacionDTODAO empresaRecaudacionDTODAO = new com.tmmas.gte.pagoonlinebo.dao.EmpresaRecaudacionDTODAOImpl();

	public EmpresaRecaudacionDTOServiceImpl() {
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlineservice/properties/PagoOnLineService.properties");
	}

	/**
	* Obtiene Caja asignada a una Empresa de Recaudación Externa
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.EmpresaRecaudacionDTO obtenerCaja(com.tmmas.gte.pagoonlinecommon.dto.EmpresaRecaudacionDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		UtilLog.setLog(config.getString("PagoOnLineService.log"));
		logger.info("obtenerCaja:start()");
		logger.info("obtenerCaja:antes()");
		com.tmmas.gte.pagoonlinecommon.dto.EmpresaRecaudacionDTO outParam0 = empresaRecaudacionDTODAO.obtenerCaja(inParam0);
		logger.info("obtenerCaja:despues()");
		logger.info("obtenerCaja:end()");
		return outParam0;
	}

}