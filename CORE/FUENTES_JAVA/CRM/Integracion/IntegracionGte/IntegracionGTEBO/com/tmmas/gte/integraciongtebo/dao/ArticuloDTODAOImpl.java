/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtebo.helper.Global;
import com.tmmas.cl.framework20.util.ServiceLocator;

public class ArticuloDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements ArticuloDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ArticuloDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public ArticuloDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Valida si el equipo asociado al número de teléfono consultado tiene soporte GPRS
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO validarSoporteGPRS(com.tmmas.gte.integraciongtecommon.dto.ArticuloDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("validarSoporteGPRS:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_val_soporte_gprs_pr(?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumAbonado());
			logger.debug("numAbonado[" + inParam0.getNumAbonado() + "]");

			cstmt.setString(2,inParam0.getCodTecnologia());
			logger.debug("codTecnologia[" + inParam0.getCodTecnologia() + "]");

			cstmt.setString(3,inParam0.getNumSerie());
			logger.debug("numSerie[" + inParam0.getNumSerie() + "]");

			cstmt.setString(4,inParam0.getNumImei());
			logger.debug("numImei[" + inParam0.getNumImei() + "]");

			cstmt.setString(5,inParam0.getCodServicio());
			logger.debug("codServicio[" + inParam0.getCodServicio() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(6));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(7));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(8));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
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

		logger.info("validarSoporteGPRS:end()");
		return outParam0;
	}

	/**
	* Servicio que permite consultar el PUK de una Serie Simcard
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsultaPukResponseDTO consultarPuk(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarPuk:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.ConsultaPukResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.ConsultaPukResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONSPUK_PR(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumeroTelefono());
			logger.debug("numeroTelefono[" + inParam0.getNumeroTelefono() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(3));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(4));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(5));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setNumeroPuk(cstmt.getLong(2));
			logger.debug("numeroPuk[" + outParam0.getNumeroPuk() + "]");

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
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

		logger.info("consultarPuk:end()");
		return outParam0;
	}

	/**
	* Retorna el número de kit asociado al número de serie de un abonado.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AbonadoProductoResponseDTO consultarKit(com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarKit:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.AbonadoProductoResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.AbonadoProductoResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_ABO_PROD_PR(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getNumSerie());
			logger.debug("numSerie[" + inParam0.getNumSerie() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(3));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(4));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(5));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setTipProducto(cstmt.getString(2));
			logger.debug("tipProducto[" + outParam0.getTipProducto() + "]");

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
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

		logger.info("consultarKit:end()");
		return outParam0;
	}

	
	
}