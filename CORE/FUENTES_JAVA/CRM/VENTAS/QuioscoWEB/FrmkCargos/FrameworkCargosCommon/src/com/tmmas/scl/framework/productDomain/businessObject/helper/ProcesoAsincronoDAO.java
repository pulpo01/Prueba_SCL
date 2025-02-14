/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/08/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.helper;

import java.sql.Connection;
import java.sql.SQLException;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;


public class ProcesoAsincronoDAO extends ConnectionDAO
{
	private final Logger logger = Logger.getLogger(ProcesoAsincronoDAO.class);
	private final Global global = Global.getInstance();
	
	static ProcesoAsincronoDAO instance=null;
	
	public static synchronized ProcesoAsincronoDAO getInstance() {
		if (instance == null) {
			instance =  new ProcesoAsincronoDAO();
		}
		return instance;
	}
	
	private ProcesoAsincronoDAO()
	{
		
	}
	
	private String getSQLinscribeProceso()
	{
		StringBuffer call=new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_PROC_PROD PR_PROCESOS_PROD_TD_QT; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   PR_PROCESOS_PROD_TO_PG.PR_PROCESOS_PROD_U_PR(?,?,?,?,?); ");
		call.append(" END; ");
		return call.toString();
	}
//--------------------------------------------------------------------------
	
	private String getSQLnuevoProceso()
	{
		StringBuffer call=new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_PROC_PROD PR_PROCESOS_PROD_TD_QT; ");
		call.append("   EO_DTO BLOB; ");
		call.append("   EO_COD_PROCESO NUMBER; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   PR_PROCESOS_PROD_TO_PG.PR_PROCESOS_PROD_I_PR(?,?,?,?,?,?); ");
		call.append(" END; ");
		return call.toString();
	}
	
	public RetornoDTO inscribeProceso(ParametroSerializableDTO parametro) throws ProductException
	{
		RetornoDTO retorno=new RetornoDTO();
		logger.debug("inscribeProceso():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLinscribeProceso();
		try {				
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt =  (OracleCallableStatement) conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("PR_PROCESOS_PROD_TD_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, parametro.toStruct_PR_PROCESOS_PROD_TD_QT());
			
			cstmt.setObject(1, oracleObject);					
			//cstmt.setBytes(2, parametro.getParametroObject()!=null?(byte[])SerializationUtils.serialize(parametro.getParametroObject()):null);
			cstmt.setBytes(2, parametro.getObjetoSerializado());
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
				logger.error(" Ocurrió un error en el registro de intarcel");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}			
			logger.debug("Recuperando data...");
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);			
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general en el registro de intarcel", e);
			throw new ProductException("Ocurrió un error general en el registro de intarcel",e);
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
		logger.debug("inscribeProceso():end");		
		return retorno;
	}
	
	public ParametroSerializableDTO nuevoProceso(ParametroSerializableDTO parametro) throws ProductException
	{		
		logger.debug("nuevoProceso():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = this.getSQLnuevoProceso();
		try {				
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt =  (OracleCallableStatement) conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("PR_PROCESOS_PROD_TD_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, parametro.toStruct_PR_PROCESOS_PROD_TD_QT());
			
			cstmt.setObject(1, oracleObject);					
			//cstmt.setBytes(2, parametro.getParametroObject()!=null?(byte[])SerializationUtils.serialize(parametro.getParametroObject()):null);
			cstmt.setBytes(2, parametro.getObjetoSerializado());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
		
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
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error("ERROR al crear un nuevo registro de proceso");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}			
			logger.debug("Recuperando data...");
			
			parametro.setIdProceso(cstmt.getString(3)!=null?cstmt.getString(3):"");			
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("ERROR al crear un nuevo registro de proceso", e);
			throw new ProductException("ERROR al crear un nuevo registro de proceso",e);
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
		logger.debug("nuevoProceso():end");		
		return parametro;
	}

}
