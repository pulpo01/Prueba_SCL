package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
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
	
	public String getCodigoOperadora() throws ProductException{
		logger.debug("Inicio:getCodigoOperadora()");
		int codError = 0;
		String resultado = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		logger.debug("Coneccion obtenida OK");
		try {
			String call = getSQL("VE_intermediario_PG","VE_ObtieneOperadora_PR",4);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			
			logger.debug("inicio:Execute");
			cstmt.execute();
			logger.debug("Fin:Execute");

			resultado = cstmt.getString(1);

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			if (codError != 0) {
				logger.error("Ocurrió un error al obener codigo operadora");
				throw new ProductException(
						"Ocurrió un error al obener codigo operadora", String
								.valueOf(codError), numEvento, msgError);
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}

		} catch (Exception e) {
			logger.error("Ocurrió un error al obener codigo operadora",e);
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
		logger.debug("Fin:getCodigoOperadora()");
		return resultado;
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
	
	/**
	 * Obtiene actuacion en central para la actuacion del abonado
	 * @param datosGenerales
	 * @return datosGenerales
	 * @throws ProductException
	 */
	public DatosGeneralesDTO getActuacionCentral(DatosGeneralesDTO datosGenerales) 
	throws ProductException{
		logger.debug("Inicio:getActuacionCentral()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			String call = getSQL("PV_SERVICIOS_POSVENTA_PG","VE_obtiene_actua_central_PR",7);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,datosGenerales.getCodigoActuacionAbonado());
			logger.debug("datosGenerales.getCodigoActuacionAbonado(): " + datosGenerales.getCodigoActuacionAbonado());
			cstmt.setString(2,datosGenerales.getCodigoProducto());
			logger.debug("datosGenerales.getCodigoProducto(): " + datosGenerales.getCodigoProducto());
			cstmt.setString(3,datosGenerales.getCodigoTecnologia());
			logger.debug("datosGenerales.getCodigoTecnologia(): " + datosGenerales.getCodigoTecnologia());
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			
			logger.debug("inicio:getActuacionCentral:Execute");
			cstmt.execute();
			logger.debug("Fin:getActuacionCentral:Execute");

			datosGenerales.setCodigoActuacionCentral(cstmt.getString(4));

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			if (codError != 0) {
				logger.error("Línea, no es posible aprovicionar en red");
				throw new ProductException(
						"Línea, no es posible aprovicionar en red", String
								.valueOf(codError), numEvento, msgError);
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener actuacion en central para la actuacion del abonado",e);
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
		logger.debug("Fin:getActuacionCentral()");
		return datosGenerales;
	}//fin getActuacionCentral
	
	/**
	 * Obtiene secuencia
	 * @param parametroEntrada
	 * @return resultado
	 * @throws ProductException
	 */
	
	public DatosGeneralesDTO getSecuencia(DatosGeneralesDTO datosGenerales) 
	throws ProductException{
		DatosGeneralesDTO resultado=new DatosGeneralesDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getSecuencia");
			
			String call = getSQL("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,datosGenerales.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getSecuencia:execute");
			cstmt.execute();
			logger.debug("Fin:getSecuencia:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			logger.debug("msgError[" + msgError + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener Secuencia");
				throw new ProductException(
						"Ocurrió un error al obtener Secuencia", String
								.valueOf(codError), numEvento, msgError);
			}else
				resultado.setSecuencia(Long.parseLong(cstmt.getString(2)));
		
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener la secuencia",e);
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

		logger.debug("Fin:getSecuencia");

		return resultado;
	}

	/**
	 * Obtiene lista de codigos 
	 * @param entrada
	 * @return resultado
	 * @throws ProductException
	 */
	public DatosGeneralesDTO[] getListCodigos(DatosGeneralesDTO entrada) 
	throws ProductException{
		logger.debug("Inicio:getListCodigos()");
		DatosGeneralesDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQL("VE_alta_cliente_PG","VE_getListGedCodigos_PR",7);

			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoModulo());
			cstmt.setString(2,entrada.getTabla());
			cstmt.setString(3,entrada.getColumna());
			cstmt.registerOutParameter(4,OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListCodigos:execute");
			cstmt.execute();
			logger.debug("Fin:getListCodigos:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar lista de codigos");
				throw new ProductException(
						"Ocurrió un error al recuperar lista de codigos", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando lista de codigos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(4);
				while (rs.next()) {
					DatosGeneralesDTO datosgeneralesDTO = new DatosGeneralesDTO();
					datosgeneralesDTO.setCodigoValor(rs.getString(1));
					datosgeneralesDTO.setDescripcionValor(rs.getString(2));
					
					lista.add(datosgeneralesDTO);
				}
				rs.close();
				resultado =(DatosGeneralesDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), DatosGeneralesDTO.class);
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar lista de codigos",e);
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
		logger.debug("Fin:getListCodigos()");
		return resultado;
	}//fin getListCodigos
	
	/**
	 * Obtiene los datos del producto 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public DatosGeneralesDTO getProducto(DatosGeneralesDTO entrada) 
	throws ProductException{
		logger.debug("Inicio:getProducto()");
		DatosGeneralesDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			String call = getSQL("PV_SERVICIOS_POSVENTA_PG","VE_con_producto_PR",5);
			
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setInt(1,Integer.parseInt(entrada.getCodigoProducto()));
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getArticulo:execute");
			cstmt.execute();
			logger.debug("Fin:getArticulo:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("msgError[" + msgError + "]");
			if (codError!=0){
				logger.error("Ocurrió un error al recuperar los datos del producto");
				throw new ProductException(
						"Ocurrió un error al recuperar los datos del producto", String
								.valueOf(codError), numEvento, msgError);
			}
			else
			{
				resultado.setDescripcionProducto(cstmt.getString(2));
				
			}
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar los datos del producto",e);
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
		logger.debug("Fin:getProducto()");
		return resultado;
	}//fin getProducto

	
}//fin CLASS DatosGeneralesDAO