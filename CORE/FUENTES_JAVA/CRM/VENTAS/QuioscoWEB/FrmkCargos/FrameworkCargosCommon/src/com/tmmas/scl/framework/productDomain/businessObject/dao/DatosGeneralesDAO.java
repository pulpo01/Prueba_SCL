package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.DatosGeneralesDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class DatosGeneralesDAO extends ConnectionDAO implements DatosGeneralesDAOIT{

	private final Logger logger = Logger.getLogger(DatosGeneralesDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws ProductException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new ProductException("No se pudo obtener una conexión", e1);
		}
		
		return conn;
	}//fin getConection

	private String getSQL(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}//fin getSQL
	
	/**
	 * Obtiene Valor del parametro pasando como filtro el nombre del parametro mas el código de producto y código de módulo.
	 * @param datosGenerales
	 * @return datosGenerales
	 * @throws ProductException
	 */
	
	public DatosGeneralesDTO getValorParametro(DatosGeneralesDTO datosGenerales) throws ProductException{
		logger.debug("Inicio:getValorParametro()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		CallableStatement cstmt = null;
		logger.debug("Coneccion obtenida OK");
		try {
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			String call = getSQL("VE_intermediario_PG","VE_obtiene_valor_parametro_PR",7);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			logger.debug("Codigo Parametro::"+datosGenerales.getCodigoParametro()); 
			cstmt.setString(1,datosGenerales.getCodigoParametro());
			logger.debug("codigo Modulo"+datosGenerales.getCodigoModulo() );
			cstmt.setString(2,datosGenerales.getCodigoModulo());
			logger.debug("Codigo Producto"+datosGenerales.getCodigoProducto());
			cstmt.setInt(3,Integer.parseInt(datosGenerales.getCodigoProducto()));
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.execute();
			
			datosGenerales.setValorParametro(cstmt.getString(4));

			codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar los Datos Generales");
				throw new ProductException(
						"Ocurrió un error al consultar los Datos Generales", String
								.valueOf(codError), numEvento, msgError);
			}
			
			logger.debug("Valor Parametro[" + datosGenerales.getValorParametro() + "]");
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar los Datos Generales",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null){
					cstmt.close();
					cstmt=null;
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getValorParametro()");

		return datosGenerales;
	}//fin getValorParametro
	
	/**
	 * Obtiene Valor del parametro pasando como filtro el nombre del parametro mas el código de producto y código de módulo.
	 * @param datosGenerales
	 * @return datosGenerales
	 * @throws ProductException
	 */
	
	public DatosGeneralesDTO getResultadoTransaccion(DatosGeneralesDTO datosGenerales) throws ProductException{
		logger.debug("Inicio:getResultadoTransaccion()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		logger.debug("Coneccion obtenida OK");
		try {
			String call = getSQL("VE_intermediario_PG","VE_obtiene_transaccion_PR",4);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,datosGenerales.getNumTransaccion());
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			
			logger.debug("inicio:Execute");
			cstmt.execute();
			logger.debug("Fin:Execute");

			datosGenerales.setNumTransaccion(datosGenerales.getNumTransaccion());
			datosGenerales.setCodError(cstmt.getInt(2));
			datosGenerales.setMnsError(cstmt.getString(3));

			logger.debug("Valor Parametro[" + datosGenerales.getValorParametro() + "]");
			logger.debug("getNumTransaccion[" + datosGenerales.getNumTransaccion() + "]");
			logger.debug("getCodError[" + datosGenerales.getCodError() + "]");
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener resultado de la transaccion",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getResultadoTransaccion()");
		return datosGenerales;
	}//fin getResultadoTransaccion

	
}//fin CLASS DatosGeneralesDAO