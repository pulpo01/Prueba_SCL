package com.tmmas.cl.scl.integracionsicsa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import oracle.jdbc.driver.OracleTypes;

import com.tmmas.cl.scl.integracionsicsa.common.dto.ConsultaPedidoUsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.DatosFolioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.DatosPedidoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.DetallePedidoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.PedidoLineaDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieErrorDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.VentaEncabezadoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.PedidoInDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaPedidoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaIntegracionSICSADTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;

public class PedidoDAO extends IntegracionSICSADAO {
	
	/**
     * Metodo que Valida Estado del Pedido
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public SalidaIntegracionSICSADTO validaEstadoPedido(String codPedido, String estadoPedido)throws IntegracionSICSAException{
        loggerDebug("validaEstadoPedido: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        SalidaIntegracionSICSADTO resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_ESTADO_PEDIDO_PR", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.setLong(2, Long.parseLong(estadoPedido));
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }
            
            resultado = new SalidaIntegracionSICSADTO(); 
            resultado.setIEvento(numEvento);
            resultado.setStrCodError(String.valueOf(codError));
            resultado.setStrDesError(msgError);
            
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
        loggerDebug("validaEstadoPedido: fin");
        return resultado;
    }
	
	/**
     * Metodo que Obtiene cantidad total del pedido
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public int obtieneCantTotalPedido(String codPedido)throws IntegracionSICSAException{
        loggerDebug("obtieneCantTotalPedido: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        int resultado = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_CANTIDAD_PEDIDO_PR", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }
            resultado = cstmt.getInt(2); 
            
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
        loggerDebug("obtieneCantTotalPedido: fin");
        return resultado;
    }
	
	/**
     * Metodo que Obtiene cantidad total de las lineas del pedido
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public PedidoLineaDTO[] obtieneCantTotalPedidoXLinea(String codPedido)throws IntegracionSICSAException{
        loggerDebug("obtieneCantTotalPedidoXLinea: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        PedidoLineaDTO[] resultado = null;
        ResultSet rs = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_CANTIDAD_PEDIDO_X_LINEA_PR", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.registerOutParameter(2, OracleTypes.CURSOR);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }else{
            	loggerDebug("Recuperando Datos Lineas");
            	ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while(rs.next()){
					PedidoLineaDTO pedidoLineaDTO = new PedidoLineaDTO();
					pedidoLineaDTO.setLinPedido(rs.getInt(1));
					pedidoLineaDTO.setCodArticulo(rs.getLong(2));
					pedidoLineaDTO.setCanDetallePedido(rs.getLong(3));
					lista.add(pedidoLineaDTO);
				}            	
				resultado = (PedidoLineaDTO[]) copiaArregloTipoEspecifico(lista.toArray(), PedidoLineaDTO.class);
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
        loggerDebug("obtieneCantTotalPedidoXLinea: fin");
        return resultado;
    }
	
	/**
     * Metodo que Valida que el pedido exista en la tabla NP_VALIDACION_SERIES_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public SalidaIntegracionSICSADTO validaExistenciaPedido(String codPedido)throws IntegracionSICSAException{
        loggerDebug("validaExistenciaPedido: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        SalidaIntegracionSICSADTO resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_EXISTE_PEDIDO_PR", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(2);
            msgError = cstmt.getString(3);
            numEvento = cstmt.getInt(4);
            
            if(codError != 0){
            	if(codError != 1){ // Error al validar pedido
	            	loggerDebug("Codigo de Error: " + codError);
	            	loggerDebug("Mensaje de Error: " + msgError);
	            	loggerDebug("Numero de Evento: " +numEvento);            	
	            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            	}	
            }

            resultado = new SalidaIntegracionSICSADTO(); 
            resultado.setIEvento(numEvento);
            resultado.setStrCodError(String.valueOf(codError));
            resultado.setStrDesError(msgError);
            
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
        loggerDebug("validaEstadoPedido: fin");
        return resultado;
    }
	
	/**
     * Metodo que Valida si existe alguna serie con error del pedido en la tabla NP_VALIDACION_SERIES_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public SalidaIntegracionSICSADTO validaSeriePedido(String codPedido)throws IntegracionSICSAException{
        loggerDebug("validaSeriePedido: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        SalidaIntegracionSICSADTO resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_VAL_SERIE_PEDIDO_PR", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(2);
            msgError = cstmt.getString(3);
            numEvento = cstmt.getInt(4);
            
            if(codError != 0){
            	if(codError != 1){ // Error al validar pedido
	            	loggerDebug("Codigo de Error: " + codError);
	            	loggerDebug("Mensaje de Error: " + msgError);
	            	loggerDebug("Numero de Evento: " +numEvento);            	
	            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            	}	
            }

            resultado = new SalidaIntegracionSICSADTO(); 
            resultado.setIEvento(numEvento);
            resultado.setStrCodError(String.valueOf(codError));
            resultado.setStrDesError(msgError);
            
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
        loggerDebug("validaSeriePedido: fin");
        return resultado;
    }
	
	/**
     * Metodo que Elimina las series del pedido que existan en la tabla NP_VALIDACION_SERIES_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public SalidaIntegracionSICSADTO borrarSeriePedido(String codPedido)throws IntegracionSICSAException{
        loggerDebug("borrarSeriePedido: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        SalidaIntegracionSICSADTO resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_ELIMINA_PEDIDO_PR", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(2);
            msgError = cstmt.getString(3);
            numEvento = cstmt.getInt(4);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }

            resultado = new SalidaIntegracionSICSADTO(); 
            resultado.setIEvento(numEvento);
            resultado.setStrCodError(String.valueOf(codError));
            resultado.setStrDesError(msgError);
            
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
        loggerDebug("borrarSeriePedido: fin");
        return resultado;
    }
	
	/**
     * Metodo que registra las series Informadas por CELISTIC
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	
	public SalidaIntegracionSICSADTO registraSeries(PedidoInDTO pedidoInDTO)throws IntegracionSICSAException, Exception{
		loggerDebug("registraSeries(): Inicio");		
		Connection conn = null;
		CallableStatement cstmt = null;		
		SerieDTO seriePedidoDTO = null;
		SalidaIntegracionSICSADTO respuesta = null;
		String insertFinal = "";
		StringBuffer call = new StringBuffer();		
		try{	
			call.append(" BEGIN ");
			//Empiezo a Recorrer todas las series informadas
			for (int i = 0; i < pedidoInDTO.getSeriePedidoDTOs().length; i++) {
				seriePedidoDTO = pedidoInDTO.getSeriePedidoDTOs()[i];					
				call = generaInsert(call, pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido(), 
	                    seriePedidoDTO.getLinPedido(), seriePedidoDTO.getNumSerie());
			}	
			
			call.append("END;");			
			insertFinal = call.toString();
			loggerDebug("InsertFinal");
			loggerDebug(insertFinal);	
			conn = obtenerConexion();
			cstmt = conn.prepareCall(insertFinal);
			loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            
            respuesta = new SalidaIntegracionSICSADTO();												
			respuesta.setStrCodError("0");
			respuesta.setStrDesError("OK");
			respuesta.setIEvento(-1);
			
		}catch (IntegracionSICSAException e) {
			loggerDebug("IntegracionSICSAException");
			throw e;
		}catch(Exception e){
			loggerDebug("Exception");
			throw e;			
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
		loggerDebug("registraSeries(): Fin");
		return respuesta;
	}
	
	/**
     * Metodo que Valida las series insertadas atravez del procedimiento NP_VALIDASERIES_PR
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void validaSeriesInsertadas(String codPedido)throws IntegracionSICSAException, Exception{
        loggerDebug("validaSeriesInsertadas: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        String msgError = null;
        try {
            conn = obtenerConexion();
            //String call = getProcedure("NP_VALIDASERIES_WS_PR", 1);
            String call = getSQL("NP_TRANSACCIONES_WS_PG", "NP_VALIDASERIES_PR", 2);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            //Parametros de Salida
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            msgError = cstmt.getString(2);
            
            loggerDebug("msgError: " + msgError);
            
            if(msgError != null && !msgError.trim().equals("")){
            	loggerDebug("Mensaje de Error: " + msgError);         	
            	throw new IntegracionSICSAException(msgError);
            }            
            
        } catch (Exception e) {
        		loggerDebug("Exception");
                throw e;
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
        loggerDebug("validaSeriesInsertadas: fin");
    }
	
	/**
	 * Genera Bloque Anonimo con los inserts 
	 * @author Jorge González
	 * */	
	private StringBuffer generaInsert(StringBuffer cadena, String codPedido, String linPedido, String numSerie){
		String codBarraDefault = "INSERTWS";
		cadena.append("INSERT INTO NP_VALIDACION_SERIES_TO (COD_PEDIDO, LIN_DET_PEDIDO, NUM_SERIE, COD_BARRA_SERIE) " +
					  "VALUES ('"+ codPedido +"', '"+ linPedido +"','"+ numSerie +"','"+ codBarraDefault +"');");			
		return cadena;
	}
	
