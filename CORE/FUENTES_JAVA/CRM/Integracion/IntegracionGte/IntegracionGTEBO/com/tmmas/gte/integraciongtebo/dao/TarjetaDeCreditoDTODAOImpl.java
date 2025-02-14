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

public class TarjetaDeCreditoDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements TarjetaDeCreditoDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(TarjetaDeCreditoDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public TarjetaDeCreditoDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Valida que el número de tarjeta de crédito que se ha ingresado sea un número válido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO validarNumTarjCredito(com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("validarNumTarjCredito:start()");
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
			String call = "{call CO_SERVICIOS_COBRANZA_PG.CO_ValidaTarjeta_PR(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getCodTipTarjeta());
			logger.debug("codTipTarjeta[" + inParam0.getCodTipTarjeta() + "]");

			cstmt.setString(2,inParam0.getNumeroTarjeta());
			logger.debug("numeroTarjeta[" + inParam0.getNumeroTarjeta() + "]");

			logger.info("declara parametros de salida...");

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam0.setCodigoError(cstmt.getInt(3));
			logger.debug("codigoError[" + outParam0.getCodigoError() + "]");

			outParam0.setMensajeError(cstmt.getString(4));
			logger.debug("mensajeError[" + outParam0.getMensajeError() + "]");

			outParam0.setNumeroEvento(cstmt.getLong(5));
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

		logger.info("validarNumTarjCredito:end()");
		return outParam0;
	}

	/**
	* Actualiza el registro de la tabla de clientes asociado al código de cliente del número ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO actualizarDatosClieTarjeta(com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("actualizarDatosClieTarjeta:start()");
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
			String call = "{call GE_INTEGRACION_PG.ge_update_cliente_pr(?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setString(2,inParam0.getNumeroTarjeta());
			logger.debug("numeroTarjeta[" + inParam0.getNumeroTarjeta() + "]");

			cstmt.setString(3,inParam0.getIndicDebito());
			logger.debug("indicDebito[" + inParam0.getIndicDebito() + "]");

			cstmt.setString(4,inParam0.getCodTipTarjeta());
			logger.debug("codTipTarjeta[" + inParam0.getCodTipTarjeta() + "]");

			cstmt.setString(5,inParam0.getFechaVencTarjeta());
			logger.debug("fechaVencTarjeta[" + inParam0.getFechaVencTarjeta() + "]");

			cstmt.setString(6,inParam0.getCodBancoTarjeta());
			logger.debug("codBancoTarjeta[" + inParam0.getCodBancoTarjeta() + "]");

			cstmt.setString(7,inParam0.getNombreTitular());
			logger.debug("nombreTitular[" + inParam0.getNombreTitular() + "]");

			cstmt.setString(8,inParam0.getObservaciones());
			logger.debug("observaciones[" + inParam0.getObservaciones() + "]");

			logger.info("declara parametros de salida...");

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam0.setCodigoError(cstmt.getInt(9));
			logger.debug("codigoError[" + outParam0.getCodigoError() + "]");

			outParam0.setMensajeError(cstmt.getString(10));
			logger.debug("mensajeError[" + outParam0.getMensajeError() + "]");

			outParam0.setNumeroEvento(cstmt.getLong(11));
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

		logger.info("actualizarDatosClieTarjeta:end()");
		return outParam0;
	}

	/**
	* Actualiza la información de la tarjeta de crédito en el módulo de cobranza
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO insertarPagoAutomatico(com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("insertarPagoAutomatico:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();
		
		try {
			conn = (serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection());
			
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_insPagoAutomatico_PR(?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setString(2,inParam0.getCodBancoTarjeta());
			logger.debug("codBancoTarjeta[" + inParam0.getCodBancoTarjeta() + "]");

			cstmt.setLong(3,inParam0.getNumTelefono());
			logger.debug("numTelefono[" + inParam0.getNumTelefono() + "]");

			cstmt.setString(4,inParam0.getCodZona());
			logger.debug("codZona[" + inParam0.getCodZona() + "]");

			cstmt.setString(5,inParam0.getCodCentral());
			logger.debug("codCentral[" + inParam0.getCodCentral() + "]");

			cstmt.setLong(6,inParam0.getCodBcoi());
			logger.debug("codBcoi[" + inParam0.getCodBcoi() + "]");

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

			outParam0.setNumeroEvento(cstmt.getLong(9));
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

		logger.info("insertarPagoAutomatico:end()");
		return outParam0;
	}

	/**
	* Entrega Listado de Tarjetas de Credito
	*/
	public com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoResponseDTO listarTarjetasDeCredito()
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("listarTarjetasDeCredito:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call Ve_Alta_Cliente_Pg.VE_getListTarjetas_PR(?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoPacDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoPacDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(1,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(2));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(3));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(4));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			logger.info("Recuperando cursor..");
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(1);
			java.util.List lista1 = new java.util.ArrayList();

			logger.info("Recuperando cursor1:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoPacDTO dto1 = new com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoPacDTO();

				dto1.setCodTipTarjeta(rs.getString("cod_tiptarjeta"));
				logger.debug("codTipTarjeta[" + dto1.getCodTipTarjeta() + "]");

				dto1.setDesTipTarjeta(rs.getString("des_tiptarjeta"));
				logger.debug("desTipTarjeta[" + dto1.getDesTipTarjeta() + "]");

				lista1.add(dto1);
			}
			logger.info("Recuperando cursor1:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor1 en clase de salida....");
			outParam0.setTarjetasDeCreditoDTO((com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoPacDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista1.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoPacDTO.class));

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

		logger.info("listarTarjetasDeCredito:end()");
		return outParam0;
	}

}