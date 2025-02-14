/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongteservice.srv;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.framework20.util.UtilLog;

public class AuditoriaDTOServiceImpl implements AuditoriaDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(AuditoriaDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO auditoriaDTODAO = new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();

	public AuditoriaDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* Inserta registros para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AuditoriaResponseDTO insertarAuditoria(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("insertarAuditoria:start()");
		logger.info("insertarAuditoria:antes()");
		com.tmmas.gte.integraciongtecommon.dto.AuditoriaResponseDTO outParam0 = auditoriaDTODAO.insertarAuditoria(inParam0);
		logger.info("insertarAuditoria:despues()");
		logger.info("insertarAuditoria:end()");
		return outParam0;
	}

	/**
	* Inserta Parametros de Servicio para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO insertarServicios(com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("insertarServicios:start()");
		logger.info("insertarServicios:antes()");
		com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam0 = auditoriaDTODAO.insertarServicios(inParam0);
		logger.info("insertarServicios:despues()");
		logger.info("insertarServicios:end()");
		return outParam0;
	}

}