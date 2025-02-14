/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 31/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.OrdenServicioDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerOrderException;

public class OrdenServicioDAO extends ConnectionDAO implements
		OrdenServicioDAOIT {

	private final Logger logger = Logger.getLogger(OrdenServicioDAO.class);

	private final Global global = Global.getInstance();
	
	private String getSQLObtenerParametroGeneral() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("   so_param PV_GED_PARAMETROS_QT := PV_INICIA_ESTRUCTURAS_PG.PV_GED_PARAMETROS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_param.NOM_PARAMETRO := ?;");
		call.append("   so_param.COD_MODULO := ?;");
		call.append("   so_param.COD_PRODUCTO := ?;");
		call.append("   PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR( so_param, ?, ?, ?);");
		call.append("		? := so_param.VAL_PARAMETRO;");
		call.append("		? := so_param.DES_PARAMETRO;");
		call.append(" END;");		
		return call.toString();		
	}
	
	private String getSQLobtenerSecuencia() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_secuencia PV_SECUENCIA_QT := PV_INICIA_ESTRUCTURAS_PG.PV_SECUENCIA_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_secuencia.NOM_SECUENCIA := ?;");
		call.append("   PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR( eo_secuencia, ?, ?, ?);");
		call.append("   			? := eo_secuencia.NUM_SECUENCIA ;");
		call.append(" END;");
		return call.toString();		
	}	
	
	/**
	 * Obtiene informacion de parámetros de la tabla GED_PARAMETROS
	 * 
	 * @param param
	 * @return ParametroDTO
	 * @throws CustomerOrderException
	 */
	public ParametroDTO obtenerParametroGeneral(ParametroDTO param) throws CustomerOrderException{	
		logger.debug("obtenerParametrosGenerales():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ParametroDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLObtenerParametroGeneral();

		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("param.getNomParametro()[" + param.getNomParametro() + "]");
			logger.debug("param.getCodModulo()[" + param.getCodModulo() + "]");	
			logger.debug("param.getCodProducto()[" + param.getCodProducto() + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, param.getNomParametro());
			cstmt.setString(2, param.getCodModulo());
			cstmt.setInt(3, param.getCodProducto());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); //VAL_PARAMETRO
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); //DES_PARAMETRO
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al recuperar parametro general");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			String valor = cstmt.getString(7);
			logger.debug("valor[" + valor + "]");
			
			String descripcion = cstmt.getString(8);
			logger.debug("descripcion[" + descripcion + "]");	
			
			respuesta = param;
			respuesta.setValor(valor);
			respuesta.setDescripcion(descripcion);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar parametro general", e);
			throw new CustomerOrderException("Ocurrió un error general al recuperar parametro general",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerParametrosGenerales():end");
		return respuesta;
	}
	
	/**
	 * Recupera valor de una secuencia
	 * 
	 * @param secuencia
	 * @return SecuenciaDTO
	 * @throws CustomerOrderException
	 */
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws CustomerOrderException{
		logger.debug("obtenerSecuencia():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		SecuenciaDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerSecuencia();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("secuencia.getNomSecuencia()[" + secuencia.getNomSecuencia() + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, secuencia.getNomSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //NUM_SECUENCIA
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener el número de secuencia");
				throw new CustomerOrderException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			long numSecuencia = cstmt.getLong(5);
			logger.debug("numSecuencia[" + numSecuencia + "]");
			
			respuesta = secuencia;
			respuesta.setNumSecuencia(numSecuencia);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al obtener el número de secuencia", e);
			throw new CustomerOrderException("Ocurrió un error general al obtener el número de secuencia",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerSecuencia():end");
		return respuesta;	
	}
	
}
