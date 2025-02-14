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

public class ClientePagoDTOServiceImpl implements ClientePagoDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ClientePagoDTOServiceImpl.class);
	private com.tmmas.gte.pagoonlinebo.dao.ClientePagoDTODAO clientePagoDTODAO = new com.tmmas.gte.pagoonlinebo.dao.ClientePagoDTODAOImpl();

	public ClientePagoDTOServiceImpl() {
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlineservice/properties/PagoOnLineService.properties");
	}

	/**
	* Obtiene Saldo Vencido y Saldo por Vencer de un Cliente
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO obtenerSaldo(com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		UtilLog.setLog(config.getString("PagoOnLineService.log"));
		logger.info("obtenerSaldo:start()");
		logger.info("obtenerSaldo:antes()");
		com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO outParam0 = clientePagoDTODAO.obtenerSaldo(inParam0);
		logger.info("obtenerSaldo:despues()");
		logger.info("obtenerSaldo:end()");
		return outParam0;
	}

	/**
	* Obtiene Saldo Limite Consumo por Plan Tarifario y Saldo por Plan Adicional
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO obtenerSaldoLimite(com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		UtilLog.setLog(config.getString("PagoOnLineService.log"));
		logger.info("obtenerSaldoLimite:start()");
		logger.info("obtenerSaldoLimite:antes()");
		com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO outParam0 = clientePagoDTODAO.obtenerSaldoLimite(inParam0);
		logger.info("obtenerSaldoLimite:despues()");
		logger.info("obtenerSaldoLimite:end()");
		return outParam0;
	}

	/**
	* Obtiene Cliente asociado a un Numero de Celular
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO obtenerCodCliente(com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		UtilLog.setLog(config.getString("PagoOnLineService.log"));
		logger.info("obtenerCodCliente:start()");
		logger.info("obtenerCodCliente:antes()");
		com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO outParam0 = clientePagoDTODAO.obtenerCodCliente(inParam0);
		logger.info("obtenerCodCliente:despues()");
		logger.info("obtenerCodCliente:end()");
		return outParam0;
	}

	/**
	* Obtiene Nombre completo de un cliente
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO obtenerNombreCliente(com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		UtilLog.setLog(config.getString("PagoOnLineService.log"));
		logger.info("obtenerNombreCliente:start()");
		logger.info("obtenerNombreCliente:antes()");
		com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO outParam0 = clientePagoDTODAO.obtenerNombreCliente(inParam0);
		logger.info("obtenerNombreCliente:despues()");
		logger.info("obtenerNombreCliente:end()");
		return outParam0;
	}

}