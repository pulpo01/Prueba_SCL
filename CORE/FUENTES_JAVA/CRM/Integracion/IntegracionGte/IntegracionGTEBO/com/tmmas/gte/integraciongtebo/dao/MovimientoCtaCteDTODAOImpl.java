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

public class MovimientoCtaCteDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements MovimientoCtaCteDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(MovimientoCtaCteDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public MovimientoCtaCteDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Ingresa como parametros un objeto de tipo PagoInDTO y despues devuelve un cursor con datos de los pagos, este se setean los datos en PagoResponseDTO
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PagoResponseDTO consultarPagosRealizados(com.tmmas.gte.integraciongtecommon.dto.PagoInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultaPagosRealizados:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.PagoResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.PagoResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_PAGOS_REALIZADO_PR(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.PagoDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.PagoDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(3));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(4));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(5));
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
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(2);
			java.util.List lista2 = new java.util.ArrayList();

			logger.info("Recuperando cursor2:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.PagoDTO dto2 = new com.tmmas.gte.integraciongtecommon.dto.PagoDTO();

				dto2.setNumSecuenci(rs.getLong("num_secuenci"));
				logger.debug("numSecuenci[" + dto2.getNumSecuenci() + "]");

				dto2.setCodTipdocum(rs.getLong("cod_tipdocum"));
				logger.debug("codTipdocum[" + dto2.getCodTipdocum() + "]");

				dto2.setCodCliente(rs.getLong("cod_cliente"));
				logger.debug("codCliente[" + dto2.getCodCliente() + "]");

				dto2.setImpPago(rs.getDouble("imp_pago"));
				logger.debug("impPago[" + dto2.getImpPago() + "]");

				dto2.setCodOripago(rs.getLong("cod_oripago"));
				logger.debug("codOripago[" + dto2.getCodOripago() + "]");

				dto2.setCodCaja(rs.getString("cod_caja"));
				logger.debug("codCaja[" + dto2.getCodCaja() + "]");

				dto2.setFecEfectividad(new java.util.Date(rs.getTimestamp("fec_efectividad").getTime()));
				logger.debug("fecEfectividad[" + dto2.getFecEfectividad() + "]");

				dto2.setImporteTotDoc(rs.getDouble("importe_tot_doc"));
				logger.debug("importeTotDoc[" + dto2.getImporteTotDoc() + "]");

				dto2.setNumFolio(rs.getLong("num_folio"));
				logger.debug("numFolio[" + dto2.getNumFolio() + "]");

				dto2.setCodTipdocrel(rs.getLong("cod_tipdocrel"));
				logger.debug("codTipdocrel[" + dto2.getCodTipdocrel() + "]");

				dto2.setPrefPlaza(rs.getString("pref_plaza"));
				logger.debug("prefPlaza[" + dto2.getPrefPlaza() + "]");

				dto2.setNumCompago(rs.getLong("num_compago"));
				logger.debug("numCompago[" + dto2.getNumCompago() + "]");

				dto2.setCodBanco(rs.getString("cod_banco"));
				logger.debug("codBanco[" + dto2.getCodBanco() + "]");

				dto2.setTotFactura(rs.getDouble("tot_factura"));
				logger.debug("totFactura[" + dto2.getTotFactura() + "]");

				dto2.setTotPagar(rs.getDouble("tot_pagar"));
				logger.debug("totPagar[" + dto2.getTotPagar() + "]");

				dto2.setFechaHora(new java.util.Date(rs.getTimestamp("fecha_hora").getTime()));
				logger.debug("fechaHora[" + dto2.getFechaHora() + "]");



				lista2.add(dto2);
			}
			logger.info("Recuperando cursor2:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor2 en clase de salida....");
			outParam0.setLstListadoPagos((com.tmmas.gte.integraciongtecommon.dto.PagoDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista2.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.PagoDTO.class));

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

		logger.info("consultaPagosRealizados:end()");
		return outParam0;
	}

	/**
	* Ingresa como parametros un objeto de tipo PagoDTO y despues devuelve un objeto PagoRecaudadoraOutDTO, devuelve la recuadadora y la descripcion del la empresa
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PagoRecaudadoraOutDTO consultarRecaudadora(com.tmmas.gte.integraciongtecommon.dto.PagoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarRecaudadora:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.PagoRecaudadoraOutDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.PagoRecaudadoraOutDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_RECAUDADORA_PAGO_PR(?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getPrefPlaza());
			logger.debug("prefPlaza[" + inParam0.getPrefPlaza() + "]");

			cstmt.setLong(2,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setLong(3,inParam0.getNumCompago());
			logger.debug("numCompago[" + inParam0.getNumCompago() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
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

			outParam0.setRecaudadora(cstmt.getString(4));
			logger.debug("recaudadora[" + outParam0.getRecaudadora() + "]");

			outParam0.setDescripcionEmpresa(cstmt.getString(5));
			logger.debug("descripcionEmpresa[" + outParam0.getDescripcionEmpresa() + "]");

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

		logger.info("consultarRecaudadora:end()");
		return outParam0;
	}	
	
	/**
	* Retorna saldo total de un Cliente a partir del codigo_cliente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.CarteraResponseDTO obtenerSaldoCliente(com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("obtenerSaldoCliente:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.CarteraResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.CarteraResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_obtener_saldo_clie_pr(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.CarteraDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.CarteraDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(3));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(4));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(5));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			outParam1.setSaldoCliente(cstmt.getDouble(2));
			logger.debug("saldoCliente[" + outParam1.getSaldoCliente() + "]");

			logger.info("Seteando propiedades hijas a la clase padre...");
			outParam0.setCarteraCliente(outParam1);

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

		logger.info("obtenerSaldoCliente:end()");
		return outParam0;
	}

	/**
	* Retorna deuda vencida y deuda por vencer de un Cliente a partir del codigo_cliente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SaldoMorosidadDTO consultarSaldoClieBloqueado(com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consSaldoClieBloqueado:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.SaldoMorosidadDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.SaldoMorosidadDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_obtener_saldo_moroso_pr(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

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

			outParam1.setNumeroEvento(cstmt.getLong(6));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setSaldoVenc(cstmt.getDouble(2));
			logger.debug("saldoVenc[" + outParam0.getSaldoVenc() + "]");

			outParam0.setSaldoNoVenc(cstmt.getDouble(3));
			logger.debug("saldoNoVenc[" + outParam0.getSaldoNoVenc() + "]");

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

		logger.info("consSaldoClieBloqueado:end()");
		return outParam0;
	}
	

}