	/**
     * Metodo que obtiene datos de la tabla NPT_PEDIDO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public DatosPedidoDTO obtieneDatosPedido(String codPedido)throws IntegracionSICSAException{
        loggerDebug("obtieneDatosPedido: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        DatosPedidoDTO resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_DATOS_PEDIDO_PR", 7);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(7, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(5);
            msgError = cstmt.getString(6);
            numEvento = cstmt.getInt(7);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }

            resultado = new DatosPedidoDTO(); 
            resultado.setCodPedido(codPedido);
            resultado.setCodUsuarioCre(cstmt.getString(2));
            resultado.setCodUsuarioIng(cstmt.getString(3));
            resultado.setFecSysdate(cstmt.getString(4));
            
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
        loggerDebug("obtieneDatosPedido: fin");
        return resultado;
    }
	
	/**
     * Metodo que inserta estado del pedido en la tabla NPT_ESTADO_PEDIDO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void insertaEstadoPedido(DatosPedidoDTO datosPedidoDTO)throws Exception{
        loggerDebug("insertaEstadoPedido: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        try {
            conn = obtenerConexion();
            String call = getProcedure("P_INSERT_ESTADO_PEDIDO", 10);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(datosPedidoDTO.getCodPedido()));
            loggerDebug("CodPedido: "+ datosPedidoDTO.getCodPedido());
            cstmt.registerOutParameter(2, java.sql.Types.FLOAT);
            cstmt.setLong(3, Long.parseLong(datosPedidoDTO.getCodUsuarioCre()));
            loggerDebug("CodUsuarioCre: "+ datosPedidoDTO.getCodPedido());
            cstmt.setLong(4, Long.parseLong(datosPedidoDTO.getCodUsuarioIng()));
            loggerDebug("CodUsuarioIng: "+ datosPedidoDTO.getCodUsuarioIng());
            cstmt.setString(5, null);
            cstmt.setString(6, null);
            cstmt.setLong(7, Long.parseLong(datosPedidoDTO.getCodEstadoFlujo()));
            loggerDebug("CodEstadoPedido: 9");
            cstmt.setString(8, datosPedidoDTO.getFecSysdate());
            loggerDebug("FecSysdate: "+ datosPedidoDTO.getFecSysdate());
            cstmt.setString(9, null);
            cstmt.setString(10, null);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
        } catch (Exception e) {
        		loggerDebug("Exception: "+ e);
                throw e;
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
        loggerDebug("insertaEstadoPedido: fin");
    }
	
	/**
     * Metodo que valida si existe pedido en la tabla NP_CONTROL_ING_SERIES_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public boolean validaPedidoControl(String codPedido)throws IntegracionSICSAException{
        loggerDebug("validaPedidoControl: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        boolean resultado = false;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_PEDIDO_CONTROL_PR", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }
            
            if(cstmt.getInt(2) != 0){
            	resultado = true;
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
        loggerDebug("validaPedidoControl: fin");
        return resultado;
    }
	
	/**
     * Metodo que valida si pedido esta dado de baja
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public boolean validaBajaPedido(String codPedido)throws IntegracionSICSAException{
        loggerDebug("validaBajaPedido: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        boolean resultado = false;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_PEDIDO_BAJA_PR", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }
            
            if(cstmt.getInt(2) != 0){
            	resultado = true;
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
        loggerDebug("validaBajaPedido: fin");
        return resultado;
    }
	
	/**
     * Metodo que inserta en la tabla NP_CONTROL_ING_SERIES_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void insertaControlPedido(String codPedido, String userWeb, int cantSeries)throws IntegracionSICSAException{
        loggerDebug("insertaControlPedido: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_INSERT_CONTROL_SERIE_PR", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.setString(2, userWeb);
            cstmt.setInt(3, cantSeries);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
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
        loggerDebug("insertaControlPedido: fin");
    }
	
	/**
     * Metodo que obtiene parametro de la tabla NPT_PARAMETRO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public String obtieneParametroNPW(String aliasParametro)throws IntegracionSICSAException{
        loggerDebug("obtieneParametroNPW: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        String resultado =  null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_PARAMETRO_NPW_PR", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setString(1, aliasParametro);
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }   
            
            resultado = cstmt.getString(2);
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
        loggerDebug("obtieneParametroNPW: fin");
        return resultado;
    }
	
	/**
     * Metodo que obtiene estado de escritura de la tabla npt_fun_estado_flujo_esc
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public String obtieneEstadoEscNPW(String codFuncion)throws IntegracionSICSAException{
        loggerDebug("obtieneEstadoEscNPW: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        String resultado =  null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_ESTADO_FLUJO_ESC_PR", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codFuncion));
            loggerDebug("codFuncion: "+codFuncion);
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }   
            
            resultado = cstmt.getString(2);
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
        loggerDebug("obtieneEstadoEscNPW: fin");
        return resultado;
    }
	
	/**
     * Metodo que Valida pedido en las tablas npt_detalle_pedido y np_validacion_series_to
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public boolean valDetalleValidaSeries(String codPedido)throws IntegracionSICSAException{
        loggerDebug("valDetalleValidaSeries: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        boolean resultado = false;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_VAL_DETA_VALIDA_SERIE_PR", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(2);
            msgError = cstmt.getString(3);
            numEvento = cstmt.getInt(4);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);
            	resultado = false;
            }else{
            	resultado = true;
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
        loggerDebug("obtieneEstadoEscNPW: fin");
        return resultado;
    }
	
	/**
     * Metodo que valida si pedido existe en la tabla npt_serie_pedido
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public boolean validaSeriePedidoNPW(String codPedido)throws IntegracionSICSAException{
        loggerDebug("validaSeriePedidoNPW: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        boolean resultado = false;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_VAL_SERIE_PEDIDO_PR", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }
            
            if(cstmt.getInt(2) != 0){
            	resultado = true;
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
        loggerDebug("validaSeriePedidoNPW: fin");
        return resultado;
    }
	
	/**
     * Metodo que valida el estado del Pedido en la tabla np_control_ing_series_to 
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public boolean validaEstadoControl(String codPedido, String estadoProceso)throws IntegracionSICSAException{
        loggerDebug("validaEstadoControl: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        boolean resultado = false;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_VAL_ESTADO_CONTROL_PR", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.setString(2, estadoProceso);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(4);
            msgError = cstmt.getString(5);
            numEvento = cstmt.getInt(6);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }
            
            if(cstmt.getInt(3) != 0){
            	resultado = true;
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
        loggerDebug("validaEstadoControl: fin");
        return resultado;
    }
	
	/**
     * Metodo que actualiza el estado del pedido en la tabla NP_CONTROL_ING_SERIES_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void actualizaControlSeries(String codPedido, String estadoProcesoActual, String estadoProcesoNuevo)throws IntegracionSICSAException{
        loggerDebug("actualizaControlSeries: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_UPD_ESTADO_CONTROL_PR", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            loggerDebug("CodPedido: " + codPedido);
            cstmt.setString(2, estadoProcesoActual);
            loggerDebug("estadoProcesoActual: " + estadoProcesoActual);
            cstmt.setString(3, estadoProcesoNuevo);
            loggerDebug("estadoProcesoNuevo: " + estadoProcesoNuevo);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
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
        loggerDebug("actualizaControlSeries: fin");
    }
	
	/**
     * Metodo que inserta las series en la tabla NPT_SERIE_PEDIDO por medio del codPedido
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void insertPedidoSerie(String codPedido)throws IntegracionSICSAException{
        loggerDebug("insertPedidoSerie: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_INS_SERIE_PEDIDO_PR", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            loggerDebug("CodPedido: " + codPedido);
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
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
        loggerDebug("insertPedidoSerie: fin");
    }
	
	/**
     * Metodo que Obtiene bodega del Pedido
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public long obtieneBodegaPedido(String codPedido)throws IntegracionSICSAException{
        loggerDebug("obtieneBodegaPedido: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        long resultado = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_BODEGA_PEDIDO_PR", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            loggerDebug("codPedido: "+codPedido);
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }
            resultado = cstmt.getLong(2); 
            loggerDebug("codBodega: "+resultado);
            
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
        loggerDebug("obtieneBodegaPedido: fin");
        return resultado;
    }
	
	/**
     * Metodo que Obtiene numero de Folio
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public DatosFolioDTO obtieneNumFolio(long codBodega, String codOperadora)throws IntegracionSICSAException{
        loggerDebug("obtieneNumFolio: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        DatosFolioDTO resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_FOLIOS_PG", "AL_OBTFOLIO_GUIA_PR", 7);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, codBodega);
            loggerDebug("codBodega: " + codBodega);
            cstmt.setString(2, codOperadora);
            loggerDebug("codOperadora: "+codOperadora);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(7, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(5);
            msgError = cstmt.getString(6);
            numEvento = cstmt.getInt(7);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }
            resultado = new DatosFolioDTO();
            resultado.setConsume(cstmt.getInt(3));
            resultado.setNumFolio(cstmt.getString(4));            
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
        loggerDebug("obtieneBodegaPedido: fin");
        return resultado;
    }
	
	/**
     * Metodo que actualiza número de guia de la tabla NPT_PEDIDO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void updateNumGuia(String codPedido, String numGuia)throws IntegracionSICSAException{
        loggerDebug("updateNumGuia: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_UPD_PEDIDO_PR", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            loggerDebug("codPedido: " + codPedido);
            cstmt.setString(2, numGuia);
            loggerDebug("numGuia: " + numGuia);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
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
        loggerDebug("updateNumGuia: fin");
    }
	
	/**
     * Metodo que Obtiene las Series con Error de la Tabla NP_VALIDACION_SERIES_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public SerieErrorDTO[] obtieneSeriesErroneas(String codPedido)throws IntegracionSICSAException{
        loggerDebug("obtieneSeriesErroneas: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        SerieErrorDTO[] resultado = null;
        ResultSet rs = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_SERIES_ERRONEAS_PR", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.registerOutParameter(2, OracleTypes.CURSOR);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }else{
            	loggerDebug("Recuperando Datos Lineas");
            	ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
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
        loggerDebug("obtieneSeriesErroneas: fin");
        return resultado;
    }
	
	/**
     * Metodo que Elimina control de pedido de la tabla np_control_ing_series_to
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void borrarControlPedido(String codPedido, String estadoRegistro)throws IntegracionSICSAException{
        loggerDebug("borrarSeriePedido: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_UPD_CONTROL_REPROCESO_PR", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.setString(2, estadoRegistro);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
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
        loggerDebug("borrarControlPedido: fin");
    }
	
	/**
     * Metodo que obtiene descripcion del articulo
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public String obtieneDescrArtic(long codArticulo)throws IntegracionSICSAException{
        loggerDebug("obtieneDescrArtic: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        String resultado =  null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_DES_ARTICULO_PR", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, codArticulo);
            loggerDebug("codFuncion: "+codArticulo);
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            codError = cstmt.getInt(3);
            msgError = cstmt.getString(4);
            numEvento = cstmt.getInt(5);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionSICSAException(String.valueOf(codError),numEvento,msgError);
            }   
            
            resultado = cstmt.getString(2);
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
        loggerDebug("obtieneDescrArtic: fin");
        return resultado;
    }
	
	
	/**
     * Metodo que Obtiene descripcion del Estado del Pedido
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public SalidaConsultaPedidoDTO obtieneEstadoPedido(String codPedido)throws IntegracionSICSAException{
        loggerDebug("obtieneEstadoPedido: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        SalidaConsultaPedidoDTO resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_DES_ESTADO_PEDIDO_PR", 8);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            loggerDebug("codPedido: " + codPedido);
            cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, OracleTypes.CURSOR);
            cstmt.registerOutParameter(6, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(8, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            evaluaResultado(cstmt.getInt(6), cstmt.getString(7), cstmt
					.getInt(8));
            
            resultado = new SalidaConsultaPedidoDTO();
            resultado.setCodPedido(codPedido);
            resultado.setCodEstado(cstmt.getString(2));
            resultado.setDesEstado(cstmt.getString(3));
            resultado.setValidacionOk(cstmt.getString(4));
            ArrayList listaErr = new ArrayList();
            if("NO".equals(resultado.getValidacionOk())){
            	ResultSet rs = (ResultSet) cstmt.getObject(5);
            	while(rs.next()){
            		SerieErrorDTO serieErrorDTO = new SerieErrorDTO();
            		serieErrorDTO.setNumSerie(rs.getString(1));
            		serieErrorDTO.setDesErrorSerie(rs.getString(2));
            		listaErr.add(serieErrorDTO);
    			}
            }
            
            SerieErrorDTO[] errorDTOs = (SerieErrorDTO[]) copiaArregloTipoEspecifico(listaErr.toArray(), SerieErrorDTO.class);    
            resultado.setSeriesError(errorDTOs);
            
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
        loggerDebug("obtieneEstadoPedido: fin");
        return resultado;
    }
	
	
	/**
	 * Hugo Olivares
	 * @param codUsuario
	 * @param codPedido
	 * @param fecDesde
	 * @param fecHasta
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public ConsultaPedidoUsuarioDTO[] consultarPedidosUsuario(String codUsuario, String codPedido, String fecDesde, String fecHasta)throws IntegracionSICSAException{
        loggerDebug("consultarPedidosUsuario: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        ConsultaPedidoUsuarioDTO[] resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("al_integracion_sicsa_pg", "al_get_pedido_usuario_pr", 8);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setString(1, codUsuario);
            loggerDebug("codUsuario: " + codUsuario);
            
            cstmt.setString(2, codPedido);
            loggerDebug("codPedido: " + codPedido);
            
            cstmt.setString(3, fecDesde);
            loggerDebug("fecDesde: " + fecDesde);
            
            cstmt.setString(4, fecHasta);
            loggerDebug("fecHasta: " + fecHasta);  
            
            cstmt.registerOutParameter(5, OracleTypes.CURSOR);
            cstmt.registerOutParameter(6, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(8, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            evaluaResultado(cstmt.getInt(6), cstmt.getString(7), cstmt
					.getInt(8));
            
            	ResultSet rs = (ResultSet) cstmt.getObject(5);
            	ArrayList lista = new ArrayList();
            	ConsultaPedidoUsuarioDTO pedido = null;
            	
            	while(rs.next()){
            		pedido = new ConsultaPedidoUsuarioDTO();
            		pedido.setCodPedido(rs.getString(1));
            		loggerDebug("Pedido: "+pedido);
            		pedido.setEstadoPedido(rs.getString(2));
            		pedido.setFecPedido(rs.getString(3));
            		loggerDebug("pedido.getFecPedido(): "+pedido.getFecPedido());
            		lista.add(pedido);
    			}

        	resultado = (ConsultaPedidoUsuarioDTO[]) copiaArregloTipoEspecifico(lista.toArray(), ConsultaPedidoUsuarioDTO.class);
        	
        	loggerDebug("Largo pedidos: "+resultado.length);
            
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
        loggerDebug("consultarPedidosUsuario: fin");
        return resultado;
    }
	
	
	/**
	 * Hugo Olivares
	 * @param codPedido
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public HashMap consultarDetallePedidosUsuario(String codPedido, HashMap detalles)throws IntegracionSICSAException{
        loggerDebug("consultarDetallePedidosUsuario: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("al_integracion_sicsa_pg", "al_get_det_pedido_pr", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setString(1, codPedido);
            loggerDebug("codPedido: " + codPedido);
                        
            cstmt.registerOutParameter(2, OracleTypes.CURSOR);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt
					.getInt(5));
            
            	ResultSet rs = (ResultSet) cstmt.getObject(2);
            	
            	DetallePedidoDTO detallePedidoDTO = null;
            	ArrayList lista = new ArrayList();
            	while(rs.next()){
            		detallePedidoDTO = new DetallePedidoDTO();
            		detallePedidoDTO.setNroPedido(codPedido);
            		detallePedidoDTO.setLinPedido(rs.getString(1));
            		detallePedidoDTO.setDesStock(rs.getString(2));
            		detallePedidoDTO.setDesArticulo(rs.getString(3));
            		detallePedidoDTO.setDesTecnologia(rs.getString(4));
            		detallePedidoDTO.setCantidad(rs.getString(5));
            		detallePedidoDTO.setCantidadAsig(rs.getString(6));
            		detallePedidoDTO.setMtoUnitario(rs.getString(7));
            		detallePedidoDTO.setMtoDescuento(rs.getString(8));
            		detallePedidoDTO.setPorcDescuento(rs.getString(9));
            		detallePedidoDTO.setMtoNeto(rs.getString(10));
            		lista.add(detallePedidoDTO);
    			}            	
            	detalles.put(codPedido, lista);
            	
            	loggerDebug("Largo detalle pedidos: "+detalles.size());
            
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
        loggerDebug("consultarDetallePedidosUsuario: fin");
        return detalles;
    }
	
	
	/**
	 * Hugo Olivares
	 * @param codPedido
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public HashMap consultarSeriePedidosUsuario(String codPedido, String linProceso, HashMap series)throws IntegracionSICSAException{
        loggerDebug("consultarSeriePedidosUsuario: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("al_integracion_sicsa_pg", "al_get_ser_pedido_pr", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setString(1, codPedido);
            loggerDebug("codPedido: " + codPedido);
            
            cstmt.setString(2, linProceso);
            loggerDebug("linProceso: " + linProceso);
                        
            cstmt.registerOutParameter(3, OracleTypes.CURSOR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(6, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
            evaluaResultado(cstmt.getInt(4), cstmt.getString(5), cstmt
					.getInt(6));
            
            	ResultSet rs = (ResultSet) cstmt.getObject(3);
            	
            	ArrayList lista = null;
            	SerieDTO serieDTO = null;
            	while(rs.next()){
            		serieDTO = new SerieDTO();
            		serieDTO.setLinPedido(linProceso);
            		serieDTO.setNumSerie(rs.getString(1));
            		
            		if(series.containsKey(linProceso+codPedido)){
            			//loggerDebug("contiene linea :"+serieDTO.getLinPedido());
            			lista = (ArrayList) series.get(linProceso+codPedido);
            			lista.add(serieDTO);
            			series.put(linProceso+codPedido, lista);
            		}else{
            			//loggerDebug("NO contiene linea :"+serieDTO.getLinPedido());
            			lista = new ArrayList();
            			lista.add(serieDTO);
            			series.put(linProceso+codPedido,lista);
            		}
            	}
            	
            	loggerDebug("Largo series pedidos: "+series.size());
          
            
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
        loggerDebug("consultarSeriePedidosUsuario: fin");
        return series;
    }
	
	/**
     * Metodo que Elimina las series del pedido que existan en la tabla NP_VAL_SERIES_TEMP_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void borrarSeriePedidoTemp(String codPedido)throws IntegracionSICSAException{
        loggerDebug("borrarSeriePedidoTemp: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_ELIMINA_PEDIDO_TEMP_PR", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
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
        loggerDebug("borrarSeriePedidoTemp: fin");
    }
	
	/**
     * Metodo que Inserta las series con error del pedido en la tabla NP_VAL_SERIES_TEMP_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void InsertaSeriePedidoTemp(String codPedido)throws IntegracionSICSAException{
        loggerDebug("InsertaSeriePedidoTemp: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_NOTAPEDIDOWEB_PG", "AL_INSERTA_PEDIDO_TEMP_PR", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setLong(1, Long.parseLong(codPedido));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

            loggerDebug(" Iniciando Ejecución");
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");
            loggerDebug(" Finalizo ejecución");
            
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
        loggerDebug("InsertaSeriePedidoTemp: fin");
    }
	
	/**
	 * Metodo que limpia un pedido
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void limpiarPedido(String codPedido) throws IntegracionSICSAException {

		loggerDebug("limpiarPedido: inicio");

		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_limpia_pedido", 4);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			// PARAMETROS DE ENTRADA
			cstmt.setInt(1, Integer.parseInt(codPedido));
			loggerDebug("codPedido: " + codPedido);

			cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(2), cstmt.getString(3), cstmt
					.getInt(4));

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
		loggerDebug("limpiarPedido: fin");
	}
	
	
	
}
