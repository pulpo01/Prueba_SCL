package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.ParametrosGeneralesDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;

public class ParametrosGeneralesDAO extends ConnectionDAO implements ParametrosGeneralesDAOIT{
	
	private final Logger logger = Logger.getLogger(ParametrosGeneralesDAO.class);
	Global global = Global.getInstance();
	
	private Connection getConection() throws ProductOfferingException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new ProductOfferingException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}//fin getConection
	
	private String getSQLParametrosGenerales(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatosAbonado
	
	
	/**
	 * Obtiene Parametros Generales
	 * @param parametroGeneral 
	 * @return resultado
	 * @throws ProductDomainException
	 */
	
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO parametrogeneral) 
	throws ProductOfferingException{
		ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:ParametrosGeneralesDAO:getParametroGeneral()");
			conn = getConection();
			String call = getSQLParametrosGenerales("VE_intermediario_PG","VE_obtiene_valor_parametro_PR",7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametrogeneral.getNombreparametro());
			cstmt.setString(2, parametrogeneral.getCodigomodulo());
			cstmt.setString(3, parametrogeneral.getCodigoproducto());
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:ParametrosGeneralesDAO:getParametroGeneral:execute");
			cstmt.execute();
			logger.debug("Fin:ParametrosGeneralesDAO:getParametroGeneral:execute");
			codError= cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);
			logger.debug("msgError[" + msgError + "]");
			if (codError!=0){
				//TODO: verificar si corresponde un error
				//throw new ProductOfferingException(String.valueOf(codError),numEvento,msgError);
				resultado=null;
			} 
			else{
				resultado.setNombreparametro(parametrogeneral.getNombreparametro());
				resultado.setCodigomodulo(parametrogeneral.getCodigomodulo());
				resultado.setCodigoproducto(parametrogeneral.getCodigoproducto());
				resultado.setValorparametro(cstmt.getString(4));
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener parametro general",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
			  logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:ParametrosGeneralesDAO:getParametroGeneral()");
		return resultado;
	}//fin getParametroGeneral
	
	
	/**
	 * Obtiene Parametro de Facturación
	 * @param parametroGeneral 
	 * @return resultado
	 * @throws ProductDomainException
	 */

	
	public ParametrosGeneralesDTO getParametroFacturacion(ParametrosGeneralesDTO parametrogeneral) throws ProductOfferingException{
		ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getParametroFacturacion()");
			
			String call = getSQLParametrosGenerales("VE_servicios_venta_PG","VE_obtiene_parametro_fact_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametrogeneral.getNombreparametro());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getParametroGeneral:execute");
			cstmt.execute();
			logger.debug("Fin:getParametroGeneral:execute");

			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");

			resultado.setValorparametro(cstmt.getString(2));
		
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener parametro de facturacion",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:getParametroFacturacion()");
		return resultado;
	}//fin getParametroFacturacion
	
	
	/**
	 * Obtiene Parametro de Grupo Tecnologico
	 * @param parametroGeneral 
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public ParametrosGeneralesDTO getParametroGrupoTecnologico(ParametrosGeneralesDTO parametroGeneral) throws GeneralException{
		ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:ParametrosGeneralesDAO:getParametroGrupoTecnologico()");
			
			String call = getSQLParametrosGenerales("VE_intermediario_PG","VE_ObtieneGrupoTecnologico_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroGeneral.getNombreparametro());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:ParametrosGeneralesDAO:getParametroGrupoTecnologico:execute");
			cstmt.execute();
			logger.debug("Fin:ParametrosGeneralesDAO:getParametroGrupoTecnologico:execute");

			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");

			resultado.setValorparametro(cstmt.getString(2));
		
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener parametro general",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:ParametrosGeneralesDAO:getParametroGrupoTecnologico()");
		return resultado;
	}//fin getParametroGrupoTecnologico

}//fin ParametrosGeneralesDAO

	
	
	
	
	
	
	
	
	
	
	
	
	


