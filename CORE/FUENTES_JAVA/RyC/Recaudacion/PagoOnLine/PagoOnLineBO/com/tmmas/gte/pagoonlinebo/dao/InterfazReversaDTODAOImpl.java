/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.pagoonlinebo.dao;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.pagoonlinebo.helper.Global;
import com.tmmas.cl.framework20.util.ServiceLocator;

public class InterfazReversaDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements InterfazReversaDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(InterfazReversaDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public InterfazReversaDTODAOImpl() {
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlinebo/properties/PagoOnLineBO.properties");
	}

	/**
	* Valida que el Pago a reversar exista (CO_INTERFAZ_PAGOS)
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO validaReversa(com.tmmas.gte.pagoonlinecommon.dto.InterfazReversaDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		logger.info("validaReversa:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO outParam0 = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call CO_PAGOSONLINE_PG.CO_VALIDA_DATOSPAGO_PR(?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setInt(1,inParam0.getNumTransaccion());
			logger.debug("numTransaccion[" + inParam0.getNumTransaccion() + "]");

			cstmt.setLong(2,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setString(3,inParam0.getCodBanco());
			logger.debug("codBanco[" + inParam0.getCodBanco() + "]");

			cstmt.setString(4,inParam0.getFecPago());
			logger.debug("fecPago[" + inParam0.getFecPago() + "]");

			cstmt.setString(5,inParam0.getHorPago());
			logger.debug("horPago[" + inParam0.getHorPago() + "]");

			cstmt.setDouble(6,inParam0.getMtoPago());
			logger.debug("mtoPago[" + inParam0.getMtoPago() + "]");

			logger.info("declara parametros de salida...");

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam0.setCodigoError(cstmt.getInt(7));
			logger.debug("codigoError[" + outParam0.getCodigoError() + "]");

			outParam0.setMensajeError(cstmt.getString(8));
			logger.debug("mensajeError[" + outParam0.getMensajeError() + "]");

			outParam0.setNumeroEvento(cstmt.getString(9));
			logger.debug("numeroEvento[" + outParam0.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam0.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				return outParam0;
			}

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("validaReversa:end()");
		return outParam0;
	}

	/**
	* Inserta Reversa en la Interfaz de Pago (CO_INTERFAZ_PAGOS)
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO aplicaReversa(com.tmmas.gte.pagoonlinecommon.dto.InterfazReversaDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		logger.info("aplicaReversa:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO outParam0 = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call CO_PAGOSONLINE_PG.CO_DESAPLICA_PAGO_PR(?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setInt(1,inParam0.getNumTransaccion());
			logger.debug("numTransaccion[" + inParam0.getNumTransaccion() + "]");

			logger.info("declara parametros de salida...");

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam0.setCodigoError(cstmt.getInt(2));
			logger.debug("codigoError[" + outParam0.getCodigoError() + "]");

			outParam0.setMensajeError(cstmt.getString(3));
			logger.debug("mensajeError[" + outParam0.getMensajeError() + "]");

			outParam0.setNumeroEvento(cstmt.getString(4));
			logger.debug("numeroEvento[" + outParam0.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam0.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				return outParam0;
			}

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("aplicaReversa:end()");
		return outParam0;
	}

}