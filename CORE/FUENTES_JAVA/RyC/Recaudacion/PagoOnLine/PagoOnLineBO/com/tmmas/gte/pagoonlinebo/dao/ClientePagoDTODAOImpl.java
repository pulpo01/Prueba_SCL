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

public class ClientePagoDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements ClientePagoDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ClientePagoDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public ClientePagoDTODAOImpl() {
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlinebo/properties/PagoOnLineBO.properties");
	}

	/**
	* Obtiene Saldo Vencido y Saldo por Vencer de un Cliente
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO obtenerSaldo(com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		logger.info("obtenerSaldo:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO outParam0 = new com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call CO_PAGOSONLINE_PG.CO_SALDO_PR(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(4));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(5));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getString(6));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setSaldoVencido(cstmt.getDouble(2));
			logger.debug("saldoVencido[" + outParam0.getSaldoVencido() + "]");

			outParam0.setSaldoPorVencer(cstmt.getDouble(3));
			logger.debug("saldoPorVencer[" + outParam0.getSaldoPorVencer() + "]");

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

		logger.info("obtenerSaldo:end()");
		return outParam0;
	}

	/**
	* Obtiene Saldo Limite Consumo por Plan Tarifario y Saldo por Plan Adicional
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO obtenerSaldoLimite(com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		logger.info("obtenerSaldoLimite:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO outParam0 = new com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call CO_PAGOSONLINE_PG.CO_SALDO_LIMITE_PR(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(4));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(5));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getString(6));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setSaldoLimiteConsumoPlanTarifario(cstmt.getDouble(2));
			logger.debug("saldoLimiteConsumoPlanTarifario[" + outParam0.getSaldoLimiteConsumoPlanTarifario() + "]");

			outParam0.setSaldoLimiteConsumoPlanAdicional(cstmt.getDouble(3));
			logger.debug("saldoLimiteConsumoPlanAdicional[" + outParam0.getSaldoLimiteConsumoPlanAdicional() + "]");

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

		logger.info("obtenerSaldoLimite:end()");
		return outParam0;
	}

	/**
	* Obtiene Cliente asociado a un Numero de Celular
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO obtenerCodCliente(com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		logger.info("obtenerCodCliente:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO outParam0 = new com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call CO_PAGOSONLINE_PG.CO_OBTIENECLIENTE_PR(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getNumCelular());
			logger.debug("numCelular[" + inParam0.getNumCelular() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
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

			outParam1.setNumeroEvento(cstmt.getString(5));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setCodCliente(cstmt.getLong(2));
			logger.debug("codCliente[" + outParam0.getCodCliente() + "]");

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

		logger.info("obtenerCodCliente:end()");
		return outParam0;
	}

	/**
	* Obtiene Nombre completo de un cliente
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO obtenerNombreCliente(com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		logger.info("obtenerNombreCliente:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO outParam0 = new com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call CO_PAGOSONLINE_PG.CO_NOMBRECLIENTE_PR(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(4));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(5));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getString(6));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setNombre(cstmt.getString(2));
			logger.debug("nombre[" + outParam0.getNombre() + "]");

			outParam0.setApellido(cstmt.getString(3));
			logger.debug("apellido[" + outParam0.getApellido() + "]");

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

		logger.info("obtenerNombreCliente:end()");
		return outParam0;
	}

}