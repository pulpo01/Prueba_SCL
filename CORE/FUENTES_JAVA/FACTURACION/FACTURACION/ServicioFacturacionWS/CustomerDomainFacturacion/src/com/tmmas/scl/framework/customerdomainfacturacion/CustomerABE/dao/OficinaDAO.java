//
//
//  Generated by StarUML(tm) Java Add-In
//
//  @ Project : P-TMM-08004
//  @ File Name : OficinaDAO.java
//  @ Date : 09/09/2008
//  @ Author : hsegura
//
//

package com.tmmas.scl.framework.customerdomainfacturacion.CustomerABE.dao;

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
import com.tmmas.scl.framework.CustomerDomain.CustomerABE.dto.OficinaDTO;
import com.tmmas.scl.framework.CustomerDomain.exception.RateUsageRecordsException;
import com.tmmas.scl.framework.Sistema.helper.FacturaConnectionPool;
import com.tmmas.scl.framework.customerdomainfacturacion.CustomerABE.dao.Interface.OficinaDAOIT;

public class OficinaDAO extends ConnectionDAO implements OficinaDAOIT {
	public void obtenerOficina() {

	}

	private static FacturaConnectionPool myConnectionPool = FacturaConnectionPool
			.getInstance();

	private static Logger logger = Logger.getLogger(OficinaDAO.class);

	private CompositeConfiguration config;

	public OficinaDAO() {
		super();
		config = UtilProperty
				.getConfiguration("ServicioFacturacionWS.properties",
						"com/tmmas/scl/framework/properties/archivorecursos.properties");
	}

	public OficinaDTO obtenerOficina(String codUsuario)
			throws RateUsageRecordsException {
		logger.debug("obtenerOficina():start");
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;

		CallableStatement cstmt = null;
		OficinaDTO oficinaDTO = new OficinaDTO();
		/**
		 * GA_OBTENEROFICINA_PR (EV_NOMUSUARIO IN VARCHAR2,
		 * 
		 * SV_CODOFICINA OUT NOCOPY VARCHAR2,
		 * 
		 * SV_COD_REGION OUT NOCOPY VARCHAR2,
		 * 
		 * SV_COD_PROVINCIA OUT NOCOPY VARCHAR2,
		 * 
		 * SV_COD_COMUNA OUT NOCOPY VARCHAR2,
		 * 
		 * SN_CODVENDEDOR OUT NOCOPY NUMBER,
		 * 
		 * SN_COD_RETORNO OUT NOCOPY NUMBER,
		 * 
		 * SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
		 * 
		 * SN_NUM_EVENTO OUT NOCOPY NUMBER)
		 */
		String call = "{call GA_CUSTOMER_ABE_PG.GA_OBTENEROFICINA_PR (?,?,?,?,?,?,?,?,?)}";
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
			logger.debug("Parámetros de entrada :  ");
			logger.debug("EV_NOMUSUARIO [" + codUsuario + "]");			
			try {
				cstmt = conn.prepareCall(call,
						ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
				cstmt.setString(1, codUsuario);
				cstmt.registerOutParameter(2, Types.VARCHAR);
				cstmt.registerOutParameter(3, Types.VARCHAR);
				cstmt.registerOutParameter(4, Types.VARCHAR);
				cstmt.registerOutParameter(5, Types.VARCHAR);

				cstmt.registerOutParameter(6, Types.VARCHAR);
				cstmt.registerOutParameter(7, Types.NUMERIC);
				cstmt.registerOutParameter(8, Types.VARCHAR);
				cstmt.registerOutParameter(9, Types.NUMERIC);
				cstmt.execute();

				long codigoError = cstmt.getLong(7);
				String msError = cstmt.getString(8);
				long snEvento = cstmt.getLong(9);

				logger.debug("Despues de execute() ");
				logger.debug("Valor de  SN_ERROR [" + codigoError + "]");
				logger.debug("Valor de  SV_MENSAJE[" + msError + "]");
				logger.debug("Valor de  SN_EVENTO[" + snEvento + "]");

				if (codigoError == 0) {
					oficinaDTO.setCodOficina(cstmt.getString(2));
					oficinaDTO.setRegion(cstmt.getString(3));
					oficinaDTO.setProvincia(cstmt.getString(4));
					oficinaDTO.setComuna(cstmt.getString(5));
					oficinaDTO.setCodVendedor(String.valueOf(cstmt.getLong(6)));
				} else
					throw new RateUsageRecordsException(String
							.valueOf(codigoError), 0, "SQLException : "
							+ msError);
			} catch (SQLException e) {
				logger.debug("SQLException ", e);
				throw new RateUsageRecordsException(String.valueOf(e
						.getErrorCode()), 0, "SQLException : " + e.getMessage());

			}

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
		logger.debug("obtenerOficina():end");
		return oficinaDTO;
	}

	public void obtenerZonaImpositiva() {
		// TODO Auto-generated method stub

	}

}
