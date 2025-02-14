/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 05/06/2009     Sergio Munoz      					Versión Inicial
 */
package com.tmmas.cl.scl.parametrosgenerales.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.EstadoAsincDTO;

public class ParametrosAuditoriaDAO extends ConnectionDAO {

	private static Category cat = Category.getInstance(ParametrosAuditoriaDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
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
	 * TODO modificar Comentario, explicando la funcionalidad
	 * @param estadoAsinc
	 * @throws GeneralException
	 */
	public void grabaEstadoAsinc(EstadoAsincDTO estadoAsinc) throws GeneralException{
		cat.debug("Inicio:grabaEstadoAsinc()");
		int codError = 0;
		String resultado = null;
		String msgError = null;
		int numEvento = 0;
		int canparametros;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		
		if (estadoAsinc.getTipProceso() != null && estadoAsinc.getNumProceso() != null){
			canparametros = 10;
		}else{
			canparametros = 8;
		}
		
		try {
			String call = getSQL("GE_ESTADOS_PORTABILIDAD_PG","GE_GRABA_ESTADO_ASINC_PR",canparametros);
			
			 //IN_Num_cel      IN  NUMBER(15),
			//IV_COD_ESTADO   IN  VARCHAR2(2),
			//IV_OPERA_ORIGEN IN  VARCHAR2(5),
			//IV_OPERA_DEST   IN  VARCHAR2(5),
			//IV_SPN_PORT_ID  IN  VARCHAR2(512),
			//IN_NUM_PROCESO  IN  NUMBER(16),
			//IN_TIP_PROCESO  IN  NUMBER(3),
			//SN_cod_retorno  OUT NUMBER(6),
			//SV_mens_retorno OUT VARHAR2(3000),
			//SN_num_evento   OUT NUMBER(9));


			
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,estadoAsinc.getNumCel());
			cat.debug("estadoAsinc.getNumCel() ["+estadoAsinc.getNumCel()+"]");
			cstmt.setString(2,estadoAsinc.getCodEstado());
			cat.debug("estadoAsinc.getCodEstado() ["+estadoAsinc.getCodEstado()+"]");
			cstmt.setString(3,estadoAsinc.getOperaOrigen());
			cat.debug("estadoAsinc.getOperaOrigen() ["+estadoAsinc.getOperaOrigen()+"]");
			cstmt.setString(4,estadoAsinc.getOperaDestino());
			cat.debug("estadoAsinc.getOperaDestino() ["+estadoAsinc.getOperaDestino()+"]");
			cstmt.setString(5,estadoAsinc.getSpnPortId());
			cat.debug("estadoAsinc.getSpnPortId() ["+estadoAsinc.getSpnPortId()+"]");
			
			if (estadoAsinc.getTipProceso() != null && estadoAsinc.getNumProceso() != null){
			
				cstmt.setString(6,estadoAsinc.getNumProceso());
				cat.debug("estadoAsinc.getNumProceso() ["+estadoAsinc.getNumProceso()+"]");
				cstmt.setString(7,estadoAsinc.getTipProceso());			
				cat.debug("estadoAsinc.getTipProceso() ["+estadoAsinc.getTipProceso()+"]");
			
				cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);			
				cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);
			}else{
				cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);			
				cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);			
			}
			
			cat.debug("inicio:Execute");
			cstmt.execute();
			cat.debug("Fin:Execute");

			if (estadoAsinc.getTipProceso() != null && estadoAsinc.getNumProceso() != null){
				codError = cstmt.getInt(8);
				msgError = cstmt.getString(9);
				numEvento = cstmt.getInt(10);
			}else{
				codError = cstmt.getInt(6);
				msgError = cstmt.getString(7);
				numEvento = cstmt.getInt(8);
			}
			
			
			if (codError != 0) {
				cat.error("Ocurrió un error al grabar estado asinc");
				throw new GeneralException(
						"Ocurrió un error al grabar estado asinc", String
								.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}

		} catch (GeneralException e) {
			cat.error("Ocurrió un error al grabar estado asinc",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al grabar estado asinc",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:grabaEstadoAsinc()");
	}//fin grabaEstadoAsinc
	
	
	/*
	 * 
	 * GE_GRABA_ESTADO_PR(
                                IN_Num_cel      IN  ICC_MOVIMIENTO.NUM_CELULAR%TYPE,
                                IV_COD_ESTADO   IN  GV_COD_ESTADO,
                                IV_OPERA_ORIGEN IN  GV_OPERA_ORIGEN,
                                IV_OPERA_DEST   IN  GV_OPERA_DEST,
                                SN_cod_retorno  OUT GN_cod_retorno,
                                SV_mens_retorno OUT GV_mens_retorno,
                                SN_num_evento   OUT GN_num_evento)
                                
                               */
	
	
	
	public void grabaEstadoAsincSinSPNID(EstadoAsincDTO estadoAsinc) throws GeneralException{
		cat.debug("Inicio:grabaEstadoAsinc()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		
		try {
			String call = getSQL("GE_ESTADOS_PORTABILIDAD_PG","GE_GRABA_ESTADO_PR",7);
						
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,estadoAsinc.getNumCel());
			cat.debug("estadoAsinc.getNumCel() ["+estadoAsinc.getNumCel()+"]");
			cstmt.setString(2,estadoAsinc.getCodEstado());
			cat.debug("estadoAsinc.getCodEstado() ["+estadoAsinc.getCodEstado()+"]");
			cstmt.setString(3,estadoAsinc.getOperaOrigen());
			cat.debug("estadoAsinc.getOperaOrigen() ["+estadoAsinc.getOperaOrigen()+"]");
			cstmt.setString(4,estadoAsinc.getOperaDestino());
			cat.debug("estadoAsinc.getOperaDestino() ["+estadoAsinc.getOperaDestino()+"]");
						
		    cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);			
					
			cat.debug("inicio:Execute");
			cstmt.execute();
			cat.debug("Fin:Execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al grabar estado asinc");
				throw new GeneralException(
						"Ocurrió un error al grabar estado asinc", String
								.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}

		} catch (GeneralException e) {
			cat.error("Ocurrió un error al grabar estado asinc",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al grabar estado asinc",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:grabaEstadoAsinc()");
	}//fin grabaEstadoAsinc
	
	
}//fin CLASS ParametrosAuditoriaDAO