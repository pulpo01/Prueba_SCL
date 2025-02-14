/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.ServiceLocator;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtebo.helper.Global;

public class ServicioSuplementarioDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements ServicioSuplementarioDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ServicioSuplementarioDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public ServicioSuplementarioDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Entrega Datos de los servicios suplementario
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ServicioSupleRespondeDTO consultarServicioSuplem(com.tmmas.gte.integraciongtecommon.dto.ConServSupleDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultaServicioSuplem:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.ServicioSupleRespondeDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.ServicioSupleRespondeDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_REC_SERV_SUPL_ABONADO_PR(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumeroAbonado());
			logger.debug("numeroAbonado[" + inParam0.getNumeroAbonado() + "]");

			cstmt.setLong(2,inParam0.getTipo());
			logger.debug("tipo[" + inParam0.getTipo() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.ServicioSuplementarioDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.ServicioSuplementarioDTO();
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
				com.tmmas.gte.integraciongtecommon.dto.ServicioSuplementarioDTO dto3 = new com.tmmas.gte.integraciongtecommon.dto.ServicioSuplementarioDTO();

				dto3.setCodServicio(rs.getString("cod_servicio"));
				logger.debug("codServicio[" + dto3.getCodServicio() + "]");

				dto3.setDesServicio(rs.getString("des_servicio"));
				logger.debug("desServicio[" + dto3.getDesServicio() + "]");

				dto3.setCodServsupl(rs.getLong("cod_servsupl"));
				logger.debug("codServsupl[" + dto3.getCodServsupl() + "]");

				dto3.setCodNivel(rs.getLong("cod_nivel"));
				logger.debug("codNivel[" + dto3.getCodNivel() + "]");

				dto3.setImpTarifaSs(rs.getDouble("imp_tarifa_ss"));
				logger.debug("impTarifaSs[" + dto3.getImpTarifaSs() + "]");

				dto3.setDesMonedaSs(rs.getString("des_moneda_ss"));
				logger.debug("desMonedaSs[" + dto3.getDesMonedaSs() + "]");

				dto3.setCodConceptoSs(rs.getLong("cod_concepto_ss"));
				logger.debug("codConceptoSs[" + dto3.getCodConceptoSs() + "]");

				dto3.setImpTarifaFa(rs.getDouble("imp_tarifa_fa"));
				logger.debug("impTarifaFa[" + dto3.getImpTarifaFa() + "]");

				dto3.setDesMonedaFa(rs.getString("des_moneda_fa"));
				logger.debug("desMonedaFa[" + dto3.getDesMonedaFa() + "]");

				dto3.setCodConceptoFa(rs.getLong(10));
				logger.debug("codConceptoFa[" + dto3.getCodConceptoFa() + "]");

				dto3.setLetra(rs.getString(11));
				logger.debug("letra[" + dto3.getLetra() + "]");

				dto3.setIndTuxedo(rs.getInt("ind_tuxedo"));
				logger.debug("indTuxedo[" + dto3.getIndTuxedo() + "]");

				lista3.add(dto3);
			}
			logger.info("Recuperando cursor3:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor3 en clase de salida....");
			outParam0.setListaServiciosDefectoalPlan((com.tmmas.gte.integraciongtecommon.dto.ServicioSuplementarioDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista3.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.ServicioSuplementarioDTO.class));

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

		logger.info("consultaServicioSuplem:end()");
		return outParam0;
	}

	/**
	* Activa o desactiva Servicios Suplementarios
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO activarDesactivarSS(com.tmmas.gte.integraciongtecommon.dto.ActDesSSDto inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("actDesServicioSuplem:start()");
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
			String call = "{call Pv_Serv_Suplementario_Sb_Pg.pv_act_desact_ss_pr(?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumAbonado());
			logger.debug("numAbonado[" + inParam0.getNumAbonado() + "]");

			cstmt.setLong(2,inParam0.getNumTelefono());
			logger.debug("numTelefono[" + inParam0.getNumTelefono() + "]");

			cstmt.setString(3,inParam0.getListaSSAct());
			logger.debug("listaSSAct[" + inParam0.getListaSSAct() + "]");

			cstmt.setString(4,inParam0.getListaSSDes());
			logger.debug("listaSSDes[" + inParam0.getListaSSDes() + "]");

			cstmt.setLong(5,inParam0.getNumSecuencia());
			logger.debug("numSecuencia[" + inParam0.getNumSecuencia() + "]");

			cstmt.setString(6,inParam0.getCodOOSS());
			logger.debug("codOOSS[" + inParam0.getCodOOSS() + "]");

			cstmt.setLong(7,inParam0.getImporTotal());
			logger.debug("imporTotal[" + inParam0.getImporTotal() + "]");

			cstmt.setString(8,inParam0.getUsuario());
			logger.debug("usuario[" + inParam0.getUsuario() + "]");

			cstmt.setString(9,inParam0.getComentario());
			logger.debug("Comentario[" + inParam0.getComentario() + "]");

			logger.info("declara parametros de salida...");

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam0.setCodigoError(cstmt.getInt(10));
			logger.debug("codigoError[" + outParam0.getCodigoError() + "]");

			outParam0.setMensajeError(cstmt.getString(11));
			logger.debug("mensajeError[" + outParam0.getMensajeError() + "]");

			outParam0.setNumeroEvento(cstmt.getLong(12));
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

		logger.info("actDesServicioSuplem:end()");
		return outParam0;
	}

	
	/**
	* Entrega lista de Servicio Suplementario Activos de un Abonado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstComponentesDTO consultarSSActivos(com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarSSActivos:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.LstComponentesDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.LstComponentesDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_consultar_ss_vigentes_pr(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumAbonado());
			logger.debug("numAbonado[" + inParam0.getNumAbonado() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO();
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
				com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO dto2 = new com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO();

				dto2.setCodServicio(rs.getString("cod_servicio"));
				logger.debug("codServicio[" + dto2.getCodServicio() + "]");

				dto2.setCodServsupl(rs.getLong("cod_servsupl"));
				logger.debug("codServsupl[" + dto2.getCodServsupl() + "]");

				dto2.setCodNivel(rs.getLong("cod_nivel"));
				logger.debug("codNivel[" + dto2.getCodNivel() + "]");

				dto2.setDesServicio(rs.getString("des_servicio"));
				logger.debug("desServicio[" + dto2.getDesServicio() + "]");

				lista2.add(dto2);
			}
			logger.info("Recuperando cursor2:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor2 en clase de salida....");
			outParam0.setSerciviosSuplementarios((com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista2.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO.class));

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

		logger.info("consultarSSActivos:end()");
		return outParam0;
	}

	/**
	* Entrega lista de Servicio Suplementario Inactivos de un Abonado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstComponentesDTO consultarSSInactivos(com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarSSInactivos:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.LstComponentesDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.LstComponentesDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_consultar_ss_inactivos_pr(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumAbonado());
			logger.debug("numAbonado[" + inParam0.getNumAbonado() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO();
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
				com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO dto2 = new com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO();

				dto2.setCodServicio(rs.getString("cod_servicio"));
				logger.debug("codServicio[" + dto2.getCodServicio() + "]");

				dto2.setCodServsupl(rs.getLong("cod_servsupl"));
				logger.debug("codServsupl[" + dto2.getCodServsupl() + "]");

				dto2.setCodNivel(rs.getLong("cod_nivel"));
				logger.debug("codNivel[" + dto2.getCodNivel() + "]");

				dto2.setDesServicio(rs.getString("des_servicio"));
				logger.debug("desServicio[" + dto2.getDesServicio() + "]");

				lista2.add(dto2);
			}
			logger.info("Recuperando cursor2:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor2 en clase de salida....");
			outParam0.setSerciviosSuplementarios((com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista2.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO.class));

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

		logger.info("consultarSSInactivos:end()");
		return outParam0;
	}
	
	/**
	* se ingresa el numero de abonado y retorna un SeguroDTO con todos los datos del seguro.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SeguroDTO consultarSeguroTelefonico(com.tmmas.gte.integraciongtecommon.dto.SeguroInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarSeguroTelefonico:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.SeguroDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.SeguroDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_SEGURO_PR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumeroAbonado());
			logger.debug("numeroAbonado[" + inParam0.getNumeroAbonado() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.DOUBLE);
			cstmt.registerOutParameter(6,java.sql.Types.DATE);
			cstmt.registerOutParameter(7,java.sql.Types.DATE);
			cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.DOUBLE);
			cstmt.registerOutParameter(12,java.sql.Types.DOUBLE);
			cstmt.registerOutParameter(13,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(13));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(14));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(15));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setCodSeguro(cstmt.getString(2));
			logger.debug("codSeguro[" + outParam0.getCodSeguro() + "]");

			outParam0.setDesSeguro(cstmt.getString(3));
			logger.debug("desSeguro[" + outParam0.getDesSeguro() + "]");

			outParam0.setNumeroEventos(cstmt.getLong(4));
			logger.debug("numeroEventos[" + outParam0.getNumeroEventos() + "]");

			outParam0.setImporteEquipo(cstmt.getDouble(5));
			logger.debug("importeEquipo[" + outParam0.getImporteEquipo() + "]");

			outParam0.setFecAlta(new java.util.Date(cstmt.getDate(6).getTime()));
			logger.debug("fecAlta[" + outParam0.getFecAlta() + "]");

			outParam0.setFecFinContrato(new java.util.Date(cstmt.getDate(7).getTime()));
			logger.debug("fecFinContrato[" + outParam0.getFecFinContrato() + "]");

			outParam0.setNumMaxen(cstmt.getLong(8));
			logger.debug("numMaxen[" + outParam0.getNumMaxen() + "]");

			outParam0.setTipCobertura(cstmt.getLong(9));
			logger.debug("tipCobertura[" + outParam0.getTipCobertura() + "]");

			outParam0.setDesValor(cstmt.getString(10));
			logger.debug("desValor[" + outParam0.getDesValor() + "]");

			outParam0.setDeducible(cstmt.getDouble(11));
			logger.debug("deducible[" + outParam0.getDeducible() + "]");

			outParam0.setImpSegur(cstmt.getDouble(12));
			logger.debug("impSegur[" + outParam0.getImpSegur() + "]");

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

		logger.info("consultarSeguroTelefonico:end()");
		return outParam0;
	}	
	
	
}