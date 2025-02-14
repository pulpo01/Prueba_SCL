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

public class PrestacionesDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements PrestacionesDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(PrestacionesDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public PrestacionesDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Entrega datos de los grupos de prestación existentes
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PrestacionResponseDTO consultarGruposPrestacion()
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarGruposPrestacion:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.PrestacionResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.PrestacionResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call VE_PARAMETROS_COMERCIALES_PG.VE_OBTIENE_GRUPOSPREST_PR(?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.PrestacionOutDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.PrestacionOutDTO();
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
				com.tmmas.gte.integraciongtecommon.dto.PrestacionOutDTO dto1 = new com.tmmas.gte.integraciongtecommon.dto.PrestacionOutDTO();

				dto1.setCodValor(rs.getString("cod_valor"));
				logger.debug("codValor[" + dto1.getCodValor() + "]");

				dto1.setDesValor(rs.getString("des_valor"));
				logger.debug("desValor[" + dto1.getDesValor() + "]");

				lista1.add(dto1);
			}
			logger.info("Recuperando cursor1:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor1 en clase de salida....");
			outParam0.setListadoPrestaciones((com.tmmas.gte.integraciongtecommon.dto.PrestacionOutDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista1.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.PrestacionOutDTO.class));

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

		logger.info("consultarGruposPrestacion:end()");
		return outParam0;
	}
	
	/**
	* Servicio que permite consultar la descripción de la prestación asociada a un número de teléfono
	*/
	public com.tmmas.gte.integraciongtecommon.dto.TipoServicioResponseDTO consultarDescPrestacion(com.tmmas.gte.integraciongtecommon.dto.CodPrestacionDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarTipoServicio:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.TipoServicioResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.TipoServicioResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONSTIPSERV_PR(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getCodPrestacion());
			logger.debug("codPrestacion[" + inParam0.getCodPrestacion() + "]");

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

			outParam0.setDesPrestacion(cstmt.getString(2));
			logger.debug("desPrestacion[" + outParam0.getDesPrestacion() + "]");

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

		logger.info("consultarTipoServicio:end()");
		return outParam0;
	}

	/**
	* Retorna todas las Prestaciones existentes para clientes Prepago ó clientes Pospago e Híbrido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesResponseDTO consultarCodigosPrestacion(com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarCodigosPrestacion:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}
		try {
			String call = "{call VE_parametros_comerciales_PG.VE_Obtiene_TipoPrest_PR(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getGrpPrestacion());
			logger.debug("grpPrestacion[" + inParam0.getGrpPrestacion() + "]");

			cstmt.setString(2,inParam0.getIdTipoPrestacion());
			logger.debug("idTipoPrestacion[" + inParam0.getIdTipoPrestacion() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(3,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(4));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(5));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(6));
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
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(3);
			java.util.List lista3 = new java.util.ArrayList();

			logger.info("Recuperando cursor3:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesDTO dto3 = new com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesDTO();

				dto3.setCodPrestacion(rs.getString("COD_PRESTACION"));
				logger.debug("codPrestacion[" + dto3.getCodPrestacion() + "]");

				dto3.setDesPrestacion(rs.getString("DES_PRESTACION"));
				logger.debug("desPrestacion[" + dto3.getDesPrestacion() + "]");

				dto3.setTipVenta(rs.getInt("TIP_VENTA"));
				logger.debug("tipVenta[" + dto3.getTipVenta() + "]");

				dto3.setIndNumero(rs.getInt("IND_NUMERO"));
				logger.debug("indNumero[" + dto3.getIndNumero() + "]");

				dto3.setIndDirInstalacion(rs.getInt("IND_DIR_INSTALACION"));
				logger.debug("indDirInstalacion[" + dto3.getIndDirInstalacion() + "]");

				dto3.setIndInventarioFijo(rs.getInt("IND_INVENTARIO_FIJO"));
				logger.debug("indInventarioFijo[" + dto3.getIndInventarioFijo() + "]");

				dto3.setCodPlanTarifDefecto(rs.getString("COD_PLANTARIF_DEFECTO"));
				logger.debug("codPlanTarifDefecto[" + dto3.getCodPlanTarifDefecto() + "]");

				dto3.setCodCentralDefecto(rs.getInt("COD_CENTRAL_DEFECTO"));
				logger.debug("codCentralDefecto[" + dto3.getCodCentralDefecto() + "]");

				dto3.setCodCeldaDefecto(rs.getString("COD_CELDA_DEFECTO"));
				logger.debug("codCeldaDefecto[" + dto3.getCodCeldaDefecto() + "]");

				dto3.setIndssIntranet(rs.getInt("IND_SS_INTERNET"));
				logger.debug("indssIntranet[" + dto3.getIndssIntranet() + "]");

				dto3.setTipRed(rs.getString("TIP_RED"));
				logger.debug("tipRed[" + dto3.getTipRed() + "]");

				dto3.setGrpPrestacion(rs.getString("GRP_PRESTACION"));
				logger.debug("grpPrestacion[" + dto3.getGrpPrestacion() + "]");

				lista3.add(dto3);
			}
			logger.info("Recuperando cursor3:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor3 en clase de salida....");
			outParam0.setListPrestaciones((com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista3.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesDTO.class));
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
		logger.info("consultarCodigosPrestacion:end()");
		return outParam0;
	}

}