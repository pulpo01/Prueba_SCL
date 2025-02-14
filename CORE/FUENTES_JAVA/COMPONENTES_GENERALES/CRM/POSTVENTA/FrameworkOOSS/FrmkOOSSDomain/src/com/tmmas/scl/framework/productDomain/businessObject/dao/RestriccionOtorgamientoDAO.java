package com.tmmas.scl.framework.productDomain.businessObject.dao;

/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 07/06/2007	     	Esteban Conejeros       				Versión Inicial
 * 30/07/2007			Cristian Toledo							Agregar llamada Pls.
 */
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.RestriccionOtorgamientoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RestriccionesContratacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductSpecificationException;

public class RestriccionOtorgamientoDAO extends ConnectionDAO implements
	RestriccionOtorgamientoDAOIT {

	private final Logger logger = Logger.getLogger(RestriccionOtorgamientoDAO.class);

	private final Global global = Global.getInstance();
	
	private String getSQLobtenerRestriccionesContratacion() 
	{
		StringBuffer call = new StringBuffer();
		call.append("DECLARE ");
		call.append("  EO_RESTRICCIONES PF_RESTR_CONTRATA_TD_QT; ");
		call.append("  SO_LISTA_RESTRICCIONES PF_RESTRICCIONES_PG.refCursor; ");
		call.append("  SN_COD_RETORNO NUMBER; ");
		call.append("  SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("  SN_NUM_EVENTO NUMBER; ");
		call.append("BEGIN ");
		call.append("  PF_RESTRICCIONES_PG.PF_GENERAL_S_PR(?,?,?,?,?); ");    
		call.append("END; ");
		return call.toString();		
	}	
	
	private String getSQLobtenerRestriccionesContratacionProducto() {
		StringBuffer call = new StringBuffer();
		call.append("DECLARE ");
		call.append("  EO_RESTRICCIONES PF_RESTR_CONTRATA_TD_QT; ");
		call.append("  SO_LISTA_RESTRICCIONES PF_RESTRICCIONES_PG.refCursor; ");
		call.append("  SN_COD_RETORNO NUMBER; ");
		call.append("  SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("  SN_NUM_EVENTO NUMBER; ");
		call.append("BEGIN ");
		call.append("  PF_RESTRICCIONES_PG.PF_PRODUCTO_S_PR(?,?,?,?,?); ");    
		call.append("END; ");
		return call.toString();		
	}	
	
	/**
	 * 
	 * 
	 * @param RestriccionesContratacionDTO
	 * @return RestriccionesContratacionDTO
	 * @throws ProductSpecificationException
	 */	
	public RestriccionesContratacionDTO obtenerRestriccionesContratacion(RestriccionesContratacionDTO restriccion)
			throws ProductSpecificationException {
		logger.debug("obtenerRestriccionesContratacion():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLobtenerRestriccionesContratacion();
		try {
			// DEFINIR BIEN LA BUSQUEDA ACA //
			logger.debug("restriccion[" + restriccion + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("PF_RESTR_CONTRATA_TD_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, restriccion.getStruct_PF_RESTR_CONTRATA_TD_QT());
			
//			 SE LLENAN PARAMETROS SEGUN PL
			cstmt.setObject(1, oracleObject);			
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);		
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener Restricciones Contratacion");
				throw new ProductSpecificationException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini-----------OBTENER CURSORES DE SERVICIOS A ACTIVAR Y DESACTIVAR-------
			ResultSet rs=(ResultSet)cstmt.getObject(2);
			
			if(rs.next())
			{				
				restriccion.setTipoPlataforma(rs.getString("IND_TIPO_PLATAFORMA")!=null?rs.getString("IND_TIPO_PLATAFORMA"):"");
				restriccion.setIndAplica(rs.getString("IND_NIVEL_APLICA")!=null?rs.getString("IND_NIVEL_APLICA"):"");
				restriccion.setTipoComportamiento(rs.getString("TIPO_COMPORTAMIENTO")!=null?rs.getString("TIPO_COMPORTAMIENTO"):"");
				restriccion.setCodProducto(rs.getString("COD_PROD")!=null?rs.getString("COD_PROD"):"");
				restriccion.setFecInicio(rs.getDate("FEC_INI_VIG")!=null?rs.getDate("FEC_INI_VIG"):new Date(0));
				restriccion.setCantidadMaxima(rs.getString("CAN_MAX")!=null?rs.getInt("CAN_MAX"):-1);
				restriccion.setMontoMaximo(rs.getString("MTO_MAX")!=null?rs.getString("MTO_MAX"):"");
				restriccion.setMinimoCiclos(rs.getString("MIN_CICLOS")!=null?rs.getString("MIN_CICLOS"):"");
				restriccion.setFecTermino(rs.getDate("FEC_TER_VIG")!=null?rs.getDate("FEC_TER_VIG"):new Date(0));				
			}			
			//fin-------------------------------------------------------------------
		
		} catch (ProductSpecificationException e) {
			logger.debug("ProductSpecificationException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Restricciones Contratacion", e);
			throw new ProductSpecificationException("Ocurrió un error general al obtener Restricciones Contratacion",e);
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
		logger.debug("obtenerRestriccionesContratacion():end");
		return restriccion;
	}

	public RestriccionesContratacionDTO obtenerRestriccionesContratacion(ProductoOfertadoDTO producto) throws ProductSpecificationException {
		logger.debug("obtenerRestriccionesContratacion():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		
		RestriccionesContratacionDTO restriccion = new RestriccionesContratacionDTO();
		restriccion.setCodProducto(producto.getIdProductoOfertado());
		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLobtenerRestriccionesContratacionProducto();
		try {
			// DEFINIR BIEN LA BUSQUEDA ACA //
			logger.debug("producto.getIdProductoOfertado()[" + producto.getIdProductoOfertado() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("PF_RESTR_CONTRATA_TD_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, restriccion.getStruct_PF_RESTR_CONTRATA_TD_QT());
			
//			 SE LLENAN PARAMETROS SEGUN PL
			cstmt.setObject(1, oracleObject);			
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);		
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener Restricciones Contratacion");
				throw new ProductSpecificationException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini-----------OBTENER CURSORES DE SERVICIOS A ACTIVAR Y DESACTIVAR-------
			ResultSet rs=(ResultSet)cstmt.getObject(2);
			
			if(rs.next())
			{				
				restriccion.setTipoPlataforma(rs.getString("IND_TIPO_PLATAFORMA")!=null?rs.getString("IND_TIPO_PLATAFORMA"):"");
				restriccion.setIndAplica(rs.getString("IND_NIVEL_APLICA")!=null?rs.getString("IND_NIVEL_APLICA"):"");
				restriccion.setTipoComportamiento(rs.getString("TIPO_COMPORTAMIENTO")!=null?rs.getString("TIPO_COMPORTAMIENTO"):"");
				restriccion.setCodProducto(rs.getString("COD_PROD")!=null?rs.getString("COD_PROD"):"");
				restriccion.setFecInicio(rs.getDate("FEC_INI_VIG")!=null?rs.getDate("FEC_INI_VIG"):new Date(0));
				restriccion.setCantidadMaxima(rs.getString("CAN_MAX")!=null?rs.getInt("CAN_MAX"):-1);
				restriccion.setMontoMaximo(rs.getString("MTO_MAX")!=null?rs.getString("MTO_MAX"):"");
				restriccion.setMinimoCiclos(rs.getString("MIN_CICLOS")!=null?rs.getString("MIN_CICLOS"):"");
				restriccion.setFecTermino(rs.getDate("FEC_TER_VIG")!=null?rs.getDate("FEC_TER_VIG"):new Date(0));				
			}			
			
			//fin-------------------------------------------------------------------
		
		} catch (ProductSpecificationException e) {
			logger.debug("ProductSpecificationException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Restricciones Contratacion", e);
			throw new ProductSpecificationException("Ocurrió un error general al obtener Restricciones Contratacion",e);
		}
		finally 
		{
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
		logger.debug("obtenerRestriccionesContratacion():end");
		return restriccion;
	}

}
