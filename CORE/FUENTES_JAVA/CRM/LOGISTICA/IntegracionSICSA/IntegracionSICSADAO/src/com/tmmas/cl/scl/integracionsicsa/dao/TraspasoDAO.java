package com.tmmas.cl.scl.integracionsicsa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import oracle.jdbc.driver.OracleTypes;

import com.tmmas.cl.scl.integracionsicsa.common.dto.LineaErrorDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieErrorDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.StockTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.EntradaTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;

public class TraspasoDAO  extends IntegracionSICSADAO {
	
	/**
     * Funcion que Obtiene la cantidad total de series del traspaso informado
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public String obtCantTotalTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("obtCantTotalTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        String resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_total_cantidad_traspaso_pr", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }              
            resultado = String.valueOf(cstmt.getInt(2));
            loggerDebug("Cantidad Total de Traspaso: "+resultado);            
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("obtCantTotalTraspaso: fin");
        return resultado;
    }
	
	/**
     * Funcion que elimina los datos de la tabla temporal
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void eliminaSeriesTraspasoTemporal(String numTraspaso, String codModulo)throws IntegracionSICSAException{
        loggerDebug("eliminaSeriesTraspasoTemporal: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_elimi_traspaso_temporal_pr", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+ numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            loggerDebug("codModulo: "+ codModulo);
            cstmt.setString(2, codModulo);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }              
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("eliminaSeriesTraspasoTemporal: fin");
    }	
	
	/**
     * Metodo que registra las series Informadas por CELISTIC
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */	
	public void registraSeriesTemporal(EntradaTraspasoDTO traspasoDTO, String codModulo, String codInvocador)throws IntegracionSICSAException, Exception{
		loggerDebug("registraSeriesTemporal(): Inicio");		
		Connection conn = null;
		CallableStatement cstmt = null;		
		String insertFinal = "";
		StringBuffer call = new StringBuffer();		
		try{	
			call.append(" DECLARE ");
			call.append(" PRAGMA AUTONOMOUS_TRANSACTION; ");
			call.append(" BEGIN ");
			//Empiezo a Recorrer todas las series informadas
			for (int i = 0; i < traspasoDTO.getSerieTraspasoDTOs().length; i++) {					
				call = generaInsert(call, traspasoDTO.getNumTraspaso(), traspasoDTO.getSerieTraspasoDTOs()[i].getLinTraspaso(), 
									traspasoDTO.getSerieTraspasoDTOs()[i].getNumSerie(), codModulo, codInvocador);
			}	
			call.append(" COMMIT; ");
			call.append(" END; ");			
			insertFinal = call.toString();
			loggerDebug("InsertFinal");
			loggerDebug(insertFinal);	
			conn = obtenerConexion();
			cstmt = conn.prepareCall(insertFinal);
			loggerDebug("Execute Antes");
            cstmt.execute();
            
            loggerDebug("Execute Despues");			
		}catch (IntegracionSICSAException e){
			loggerDebug("IntegracionSICSAException");
			throw e;
		}catch(Exception e){
			if (!(e instanceof IntegracionSICSAException)){
                loggerError("ERROR Exception:");
                loggerError(e);
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }			
		}finally{
			loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
		}
		loggerDebug("registraSeriesTemporal(): Fin");
	}
	
	/**
	 * Genera Bloque Anonimo con los inserts 
	 * @author Jorge González
	 * */	
	private StringBuffer generaInsert(StringBuffer cadena, String numTraspaso, String linTraspaso, String numSerie, String codModulo, String codInvocador) throws Exception{
		try{
			cadena.append("INSERT INTO AL_SERIES_TEMP_TO (COD_MODULO, PROC_INVOCADOR, NUM_TRASPASO, LIN_TRASPASO, NUM_SERIE) " +
						  "VALUES ('"+ codModulo +"', '"+ codInvocador +"','"+ numTraspaso +"','"+ linTraspaso +"','"+ numSerie +"' );");			
		}catch(Exception e){
			loggerDebug("Excepcion al Generar Insert de la Tabla Temporal");
			throw new IntegracionSICSAException("ERR.0021", 0);
		}	
		return cadena;
	}
	
