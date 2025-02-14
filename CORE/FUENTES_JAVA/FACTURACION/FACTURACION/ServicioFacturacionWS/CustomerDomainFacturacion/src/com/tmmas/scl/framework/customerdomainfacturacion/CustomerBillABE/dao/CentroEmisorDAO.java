package com.tmmas.scl.framework.customerdomainfacturacion.CustomerBillABE.dao;

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
import com.tmmas.scl.framework.Sistema.helper.FacturaConnectionPool;
import com.tmmas.scl.framework.customerdomainfacturacion.CustomerBillABE.dao.Interface.CentroEmisorDAOIT;

public class CentroEmisorDAO extends ConnectionDAO implements CentroEmisorDAOIT {
	private static FacturaConnectionPool myConnectionPool = FacturaConnectionPool
			.getInstance();

	private static Logger logger = Logger.getLogger(CentroEmisorDAO.class);

	private CompositeConfiguration config;

	public CentroEmisorDAO() {
		super();
		config = UtilProperty
				.getConfiguration("ServicioFacturacionWS.properties",
						"com/tmmas/scl/framework/properties/archivorecursos.properties");
	}

	public String obtenerCentroEmisor(String codOficina, String codTipoDocto)
			throws RateUsageRecordsException {
		logger.debug("obtenerCentroEmisor():start");
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		String centro = null;
		CallableStatement cstmt = null;
		/**
		 * PROCEDURE GE_RECCENTREMI_PR (
		 * 
		 * EN_COD_OFICINA IN AL_DOCUM_SUCURSAL.COD_OFICINA%TYPE varchar,
		 * 
		 * EN_COD_TIPDOCUM IN AL_DOCUM_SUCURSAL.COD_TIPDOCUM%TYPE number,
		 * 
		 * SN_COD_CENTREMI OUT AL_DOCUM_SUCURSAL.COD_CENTREMI%TYPE number,
		 * 
		 * SN_COD_RETORNO OUT NOCOPY NUMBER,
		 * 
		 * SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
		 * 
		 * SN_NUM_EVENTO OUT NOCOPY NUMBER
		 */
		String call = "{call GE_SISTEMA_PG.GE_RECCENTREMI_PR( ?,?,?,?,?,? ) }";
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

			logger.debug("Parámetros de entrada : ");
			logger.debug("COD_OFICINA [" + codOficina + "]");
			logger.debug("COD_TIPDOCUM [" + codTipoDocto + "]");
			cstmt.setString(1, codOficina);
			cstmt.setInt(2, Integer.parseInt(codTipoDocto));
			cstmt.registerOutParameter(3, Types.NUMERIC);
			cstmt.registerOutParameter(4, Types.NUMERIC);
			cstmt.registerOutParameter(5, Types.VARCHAR);
			cstmt.registerOutParameter(6, Types.NUMERIC);

			cstmt.execute();

			long codigoError = cstmt.getLong(4);
			String msError = cstmt.getString(5);
			long snEvento = cstmt.getLong(6);

			logger.debug("Despues de execute() ");
			logger.debug("Valor de  SN_ERROR [" + codigoError + "]");
			logger.debug("Valor de  SV_MENSAJE[" + msError + "]");
			logger.debug("Valor de  SN_EVENTO[" + snEvento + "]");

			if (codigoError == 0) {
				centro = String.valueOf(cstmt.getLong(3));
			} else{
				throw new RateUsageRecordsException(
						String.valueOf(codigoError), 0, "SQLException : "
								+ msError);				
			}
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
		logger.debug("obtenerCentroEmisor():end");
		return centro;
	}

}
