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

public class AuditoriaDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements AuditoriaDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(AuditoriaDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public AuditoriaDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Inserta registros para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AuditoriaResponseDTO insertarAuditoria(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("insertarAuditoria:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.AuditoriaResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.AuditoriaResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_INS_AUDITORIA_PR(?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getNombreUsuario());
			logger.debug("nombreUsuario[" + inParam0.getNombreUsuario() + "]");

			cstmt.setString(2,inParam0.getCodPuntoAcceso());
			logger.debug("codPuntoAcceso[" + inParam0.getCodPuntoAcceso() + "]");

			cstmt.setString(3,inParam0.getCodAplicacion());
			logger.debug("codAplicacion[" + inParam0.getCodAplicacion() + "]");

			cstmt.setString(4,inParam0.getCodServicio());
			logger.debug("codServicio[" + inParam0.getCodServicio() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
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

			outParam0.setCodAuditoria(cstmt.getLong(5));
			logger.debug("codAuditoria[" + outParam0.getCodAuditoria() + "]");

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

		logger.info("insertarAuditoria:end()");
		return outParam0;
	}

	/**
	* Inserta Parametros de Servicio para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO insertarServicios(com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("insertarServicios:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_INS_PARAM_SERV_PR(?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getNombreUsuario());
			logger.debug("nombreUsuario[" + inParam0.getNombreUsuario() + "]");

			cstmt.setLong(2,inParam0.getCodAuditoria());
			logger.debug("codAuditoria[" + inParam0.getCodAuditoria() + "]");

			cstmt.setString(3,inParam0.getNomParametro());
			logger.debug("nomParametro[" + inParam0.getNomParametro() + "]");

			cstmt.setString(4,inParam0.getValParametro());
			logger.debug("valParametro[" + inParam0.getValParametro() + "]");

			logger.info("declara parametros de salida...");

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam0.setCodigoError(cstmt.getInt(5));
			logger.debug("codigoError[" + outParam0.getCodigoError() + "]");

			outParam0.setMensajeError(cstmt.getString(6));
			logger.debug("mensajeError[" + outParam0.getMensajeError() + "]");

			outParam0.setNumeroEvento(cstmt.getLong(7));
			logger.debug("numeroEvento[" + outParam0.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam0.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				return outParam0;
			}

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

		logger.info("insertarServicios:end()");
		return outParam0;
	}

	/**
	* Consulta Punto de acceso para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO consultarPuntoAcceso(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarPuntoAcceso:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_consultar_pto_acceso_pr(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getCodPuntoAcceso());
			logger.debug("codPuntoAcceso[" + inParam0.getCodPuntoAcceso() + "]");

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

			outParam0.setDesPuntoAcceso(cstmt.getString(2));
			logger.debug("desPuntoAcceso[" + outParam0.getDesPuntoAcceso() + "]");

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

		logger.info("consultarPuntoAcceso:end()");
		return outParam0;
	}

	/**
	* Valida si existe un Servicio para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO validarServicio(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("validarServicio:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_validar_servicio_pr(?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getCodServicio());
			logger.debug("codServicio[" + inParam0.getCodServicio() + "]");

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

			outParam0.setNumeroEvento(cstmt.getLong(4));
			logger.debug("numeroEvento[" + outParam0.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam0.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				return outParam0;
			}

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

		logger.info("validarServicio:end()");
		return outParam0;
	}

	/**
	* Valida si existe una Aplicación para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO validarAplicacion(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("validarAplicacion:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_validar_aplicacion_pr(?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getCodAplicacion());
			logger.debug("codAplicacion[" + inParam0.getCodAplicacion() + "]");

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

			outParam0.setNumeroEvento(cstmt.getLong(4));
			logger.debug("numeroEvento[" + outParam0.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam0.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				return outParam0;
			}

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

		logger.info("validarAplicacion:end()");
		return outParam0;
	}

	/**
	* Valida si existe un Usuario para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO validarNombreUsuario(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("validarNombreUsuario:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_validar_usuario_pr(?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getNombreUsuario());
			logger.debug("nombreUsuario[" + inParam0.getNombreUsuario() + "]");

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

			outParam0.setNumeroEvento(cstmt.getLong(4));
			logger.debug("numeroEvento[" + outParam0.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam0.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				return outParam0;
			}

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

		logger.info("validarNombreUsuario:end()");
		return outParam0;
	}
}