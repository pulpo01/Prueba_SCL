/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;
import java.util.ArrayList;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtebo.helper.Global;
import com.tmmas.cl.framework20.util.ServiceLocator;

public class PlanTarifarioDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements PlanTarifarioDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(PlanTarifarioDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public PlanTarifarioDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanTarifario(com.tmmas.gte.integraciongtecommon.dto.ConPlanDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarPlanTarifario:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO();
		boolean commited = true;
		try {
		
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
			
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_PLANTARIF_PR(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumeroTelefono());
			logger.debug("numeroTelefono[" + inParam0.getNumeroTelefono() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

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

			outParam1.setCodPlanTarifario(cstmt.getString(2)); 
			logger.debug("codPlanTarifario[" + outParam1.getCodPlanTarifario() + "]");

			outParam1.setDesPlanTarifario(cstmt.getString(3));
			logger.debug("desPlanTarifario[" + outParam1.getDesPlanTarifario() + "]");

			logger.info("Seteando propiedades hijas a la clase padre...");
			ArrayList listaNueva = new ArrayList();
			listaNueva.add(outParam1);

			outParam0.setListPlanTarifario((com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO[])
					com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaNueva.toArray(),
											com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO.class));
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
				if (!commited) {
					conn.rollback();
				}
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

		logger.info("consultarPlanTarifario:end()");
		return outParam0;
	}

	/**
	* Retorna todos los planes tarifarios vigentes
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanesDisponibles()
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarPlanesDisponibles:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_cons_planes_disponibles_pr(?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("declara parametros de salida...");
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
				com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO dto1 = new com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO();

				dto1.setCodPlanTarifario(rs.getString("cod_plantarif"));
				logger.debug("codPlanTarifario[" + dto1.getCodPlanTarifario() + "]");

				dto1.setDesPlanTarifario(rs.getString("des_plantarif"));
				logger.debug("desPlanTarifario[" + dto1.getDesPlanTarifario() + "]");

				dto1.setGrpPrestacion(rs.getString("grp_prestacion"));
				logger.debug("grpPrestacion[" + dto1.getGrpPrestacion() + "]");

				dto1.setDesGrupoPrestacion(rs.getString("des_grupo_prestacion"));
				logger.debug("desGrupoPrestacion[" + dto1.getDesGrupoPrestacion() + "]");

				dto1.setCodPrestacion(rs.getString("cod_prestacion"));
				logger.debug("codPrestacion[" + dto1.getCodPrestacion() + "]");

				dto1.setDesPrestacion(rs.getString("des_prestacion"));
				logger.debug("desPrestacion[" + dto1.getDesPrestacion() + "]");

				lista1.add(dto1);
			}
			logger.info("Recuperando cursor1:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor1 en clase de salida....");
			outParam0.setListPlanTarifario((com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista1.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO.class));

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

		logger.info("consultarPlanesDisponibles:end()");
		return outParam0;
	}

	/**
	* Retorna todos los planes tarifarios vigentes filtrando por grpPrestacion
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanesDisponibles(com.tmmas.gte.integraciongtecommon.dto.GrupoPrestacionDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarPlanesDisponibles:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_cons_planes_disponibles_pr(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getGrpPrestacion());
			logger.debug("grpPrestacion[" + inParam0.getGrpPrestacion() + "]");

			logger.info("declara parametros de salida...");
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
				com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO dto2 = new com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO();

				dto2.setCodPlanTarifario(rs.getString("cod_plantarif"));
				logger.debug("codPlanTarifario[" + dto2.getCodPlanTarifario() + "]");

				dto2.setDesPlanTarifario(rs.getString("des_plantarif"));
				logger.debug("desPlanTarifario[" + dto2.getDesPlanTarifario() + "]");

				dto2.setGrpPrestacion(rs.getString("grp_prestacion"));
				logger.debug("grpPrestacion[" + dto2.getGrpPrestacion() + "]");

				dto2.setDesGrupoPrestacion(rs.getString("des_grupo_prestacion"));
				logger.debug("desGrupoPrestacion[" + dto2.getDesGrupoPrestacion() + "]");

				dto2.setCodPrestacion(rs.getString("cod_prestacion"));
				logger.debug("codPrestacion[" + dto2.getCodPrestacion() + "]");

				dto2.setDesPrestacion(rs.getString("des_prestacion"));
				logger.debug("desPrestacion[" + dto2.getDesPrestacion() + "]");

				lista2.add(dto2);
			}
			logger.info("Recuperando cursor2:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor2 en clase de salida....");
			outParam0.setListPlanTarifario((com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista2.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO.class));

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

		logger.info("consultarPlanesDisponibles:end()");
		return outParam0;
	}

	/**
	* Retorna todos los planes tarifarios vigentes filtrando por grpPrestacion y codPrestacion
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanesDisponibles(com.tmmas.gte.integraciongtecommon.dto.GrpCodPrestacionDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarPlanesDisponibles:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_cons_planes_disponibles_pr(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getGrpPrestacion());
			logger.debug("grpPrestacion[" + inParam0.getGrpPrestacion() + "]");

			cstmt.setString(2,inParam0.getCodPrestacion());
			logger.debug("codPrestacion[" + inParam0.getCodPrestacion() + "]");

			logger.info("declara parametros de salida...");
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
				com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO dto3 = new com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO();

				dto3.setCodPlanTarifario(rs.getString("cod_plantarif"));
				logger.debug("codPlanTarifario[" + dto3.getCodPlanTarifario() + "]");

				dto3.setDesPlanTarifario(rs.getString("des_plantarif"));
				logger.debug("desPlanTarifario[" + dto3.getDesPlanTarifario() + "]");

				dto3.setGrpPrestacion(rs.getString("grp_prestacion"));
				logger.debug("grpPrestacion[" + dto3.getGrpPrestacion() + "]");

				dto3.setDesGrupoPrestacion(rs.getString("des_grupo_prestacion"));
				logger.debug("desGrupoPrestacion[" + dto3.getDesGrupoPrestacion() + "]");

				dto3.setCodPrestacion(rs.getString("cod_prestacion"));
				logger.debug("codPrestacion[" + dto3.getCodPrestacion() + "]");

				dto3.setDesPrestacion(rs.getString("des_prestacion"));
				logger.debug("desPrestacion[" + dto3.getDesPrestacion() + "]");

				lista3.add(dto3);
			}
			logger.info("Recuperando cursor3:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor3 en clase de salida....");
			outParam0.setListPlanTarifario((com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista3.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO.class));

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

		logger.info("consultarPlanesDisponibles:end()");
		return outParam0;
	}
	/**
	* Consulta la bolsa asociada a un plan tarifario
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BolsaResponseDTO consultarBolsaPlanTarifario(com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarBolsaPlanTarifario:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.BolsaResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.BolsaResponseDTO();
		boolean commited = true;
		try {
		
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
			
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_BOLSA_PLANTARIF_PR(?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getCodPlanTarifario());
			logger.debug("planTarifario[" + inParam0.getCodPlanTarifario() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.DATE);
			cstmt.registerOutParameter(6,java.sql.Types.DATE);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(8));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(9));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(10));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			outParam0.setCodBolsa(cstmt.getString(2)); 
			logger.debug("codBolsa[" + outParam0.getCodBolsa() + "]");

			outParam0.setIndUnidad(cstmt.getString(3));
			logger.debug("indUnidad[" + outParam0.getIndUnidad() + "]");

			outParam0.setCntBolsa(cstmt.getLong(4));
			logger.debug("cntBolsa[" + outParam0.getCntBolsa() + "]");

			outParam0.setFecIniVig(cstmt.getDate(5));
			logger.debug("fecIniVig[" + outParam0.getFecIniVig() + "]");

			outParam0.setFecTerVig(cstmt.getDate(6));
			logger.debug("fecTerVig[" + outParam0.getFecTerVig() + "]");

			outParam0.setDesUnidad(cstmt.getString(7));
			logger.debug("des_uUnidad[" + outParam0.getDesUnidad() + "]");
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
				if (!commited) {
					conn.rollback();
				}
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

		logger.info("consultarBolsaPlanTarifario:end()");
		return outParam0;
	}


}