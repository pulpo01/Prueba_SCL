/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;



import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.ServiceLocator;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtebo.helper.Global;
import com.tmmas.cl.framework20.util.ServiceLocator;
import com.tmmas.gte.integraciongtecommon.dto.LlamadasFacturadasResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ParamOperDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO;
import com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

public class TraficoDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements TraficoDTODAO{
	private CompositeConfiguration config;
	public static final String FORMATO_FECHA_ISO = "yyyyMMdd"; 
	private static Logger logger = Logger.getLogger(TraficoDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public TraficoDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Ingresa como parametros un LlamadaInDTO y despues devuelve un cursor con datos, este se setean los datos en LlamadaDTO y se genera una lista
	*/
	public com.tmmas.gte.integraciongtecommon.dto.TraficoResponseDTO listarLlamadasNoFacturadas(com.tmmas.gte.integraciongtecommon.dto.LlamadaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("lstLlamadasNoFacturadas:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.TraficoResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.TraficoResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource1())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call TOL_CONSULTA_TRAFICO_PG.TOL_DETALLETRAF_CLIENTE_PR(?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setLong(2,inParam0.getNumAbonado());
			logger.debug("numAbonado[" + inParam0.getNumAbonado() + "]");

			cstmt.setString(3,inParam0.getNumCelular());
			logger.debug("numCelular[" + inParam0.getNumCelular() + "]");

			cstmt.setLong(4,inParam0.getCodCiclo());
			logger.debug("codCiclo[" + inParam0.getCodCiclo() + "]");

			cstmt.setString(5,inParam0.getFecTasa());
			logger.debug("fecTasa[" + inParam0.getFecTasa() + "]");

			cstmt.setString(6,inParam0.getFecDesde());
			logger.debug("fecDesde[" + inParam0.getFecDesde() + "]");

			cstmt.setString(7,inParam0.getFecHasta());
			logger.debug("fecHasta[" + inParam0.getFecHasta() + "]");

			cstmt.setDouble(8,inParam0.getImpuesto());
			logger.debug("impuesto[" + inParam0.getImpuesto() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.TraficoDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.TraficoDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(9,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(10));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(11));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(12));
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
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(9);
			java.util.List lista9 = new java.util.ArrayList();

			logger.info("Recuperando cursor9:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.TraficoDTO dto9 = new com.tmmas.gte.integraciongtecommon.dto.TraficoDTO();

				dto9.setFechaLlamada(rs.getString("Fecha_llamada"));
				logger.debug("fechaLlamada[" + dto9.getFechaLlamada() + "]");

				dto9.setHoraLlamada(rs.getString("hora_llamada"));
				logger.debug("horaLlamada[" + dto9.getHoraLlamada() + "]");

				dto9.setNumeroDestino(rs.getString("numero_destino"));
				logger.debug("numeroDestino[" + dto9.getNumeroDestino() + "]");

				dto9.setMtoLlamSinImp(rs.getDouble("mto_fact_sin_impuesto"));
				logger.debug("mtoLlamSinImp[" + dto9.getMtoLlamSinImp() + "]");

				dto9.setMtoLlamConImp(rs.getDouble("mto_fact_con_impuesto"));
				logger.debug("mtoLlamConImp[" + dto9.getMtoLlamConImp() + "]");

				dto9.setTipoLlamada(rs.getString("tipo_llamada"));
				logger.debug("tipoLlamada[" + dto9.getTipoLlamada() + "]");

				dto9.setUnidad(rs.getString("unidad"));
				logger.debug("unidad[" + dto9.getUnidad() + "]");
				
				dto9.setCodDopeb(rs.getString("cod_dopeb"));
				logger.debug("codDopeb[" + dto9.getCodDopeb() + "]");

				dto9.setDuracion(rs.getLong("duracion"));
				logger.debug("Duracion[" + dto9.getDuracion() + "]");

				

				lista9.add(dto9);
			}
			logger.info("Recuperando cursor9:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor9 en clase de salida....");
			outParam0.setLstListadoLlamados((com.tmmas.gte.integraciongtecommon.dto.TraficoDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista9.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.TraficoDTO.class));

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

		logger.info("lstLlamadasNoFacturadas:end()");
		return outParam0;
	}
	/**
	* se ingresa el codigo de ciclo + las fechas (inicio y termino ), las fechas puede variar pueden ir hasta nulas o una de ella nula, de vuelve las fechas correspondiente al ciclo.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO validarFechasTrafico(com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("validacionFechasCicloFacturacion:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_VALIDA_FECHA_CICLO_PR(?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");

			cstmt.setLong(1,inParam0.getCicloFacturacion());
			logger.debug("cicloFacturacion[" + inParam0.getCicloFacturacion() + "]");

			cstmt.setString(2,inParam0.getFecDesde());
			logger.debug("fecDesde[" + inParam0.getFecDesde() + "]");

			cstmt.setString(3, inParam0.getFecHasta());
			logger.debug("fecHasta[" + inParam0.getFecHasta() + "]");

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

			
			outParam0.setFecDesde(cstmt.getString(4));
			logger.debug("fecDesde[" + outParam0.getFecDesde() + "]");

			outParam0.setFecHasta(cstmt.getString(5));	
			logger.debug("fecHasta[" + outParam0.getFecHasta() + "]");

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

		logger.info("validacionFechasCicloFacturacion:end()");
		return outParam0;
	}
	/**
	* parametros de entreda LlamadaInDTO pero sin impuestos y despues devuelve un cursor con datos, este se setean los datos en ConsumoDTO y se genera una lista
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsumoResponseDTO listarConsumoMensajesCortos(com.tmmas.gte.integraciongtecommon.dto.LlamadaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("lstConsumoMensajesCortos:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.ConsumoResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.ConsumoResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource1())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call TOL_CONSULTA_TRAFICO_PG.TOL_RESUMEN_TRAFICO_PR(?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setLong(2,inParam0.getNumAbonado());
			logger.debug("numAbonado[" + inParam0.getNumAbonado() + "]");

			cstmt.setString(3,inParam0.getNumCelular());
			logger.debug("numCelular[" + inParam0.getNumCelular() + "]");

			cstmt.setLong(4,inParam0.getCodCiclo());
			logger.debug("codCiclo[" + inParam0.getCodCiclo() + "]");

			cstmt.setString(5,inParam0.getFecTasa());
			logger.debug("fecTasa[" + inParam0.getFecTasa() + "]");

			cstmt.setString(6,inParam0.getFecDesde());
			logger.debug("fecDesde[" + inParam0.getFecDesde() + "]");

			cstmt.setString(7,inParam0.getFecHasta());
			logger.debug("fecHasta[" + inParam0.getFecHasta() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.ConsumoDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.ConsumoDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(8,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(9));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(10));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(11));
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
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(8);
			java.util.List lista8 = new java.util.ArrayList();

			logger.info("Recuperando cursor8:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.ConsumoDTO dto8 = new com.tmmas.gte.integraciongtecommon.dto.ConsumoDTO();

				dto8.setCodUnidad(rs.getString("cod_unidad"));
				logger.debug("codUnidad[" + dto8.getCodUnidad() + "]");

				dto8.setMensaje(rs.getString("desc_unidad")); 
				logger.debug("mensaje[" + dto8.getMensaje() + "]");

				dto8.setCodTdir(rs.getString("cod_tdir"));
				logger.debug("codTdir[" + dto8.getCodTdir() + "]");

				dto8.setDurReal(rs.getLong("dur_real"));
				logger.debug("durReal[" + dto8.getDurReal() + "]");

				lista8.add(dto8);
			}
			logger.info("Recuperando cursor8:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor8 en clase de salida....");
			outParam0.setLstListadoConsumosMensajesCortos((com.tmmas.gte.integraciongtecommon.dto.ConsumoDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista8.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.ConsumoDTO.class));

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

		logger.info("lstConsumoMensajesCortos:end()");
		return outParam0;
	}
	/**
	* Entrega Minutos consumidos
	*/
	public com.tmmas.gte.integraciongtecommon.dto.MinutosConsumidosDTO consultarMinutosConsumidos(com.tmmas.gte.integraciongtecommon.dto.ConsumoClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarMinutosConsumidos:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.MinutosConsumidosDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.MinutosConsumidosDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource1())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call tol_consulta_trafico_pg.tol_consumo_cliente_pr(?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumAbonado());
			logger.debug("numAbonado[" + inParam0.getNumAbonado() + "]");

			cstmt.setLong(2,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setLong(3,inParam0.getFecTasa());
			logger.debug("fecTasa[" + inParam0.getFecTasa() + "]");

			cstmt.setLong(4,inParam0.getCodCiclo());
			logger.debug("codCiclo[" + inParam0.getCodCiclo() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.DATE);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(7));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(8));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(9));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			if((outParam1.getCodigoError() == 0 )&&(outParam1.getMensajeError()!=null)) {
				logger.info("Codigo de error == 0 y mensaje distinto de 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setConsumoTelefono(cstmt.getDouble(5));
			logger.debug("consumoTelefono[" + outParam0.getConsumoTelefono() + "]");

			outParam0.setUltLlamada(new java.util.Date(cstmt.getDate(6).getTime()));
			logger.debug("ultLlamada[" + outParam0.getUltLlamada() + "]");

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

		logger.info("consultarMinutosConsumidos:end()");
		return outParam0;
	}

	/**
	* Servicio que entrega un listado de las llamadas facturadas para un número de teléfono y una factura específica
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LlamadasFacturadasResponseDTO consultarLlamadasFacturadas(com.tmmas.gte.integraciongtecommon.dto.LlamadaInFactDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarLlamadasFacturadas:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.LlamadasFacturadasResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.LlamadasFacturadasResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call PV_CONSLLAMADA_PG.PV_DETALLE_FACTURADO_PR(?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumAbonado());
			logger.debug("numAbonado[" + inParam0.getNumAbonado() + "]");
			
			if (inParam0.getCodCicloFact() != null)
			{
				cstmt.setLong(2,inParam0.getCodCicloFact().longValue());
			}else{
				cstmt.setNull(2,java.sql.Types.LONGVARCHAR);
			}
			logger.debug("codCicloFact[" + inParam0.getCodCicloFact() + "]");

			cstmt.setLong(3,inParam0.getNumFolio());
			logger.debug("numFolio[" + inParam0.getNumFolio() + "]");

			cstmt.setDate(4, null);
			logger.debug("fecIni[" + inParam0.getFecIni() + "]");

			cstmt.setDate(5, null);
			logger.debug("fecTerm[" + inParam0.getFecTerm() + "]");

			cstmt.setString(6,inParam0.getUsuario());
			logger.debug("usuario[" + inParam0.getUsuario() + "]");

			cstmt.setString(7,inParam0.getCampoOrden());
			logger.debug("campoOrden[" + inParam0.getCampoOrden() + "]");

			cstmt.setString(8,inParam0.getTipoOrden());
			logger.debug("tipoOrden[" + inParam0.getTipoOrden() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.TraficoDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.TraficoDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(9,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(10));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(11));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(12));
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
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(9);
			java.util.List lista9 = new java.util.ArrayList();

			logger.info("Recuperando cursor9:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.TraficoDTO dto9 = new com.tmmas.gte.integraciongtecommon.dto.TraficoDTO();

				dto9.setNumFolio(rs.getLong("num_Folio"));
				logger.debug("numFolio[" + dto9.getNumFolio() + "]");

				dto9.setFecLlamada(new java.util.Date(rs.getDate("fec_Llamada").getTime()));
				logger.debug("fecLlamada[" + dto9.getFecLlamada() + "]");

				dto9.setHoraLlamada(rs.getString("hora_Llamada"));
				logger.debug("horaLlamada[" + dto9.getHoraLlamada() + "]");

				dto9.setNumDestino(rs.getLong("num_Destino"));
				logger.debug("numDestino[" + dto9.getNumDestino() + "]");

				dto9.setMtoLlamSinImp(rs.getDouble("mto_Llam_Sin_Imp"));
				logger.debug("mtoLlamSinImp[" + dto9.getMtoLlamSinImp() + "]");

				dto9.setMtoLlamConImp(rs.getDouble("mto_Llam_Con_Imp"));
				logger.debug("mtoLlamConImp[" + dto9.getMtoLlamConImp() + "]");

				dto9.setDesLlamada(rs.getString("des_Llamada"));
				logger.debug("desLlamada[" + dto9.getDesLlamada() + "]");

				dto9.setDuracion(rs.getLong("dur_llamada"));
				logger.debug("duracion[" + dto9.getDuracion() + "]");

				dto9.setUnidad(rs.getString("unidad_Llamada"));
				logger.debug("unidad[" + dto9.getUnidad() + "]");


				lista9.add(dto9);

				
			}
			logger.info("Recuperando cursor9:despues");
			//rs.close();
			logger.info("Seteando respuesta de cursor9 en clase de salida....");
			outParam0.setLstLlamadasFact((com.tmmas.gte.integraciongtecommon.dto.TraficoDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista9.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.TraficoDTO.class));
			rs.close();

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

		logger.info("consultarLlamadasFacturadas:end()");
		return outParam0;
	}
		
	
	/**
	 * @author rlozano
	 * @description Servicio retorna el código operadora
	 * @return ParamOperDTO
	 * @throws IntegracionGTEException
	 */
	public com.tmmas.gte.integraciongtecommon.dto.ParamOperDTO getConsultaParametrosOperadora()
			throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException
	{
		logger.info("getConsultaParametrosOperadora:start()");
		Connection conn = null;
		CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		
		ParamOperDTO retValue=new ParamOperDTO();
		try
		{
			conn = serviceLocator.getDataSource((global.getJndiForDataSource1())).getConnection();
			String call = "{call TOL_CONSULTA_TRAFICO_PG.TOL_CONSULTA_OPERADOR_PR(?,?,?,?)}";
			
			logger.info("armar parametros de entrada...");
			cstmt = conn.prepareCall(call);
			logger.debug("PL no recibe parametros");
			 
			logger.info("declara parametros de salida...");
			
			cstmt.registerOutParameter(1,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");
			
			logger.info("setea respuesta de stored procedure...");
			retValue.setCodigoError(cstmt.getInt(2));
			logger.debug("codigoError[" + retValue.getCodigoError() + "]");

			retValue.setMensajeError(cstmt.getString(3));
			logger.debug("mensajeError[" + retValue.getMensajeError() + "]");

			retValue.setNumeroEvento(cstmt.getLong(4));
			logger.debug("numeroEvento[" + retValue.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(retValue.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
			}
			else
			{
				retValue.setCodOperadora(cstmt.getString(1));
				logger.debug("Código Operadora[" + retValue.getCodOperadora() + "]");
			}

			
		}
		catch(SQLException e)
		{
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch(Exception e)
		{
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
		
		logger.info("getConsultaParametrosOperadora:end()");
		return retValue;
	}
}