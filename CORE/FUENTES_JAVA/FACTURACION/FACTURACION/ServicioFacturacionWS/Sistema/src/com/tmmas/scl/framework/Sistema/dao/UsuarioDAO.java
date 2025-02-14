/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 09/09/2008         Hernán Segura Muñoz                  Versión Inicial 
 * 
 *
 * 
 * UsuarioDAO
 * @author Hernán Segura Muñoz 
 * @version 1.0
 **/
package com.tmmas.scl.framework.Sistema.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.framework.CustomerDomain.exception.RateUsageRecordsException;
import com.tmmas.scl.framework.Sistema.dao.Interface.UsuarioDAOIT;
import com.tmmas.scl.framework.Sistema.dto.UsuarioQueryDTO;
import com.tmmas.scl.framework.Sistema.helper.FacturaConnectionPool;

public class UsuarioDAO extends ConnectionDAO implements UsuarioDAOIT {

	private static FacturaConnectionPool myConnectionPool = FacturaConnectionPool
			.getInstance();

	private static Logger logger = Logger.getLogger(UsuarioDAO.class);

	private CompositeConfiguration config;
	private long codigoError;
	private String msError;
	private long snEvento;
	public UsuarioDAO() {
		super();
		config = UtilProperty
				.getConfiguration("ServicioFacturacionWS.properties",
						"com/tmmas/scl/framework/properties/archivorecursos.properties");
	}

	public boolean recuperarRol(UsuarioQueryDTO usuarioQueryDTO)
			throws RateUsageRecordsException {

		logger.debug("recuperarRol():start");
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;

		CallableStatement cstmt = null;
		/**
		 * ID_USER VARCHAR2(200);
		 * 
		 * PROGRAMA VARCHAR2(200);
		 * 
		 * VERSION NUMBER;
		 * 
		 * SN_COD_RETORNO NUMBER;
		 * 
		 * SV_MENS_RETORNO VARCHAR2(200);
		 * 
		 * SN_NUM_EVENTO NUMBER;
		 * 
		 */
		String call = "{?=call GE_SISTEMA_PG.GE_RECUPERARROL_FN ( ?,?,?,?,?,? ) }";
		logger.debug("Antes de obtener conexion");
		try {
			conn = getConnectionFromWLSInitialContext(myConnectionPool
					.getJndiForDataSource());
		} catch (Exception e1) {
			logger.debug("Exception de conexion", e1);
			throw new RateUsageRecordsException("-2129", 0,
					"No se pudo obtener una conexión : " + e1.getMessage());
		}

		try {
			logger.debug("Antes de ejecutar : " + call);

			cstmt = conn.prepareCall(call, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

			logger.debug("Parámetros ");
			logger.debug("ID_USER [" + usuarioQueryDTO.getNomUsuario() + "]");
			logger.debug("PROGRAMA [" + config.getString("codprograma") + "]");
			logger.debug("VERSION [" + config.getString("versionprograma")
					+ "]");
			cstmt.registerOutParameter(1, Types.NUMERIC);
			cstmt.setString(2, usuarioQueryDTO.getNomUsuario());
			cstmt.setString(3, config.getString("codprograma"));
			cstmt.setInt(4, Integer.parseInt(config
					.getString("versionprograma").trim()));
			cstmt.registerOutParameter(5, Types.NUMERIC);
			cstmt.registerOutParameter(6, Types.VARCHAR);
			cstmt.registerOutParameter(7, Types.NUMERIC);

			cstmt.execute();

			 codigoError = cstmt.getLong(5);
			 msError = cstmt.getString(6);
			 snEvento = cstmt.getLong(7);

			logger.debug("Despues de execute() ");
			logger.debug("Valor de  SN_ERROR [" + codigoError + "]");
			logger.debug("Valor de  SV_MENSAJE[" + msError + "]");
			logger.debug("Valor de  SN_EVENTO[" + snEvento + "]");

			if (codigoError == 0) {
				if (cstmt.getLong(1) == 1) {
					return true;
				}
			} else
				throw new RateUsageRecordsException(
						String.valueOf(codigoError), snEvento, "SQLException : "
								+ msError);
		} catch (SQLException e) {
			logger.debug("SQLException ", e);
			throw new RateUsageRecordsException(String
					.valueOf(e.getErrorCode()), snEvento, "SQLException : "
					+ e.getMessage());

		} finally {
			try {
				if (ps != null) {
					ps.close();
				}

				if (rs != null) {
					rs.close();
				}

				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				logger.debug("Exception ", e);
				throw new RateUsageRecordsException("-2129", 0, "Exception : "
						+ e.getMessage());
			}
		}
		logger.debug("recuperarRol():end");
		return true;
	}

	public String obtenerZonaImpositiva(String codOficina)
			throws RateUsageRecordsException {
		logger.debug("obtenerZonaImpositiva():start");
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		String zona = null;
		CallableStatement cstmt = null;

		String call = "{call GA_CUSTOMER_ABE_PG.GA_OBTENERZONAIMPOSITIVA_PR (?,?,?,?,?)}";
		logger.debug("Antes de obtener conexion");
		try {
			conn = getConnectionFromWLSInitialContext(myConnectionPool
					.getJndiForDataSource());
		} catch (Exception e1) {
			logger.debug("Exception de conexion", e1);
			throw new RateUsageRecordsException("-2129", 0,
					"No se pudo obtener una conexión : " + e1.getMessage());
		}

		try {
			logger.debug("Antes de ejecutar : " + call);

			cstmt = conn.prepareCall(call, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			logger.debug("Parámetros :  ");
			logger.debug("COD_OFICINA  [" + codOficina + "]");
			cstmt.setString(1, codOficina);
			cstmt.registerOutParameter(2, Types.NUMERIC);
			cstmt.registerOutParameter(3, Types.NUMERIC);
			cstmt.registerOutParameter(4, Types.VARCHAR);
			cstmt.registerOutParameter(5, Types.NUMERIC);
			cstmt.execute();

			long codigoError = cstmt.getLong(3);
			String msError = cstmt.getString(4);
			long snEvento = cstmt.getLong(5);

			logger.debug("Despues de execute() ");
			logger.debug("Valor de  SN_ERROR [" + codigoError + "]");
			logger.debug("Valor de  SV_MENSAJE[" + msError + "]");
			logger.debug("Valor de  SN_EVENTO[" + snEvento + "]");

			if (codigoError == 0) {
				zona = String.valueOf(cstmt.getLong(2));
			} else
				throw new RateUsageRecordsException(
						String.valueOf(codigoError), 0, "SQLException : "
								+ msError);
		} catch (SQLException e) {
			logger.debug("SQLException ", e);
			throw new RateUsageRecordsException(String
					.valueOf(e.getErrorCode()), 0, "SQLException : "
					+ e.getMessage());

		} finally {
			try {
				if (ps != null) {
					ps.close();
				}

				if (rs != null) {
					rs.close();
				}

				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				logger.debug("Exception ", e);
				throw new RateUsageRecordsException("-2129", 0, "Exception : "
						+ e.getMessage());
			}
		}
		logger.debug("obtenerZonaImpositiva():end");
		return zona;
	}
}