	/**
     * Funcion que Actualiza la Tabla AL_CAB_PETICION 
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void updEstadoPeticion(String codEstado, String numPeticion)throws IntegracionSICSAException{
        loggerDebug("updEstadoPeticion: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_actualiza_peticion_pr", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("codEstado: "+codEstado);
            cstmt.setString(1, codEstado);
            loggerDebug("numPeticion: "+numPeticion);
            cstmt.setLong(2, Long.parseLong(numPeticion));            
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("updEstadoPeticion: fin");
    }
	
	/**
     * Funcion que Obtiene el tipMovimiento del proceso ingresado
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public String obtTipoMovimiento(String codProceso)throws IntegracionSICSAException{
        loggerDebug("obtTipoMovimiento: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        String resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_tip_movimiento_pr", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("codProceso: "+codProceso);
            cstmt.setString(1, codProceso);
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }              
            resultado = String.valueOf(cstmt.getInt(2));
            loggerDebug("Tipo Movimiento: "+ resultado);
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("obtTipoMovimiento: fin");
        return resultado;
    }
	
	/**
     * Funcion que actualiza la tabla AL_TRASPASOS
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void updateTraspaso(String codEstado, String tipMovEnv, String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("updateTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_actualiza_traspaso_pr", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("codEstado: "+codEstado);
            cstmt.setString(1, codEstado);
            loggerDebug("tipMovEnv: "+tipMovEnv);
            cstmt.setLong(2, Long.parseLong(tipMovEnv));
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(3, Long.parseLong(numTraspaso));
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(4);
            msgError = cstmt.getString(5);
            numEvento = cstmt.getInt(6);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("updateTraspaso: fin");
    }
	
	/**
     * Funcion que Obtiene la codega origen del traspaso
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public String obtBodegaOrigenTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("obtBodegaOrigenTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        String resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_bodega_ori_traspaso_pr", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }              
            resultado = String.valueOf(cstmt.getInt(2));
            loggerDebug("Bodega Origen Traspaso: "+ resultado);
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("obtBodegaOrigenTraspaso: fin");
        return resultado;
    }
	
	/**
     * Funcion que actualiza el codigo de estado del traspaso en la 
     * tabla AL_TRASPASOS
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void updateEstadoTraspaso(String codEstado, String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("updateEstadoTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_upd_estad_traspaso_pr", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("codEstado: "+codEstado);
            cstmt.setString(1, codEstado);
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(2, Long.parseLong(numTraspaso));
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("updateEstadoTraspaso: fin");
    }
	
	/**
     * Funcion que Obtiene el codigo de la operadora 
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public String obtieneOperadora()throws IntegracionSICSAException{
        loggerDebug("obtieneOperadora: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        String resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_obt_operadora_pr", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(2);
            msgError = cstmt.getString(3);
            numEvento = cstmt.getInt(4);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }else{
            	resultado = cstmt.getString(1);
            	loggerDebug("Operadora: "+ resultado);
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("obtieneOperadora: fin");
        return resultado;
    }
	
	/**
     * Funcion que Obtiene numero de guia de remision 
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void updGuiaTraspaso(String codBodega, String codOperadora, String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("updGuiaTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        int numConsume;
        try {
            conn = obtenerConexion();
            String call = getSQL("al_folios_pg", "AL_OBTFOLIO_GUIA_PR", 7);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("codBodega: "+codBodega);
            cstmt.setLong(1, Long.parseLong(codBodega));
            loggerDebug("codOperadora: "+codOperadora);
            cstmt.setString(2, codOperadora);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(7, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(5);
            msgError = cstmt.getString(6);
            numEvento = cstmt.getInt(7);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }else{
            	numConsume = cstmt.getInt(3);
            	loggerDebug("numConsume: "+ numConsume);
            	if(numConsume == 0){
            		loggerDebug("numConsume es 0 ");
            		loggerDebug("updateGuiaTraspaso("+numTraspaso+","+numTraspaso+")");
            		updateGuiaTraspaso(numTraspaso, numTraspaso);             		
            	}else{
            		loggerDebug("numConsume es distinto de 0 ");
            		loggerDebug("updateGuiaTraspaso("+cstmt.getString(4)+","+numTraspaso+")");
            		updateGuiaTraspaso(cstmt.getString(4), numTraspaso);
            	}
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("updGuiaTraspaso: fin");
    }
	
	/**
     * Funcion que actualiza el num_guia de la tabla AL_TRASPASOS
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void updateGuiaTraspaso(String numGuia, String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("updateGuiaTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_upd_guia_traspaso_pr", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numGuia: "+numGuia);
            cstmt.setString(1, numGuia);
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(2, Long.parseLong(numTraspaso));
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("updateGuiaTraspaso: fin");
    }
	
	/**
     * Funcion que valida las series insertadas en la tabla temporal AL_SERIES_TEMP_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void validaSeriesTempTraspaso(String numTraspaso, String codEstado, String tipStock)throws IntegracionSICSAException{
        loggerDebug("validaSeriesTempTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_seleccion_masiva_pr", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            loggerDebug("codEstado: "+codEstado);
            cstmt.setLong(2, Long.parseLong(codEstado));
            loggerDebug("tipStock: "+tipStock);
            cstmt.setLong(3, Long.parseLong(tipStock));
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(4);
            msgError = cstmt.getString(5);
            numEvento = cstmt.getInt(6);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }              
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("validaSeriesTempTraspaso: fin");
    }	
	
	/**
     * Funcion que consulta las series con error de la tabla AL_SERIES_TEMP_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public boolean consultaErrorSerieTemp(String numTraspaso, String codInvocador, String codModulo)throws IntegracionSICSAException{
        loggerDebug("consultaErrorSerieTemp: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        boolean resultado = false;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_cons_series_error_pr", 7);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            loggerDebug("codInvocador: "+codInvocador);
            cstmt.setString(2, codInvocador);
            loggerDebug("codModulo: "+codModulo);
            cstmt.setString(3, codModulo);
            cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(7, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(5);
            msgError = cstmt.getString(6);
            numEvento = cstmt.getInt(7);
            
            loggerDebug("Codigo de Error: " + codError);
        	loggerDebug("Mensaje de Error: " + msgError);
        	loggerDebug("Numero de Evento: " +numEvento);  
            
            if(codError != 0){
        		loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }else{
            	loggerDebug("Cantidad de Series con error: "+ cstmt.getLong(4));
            	if(cstmt.getLong(4)> 0){
            		resultado = true;            		
            	}else{
            		resultado = false;
            	}
            }                 
            loggerDebug("Resultado : " + resultado);
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("updateGuiaTraspaso: fin");
        return resultado;
    }
	
	/**
     * Funcion que obtiene lista de errores de las series que se encuentran en la tabla AL_SERIES_TEMP_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public SerieErrorDTO[] obtieneErrorSerieTemp(String numTraspaso, String codInvocador, String codModulo)throws IntegracionSICSAException{
        loggerDebug("obtieneErrorSerieTemp: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        SerieErrorDTO[] resultado = null;
        ResultSet rs = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_obt_series_error_pr", 7);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            loggerDebug("codInvocador: "+codInvocador);
            cstmt.setString(2, codInvocador);
            loggerDebug("codModulo: "+codModulo);
            cstmt.setString(3, codModulo);
            cstmt.registerOutParameter(4, OracleTypes.CURSOR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(7, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(5);
            msgError = cstmt.getString(6);
            numEvento = cstmt.getInt(7);
            
            if(codError != 0){
        		loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }else{
            	loggerDebug("Recuperando Datos Lineas");
            	ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(4);
				while(rs.next()){
					SerieErrorDTO serieErrorDTO = new SerieErrorDTO();
					serieErrorDTO.setNumSerie(rs.getString(1));
					serieErrorDTO.setDesErrorSerie(rs.getString(2));
					lista.add(serieErrorDTO);
				}            	
				resultado = (SerieErrorDTO[]) copiaArregloTipoEspecifico(lista.toArray(), SerieErrorDTO.class);
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("obtieneErrorSerieTemp: fin");
        return resultado;
    }	
	
	/**
     * Funcion que Obtiene los stock del traspaso por linea
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public StockTraspasoDTO[] obtStockTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("obtStockTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        StockTraspasoDTO[] resultado = null;
        ResultSet rs = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_obt_stock_traspaso_pr", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            cstmt.registerOutParameter(2, OracleTypes.CURSOR);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }else{
            	loggerDebug("Recuperando Datos");
            	ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while(rs.next()){
					StockTraspasoDTO stockTraspasoDTO = new StockTraspasoDTO();
					stockTraspasoDTO.setTipStock(String.valueOf(rs.getLong(1)));
					stockTraspasoDTO.setCodArticulo(String.valueOf(rs.getLong(2)));
					stockTraspasoDTO.setCodUso(String.valueOf(rs.getLong(3)));
					stockTraspasoDTO.setCodEstado(String.valueOf(rs.getLong(4)));
					stockTraspasoDTO.setCantTraspaso(String.valueOf(rs.getLong(5)));
					stockTraspasoDTO.setFecEntrada(rs.getString(6));
					stockTraspasoDTO.setNumGuia(rs.getString(7));
					stockTraspasoDTO.setIndSeriado(String.valueOf(rs.getLong(8)));
					lista.add(stockTraspasoDTO);
				}            	
				resultado = (StockTraspasoDTO[]) copiaArregloTipoEspecifico(lista.toArray(), StockTraspasoDTO.class);
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("obtStockTraspaso: fin");
        return resultado;
    }	
	
	/**
     * Funcion que Obtiene cantidad de Stock 
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public long obtCantidadStock(String codBodega, String codArticulo, String indDisponi, String codUso, String codEstado)throws IntegracionSICSAException{
        loggerDebug("obtCantidadStock: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        long resultado = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_obt_cant_stock_pr", 9);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("codArticulo: "+codArticulo);
            cstmt.setLong(1, Long.parseLong(codArticulo));
            loggerDebug("codBodega: "+codBodega);
            cstmt.setLong(2, Long.parseLong(codBodega));
            loggerDebug("indDisponi: "+indDisponi);
            cstmt.setLong(3, Long.parseLong(indDisponi));
            loggerDebug("codEstado: "+codEstado);
            cstmt.setString(4, codEstado);
            loggerDebug("codUso: "+codUso);
            cstmt.setLong(5, Long.parseLong(codUso));
            cstmt.registerOutParameter(6, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(7, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(9, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(7);
            msgError = cstmt.getString(8);
            numEvento = cstmt.getInt(9);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }else{
            	resultado = cstmt.getLong(6);
            	loggerDebug("Cantidad de Stock: "+resultado);
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("obtCantidadStock: fin");
        return resultado;
    }
	
	/**
     * Funcion que valida estado del Numero de traspaso
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void validaEstadoTraspaso(String numTraspaso, String codEstado)throws IntegracionSICSAException{
        loggerDebug("validaEstadoTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_valida_traspaso_pr", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            loggerDebug("codEstado: "+codEstado);
            cstmt.setString(2, codEstado);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
            
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
        		loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }             
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("validaSeriesTempTraspaso: fin");
    }	
	
	/**
     * Funcion que Obtiene el número de petición del traspaso 
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public long obtNumPeticionTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("obtNumPeticionTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        long resultado = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_obtiene_peticion_pr", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }else{
            	resultado = cstmt.getLong(2);
            	loggerDebug("Numero de Peticion: "+ resultado);
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("obtNumPeticionTraspaso: fin");
        return resultado;
    }
	
	/**
     * Funcion que Obtiene parametro de la tabla GED_PARAMETROS 
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public String obtParametro(String nomParametro, String codModulo)throws IntegracionSICSAException{
        loggerDebug("obtParametro: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        String resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_obt_parametro_pr", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("nomParametro: "+nomParametro);
            cstmt.setString(1, nomParametro);
            loggerDebug("codModulo: "+codModulo);
            cstmt.setString(2, codModulo);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(4);
            msgError = cstmt.getString(5);
            numEvento = cstmt.getInt(6);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }else{
            	resultado = cstmt.getString(3);
            	loggerDebug("Valor Parametro: "+ resultado);
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("obtParametro: fin");
        return resultado;
    }
	
	/**
     * Funcion que Valida Si las series ya no existen o han sido modificadas
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public boolean validaTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("validaTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        boolean resultado = false;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_valida_autoriza_pr", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(2);
            msgError = cstmt.getString(3);
            numEvento = cstmt.getInt(4);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }
            resultado = true;
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("validaTraspaso: fin");
        return resultado;
    }
	
	/**
     * Funcion que Inserta en la tabla AL_ESTADO_TRASPASO_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void insertaEstadoTraspaso(String numTraspaso, String estadoTraspaso)throws IntegracionSICSAException{
        loggerDebug("insertaEstadoTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_ins_esta_traspaso_pr", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            loggerDebug("estadoTraspaso: "+estadoTraspaso);
            cstmt.setString(2, estadoTraspaso);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
            
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
        		loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }             
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("insertaEstadoTraspaso: fin");
    }	
	
	/**
     * Funcion que Actualiza en la tabla AL_ESTADO_TRASPASO_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void actualizaEstadoTraspaso(String numTraspaso, String estadoTraspaso, String mensError)throws IntegracionSICSAException{
        loggerDebug("actualizaEstadoTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_upd_esta_traspaso_pr", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            loggerDebug("estadoTraspaso: "+estadoTraspaso);
            cstmt.setString(2, estadoTraspaso);
            loggerDebug("mensError: "+mensError);
            cstmt.setString(3, mensError);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.INTEGER);
            
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(4);
            msgError = cstmt.getString(5);
            numEvento = cstmt.getInt(6);
            
            if(codError != 0){
        		loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }             
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("actualizaEstadoTraspaso: fin");
    }
	
	/**
     * Funcion que consulta estado del traspaso en la tabla AL_ESTADO_TRASPASO_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public SalidaConsultaTraspasoDTO consultaEstadoTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("consultaEstadoTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        SalidaConsultaTraspasoDTO estadoTraspaso = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_cons_esta_traspaso_pr", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.INTEGER);
            
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(4);
            msgError = cstmt.getString(5);
            numEvento = cstmt.getInt(6);
            
            if(codError != 0){
            	if(codError == -1){
            		estadoTraspaso = new SalidaConsultaTraspasoDTO();
                	estadoTraspaso.setEstadoTraspaso(cstmt.getString(2));
                	estadoTraspaso.setMesajeError(cstmt.getString(3));
                	GlobalProperties global2 = GlobalProperties.getInstance();
                	String codInvocador = global2.getValor("AL.Invocador");
            		String codModulo = global2.getValor("AL.codModulo");
                	estadoTraspaso.setSeriesError(obtieneErrorSerieTemp(numTraspaso, codInvocador, codModulo));            		
            	}else{
	        		loggerDebug("Codigo de Error: " + codError);
	            	loggerDebug("Mensaje de Error: " + msgError);
	            	loggerDebug("Numero de Evento: " +numEvento);            	
	            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            	}
            }else{
            	estadoTraspaso = new SalidaConsultaTraspasoDTO();
            	estadoTraspaso.setEstadoTraspaso(cstmt.getString(2));
            	estadoTraspaso.setMesajeError(cstmt.getString(3));
            }             
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("consultaEstadoTraspaso: fin");
        return estadoTraspaso;
    }	
	
	/**
     * Funcion que obtiene lista de errores de las lineas que se encuentran en la tabla AL_SERIES_TEMP_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public LineaErrorDTO[] obtieneErrorLineaTemp(String numTraspaso, String codInvocador, String codModulo)throws IntegracionSICSAException{
        loggerDebug("obtieneErrorLineaTemp: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        LineaErrorDTO[] resultado = null;
        ResultSet rs = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_obt_lineas_error_pr", 7);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            loggerDebug("codInvocador: "+codInvocador);
            cstmt.setString(2, codInvocador);
            loggerDebug("codModulo: "+codModulo);
            cstmt.setString(3, codModulo);
            cstmt.registerOutParameter(4, OracleTypes.CURSOR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(7, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(5);
            msgError = cstmt.getString(6);
            numEvento = cstmt.getInt(7);
            
            if(codError != 0){
        		loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }else{
            	loggerDebug("Recuperando Datos Lineas");
            	ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(4);
				while(rs.next()){
					LineaErrorDTO serieErrorDTO = new LineaErrorDTO();
					serieErrorDTO.setCodArticulo(rs.getString(1));
					serieErrorDTO.setDesErrorLinea(rs.getString(2));
					serieErrorDTO.setCantidadIngresada(rs.getString(3));
					lista.add(serieErrorDTO);
				}            	
				resultado = (LineaErrorDTO[]) copiaArregloTipoEspecifico(lista.toArray(), LineaErrorDTO.class);
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("obtieneErrorLineaTemp: fin");
        return resultado;
    }	
	
	/**
     * Funcion que obtiene cantidad traspaso de los articulos
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public LineaErrorDTO[] obtieneCantidadTraspasoArticulo(String numTraspaso, LineaErrorDTO[] lineaErrorDTOs)throws IntegracionSICSAException{
        loggerDebug("obtieneCantidadTraspasoArticulo: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_obt_cant_traspaso_pr", 6);
            cstmt = conn.prepareCall(call);
            
            for(int i=0; i < lineaErrorDTOs.length;i++){
            	loggerDebug("SQL[" + call + "]");
                // PARAMETROS DE ENTRADA
                loggerDebug("numTraspaso: "+numTraspaso);
                cstmt.setLong(1, Long.parseLong(numTraspaso));
                loggerDebug("codArticulo: "+lineaErrorDTOs[i].getCodArticulo());
                cstmt.setLong(2, Long.parseLong(lineaErrorDTOs[i].getCodArticulo()));
                cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
                cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
                cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
                cstmt.registerOutParameter(6, java.sql.Types.INTEGER);

                loggerDebug("Execute Antes");
                cstmt.execute();
                loggerDebug("Execute Despues");
                
                codError = cstmt.getInt(4);
                msgError = cstmt.getString(5);
                numEvento = cstmt.getInt(6);
                
                if(codError != 0){
            		loggerDebug("Codigo de Error: " + codError);
                	loggerDebug("Mensaje de Error: " + msgError);
                	loggerDebug("Numero de Evento: " +numEvento);            	
                	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
                }else{
                	lineaErrorDTOs[i].setCantidadEsperada(String.valueOf(cstmt.getLong(3)));                	
                }            	
            }                        
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("obtieneCantidadTraspasoArticulo: fin");
        return lineaErrorDTOs;
    }
	
	/**
     * Funcion que elimina las series insertadas en la tabla temporal AL_SER_TRASPASO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void elimiSerTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("elimiSerTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_elimi_ser_tras_pr", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(2);
            msgError = cstmt.getString(3);
            numEvento = cstmt.getInt(4);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }              
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("elimiSerTraspaso: fin");
    }	
	
	/**
     * Funcion que elimina las lineas insertadas en la tabla temporal AL_LIN_TRASPASO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void elimiLineaTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("elimiLineaTraspaso: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_WS_PG", "al_elimi_lin_tras_pr", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspaso: "+numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            codError = cstmt.getInt(2);
            msgError = cstmt.getString(3);
            numEvento = cstmt.getInt(4);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }              
        } catch (Exception e) {
            if (!(e instanceof IntegracionSICSAException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionSICSAException("ERR.0000", 0);
            } else {
                throw (IntegracionSICSAException) e;
            }
        } finally {
            loggerDebug("Cerrando conexiones...");
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                loggerError("ERROR: ");
                loggerError("SQLException[" + e + "]");
            }
        }
        loggerDebug("elimiLineaTraspaso: fin");
    }
}
