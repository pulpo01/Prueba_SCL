package com.tmmas.cl.scl.integracionexterna.dao;

import com.tmmas.cl.scl.integracionexterna.common.dto.SerieErrorDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.SerieTraspasoMasivoDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.TraspasoMasivoDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

public class TraspasoMasivoDAO extends IntegracionExternaDAO {	
	
	/**
     * Funcion que Obtiene el numero de secuencia del parametro ingresado
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */
	public String obtNumSecuencia(String nomSecuencia)throws IntegracionExternaException{
        loggerDebug("obtNumSecuencia: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        String resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_obtiene_numero_secuencia", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("nomSecuencia: "+nomSecuencia);
            cstmt.setString(1, nomSecuencia);
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
            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
            }              
            resultado = String.valueOf(cstmt.getInt(2));
            loggerDebug("Numero de Secuencia: "+resultado);            
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("obtNumSecuencia: fin");
        return resultado;
    }
	
	/**
     * Funcion que Obtiene los datos de las series ingresadas
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */
	public TraspasoMasivoDTO obtDatosSeries(TraspasoMasivoDTO masivoDTO)throws IntegracionExternaException{
        loggerDebug("obtDatosSeries: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_obtiene_datos_serie", 7);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            //Empiezo a Recorrer todas las series informadas
			for (int i = 0; i < masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO().length; i++) {
				loggerDebug("numSerie: "+ masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].getNumSerie());
	            cstmt.setString(1, masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].getNumSerie());
	            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
	            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
	            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
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
	            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
	            }
	            else{
	            	loggerDebug("numSerie: "+ masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].getNumSerie());
	            	if(masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].getTipStock() == null || masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].getTipStock().trim().equals("")
	            	   || masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].getCodEstado() == null || masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].getCodEstado().trim().equals("")
	            	   || masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].getCodUso() == null || masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].getCodUso().trim().equals("")){
	            		
	            		masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].setTipStock(String.valueOf(cstmt.getInt(2)));
	            		masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].setCodEstado(String.valueOf(cstmt.getInt(3)));
	            		masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].setCodUso(String.valueOf(cstmt.getInt(4)));
	            	}	
	            }
	        }	       
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("obtDatosSeries: fin");
        return masivoDTO;
    }
	
	/**
     * Metodo que registra las series del Traspaso Masivo
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */	
	public void registraTraspasoMasivo(TraspasoMasivoDTO masivoDTO, String nomUsuario) throws IntegracionExternaException, Exception{
		loggerDebug("registraTraspasoMasivo(): Inicio");		
		Connection conn = null;
		CallableStatement cstmt = null;		
		String insertFinal = "";
		StringBuffer call = new StringBuffer();		
		try{	
			call.append(" BEGIN ");
			//Empiezo a Recorrer todas las series informadas
			for (int i = 0; i < masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO().length; i++) {
				String numTraspasoMasivo = masivoDTO.getNumTraspasoMasivo();
				String numTraspaso = masivoDTO.getNumTraspaso();
				String codBodegaOri = masivoDTO.getMasivoInDTO().getCodBodegaOrigen();
				String codBodegaDes = masivoDTO.getMasivoInDTO().getCodBodegaDestino();
				SerieTraspasoMasivoDTO traspasoMasivoDTO = masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i]; 						
				call = generaInsert(call,numTraspasoMasivo,numTraspaso,codBodegaOri,codBodegaDes, nomUsuario,traspasoMasivoDTO);
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
			
		}catch (IntegracionExternaException e) {
			loggerDebug("IntegracionExternaException: " + e);
			throw e;
		}catch(Exception e){
			loggerDebug("Exception: " + e);
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
		loggerDebug("registraTraspasoMasivo(): Fin");
	}
	
	/**
	 * Genera Bloque Anonimo con los inserts 
	 * @author Jorge González
	 * */	
	private StringBuffer generaInsert(StringBuffer cadena, String numTraspasoMasivo, String numTraspaso, String codBodegaOri, 
									  String codBodegaDes, String nomUsuario, SerieTraspasoMasivoDTO traspasoMasivoDTO){

		cadena.append("INSERT INTO AL_TRASPASOS_MASIVO (NUM_TRASPASO_MASIVO,COD_ESTADO_TRAS,NUM_TRASPASO,COD_BODEGA_ORI,COD_BODEGA_DEST," +
			     	  "TIP_STOCK,TIP_STOCK_DEST,COD_ARTICULO,COD_USO,COD_ESTADO,NUM_SERIE,NUM_CANTIDAD, USU_TRASPASO_MASIVO,FEC_TRASPASO_MASIVO)"+ 
			     	  "VALUES ("+numTraspasoMasivo+",'PD',"+numTraspaso+","+codBodegaOri+","+codBodegaDes+","+traspasoMasivoDTO.getTipStock()+
			     	  ",4,"+traspasoMasivoDTO.getCodArticulo()+","+traspasoMasivoDTO.getCodUso()+","+traspasoMasivoDTO.getCodEstado()+
			     	  ",'"+traspasoMasivoDTO.getNumSerie()+"',1,'"+nomUsuario+"',SYSDATE);");
		return cadena;
	}
	
	/**
     * Metodo que ejecuta PLSQL de validacion de traspaso masivo
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void validaTraspasoMasivo(String nomTraspasoMasivo) throws IntegracionExternaException{
		loggerDebug("validaTraspasoMasivo: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASOCLS_PG", "P_VALIDA_MASIVO_PR", 1);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
			loggerDebug("numTraspasoMasivo: "+ nomTraspasoMasivo);
            cstmt.setLong(1, Long.parseLong(nomTraspasoMasivo));
            
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");        	       
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("validaTraspasoMasivo: fin");
	}
	
	/**
     * Metodo que consulta las series que se encuentran con error
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public boolean consultaSeriesError(String numTraspasoMasivo, String tipConsulta) throws IntegracionExternaException{
		loggerDebug("consultaSeriesError: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        boolean resultado = false;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_consulta_series_error", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
			loggerDebug("numTraspasoMasivo: "+ numTraspasoMasivo);
            cstmt.setLong(1, Long.parseLong(numTraspasoMasivo));
            loggerDebug("tipConsulta: "+ tipConsulta);
            cstmt.setString(2, tipConsulta);
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
            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
            }
            
            loggerDebug("Cantidad de Series con Error: "+ cstmt.getInt(3));
            if(cstmt.getInt(3) == 0){
            	loggerDebug("No existe error");
            	resultado = true;            	
            }
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("consultaSeriesError: fin");
        return resultado;
	}
	
	/**
     * Metodo que realiza tratamiento masivo del traspaso
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void tratamientoTraspasoMasivo(String numTraspasoMasivo, String obsTraspaso) throws IntegracionExternaException{
		loggerDebug("tratamientoTraspasoMasivo: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
        	conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_tratamiento_masivo", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
			loggerDebug("nomParametro: "+ numTraspasoMasivo);
            cstmt.setString(1, numTraspasoMasivo);
            loggerDebug("obsTraspaso: "+ obsTraspaso);
            cstmt.setString(2, obsTraspaso);
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
            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
            }
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("tratamientoTraspasoMasivo: fin");
	}
	
	/**
     * Metodo que realiza copia en la tabla AL_HTRASPASOS_MASIVO
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void traspasoHistoricoMasivo(String numTraspasoMasivo) throws IntegracionExternaException{
		loggerDebug("traspasoHistoricoMasivo: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
        	conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_hist_traspasos_mas", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
			loggerDebug("nomParametro: "+ numTraspasoMasivo);
            cstmt.setString(1, numTraspasoMasivo);
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
            
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");      

            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
            }
            
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("traspasoHistoricoMasivo: fin");
	}
	
	/**
     * Metodo que consulta parametros
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public String consultaParametros(String nomParametro, String codModulo, String codProducto) throws IntegracionExternaException{
		loggerDebug("consultaParametros: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        String resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_obtiene_parametro", 7);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
			loggerDebug("nomParametro: "+ nomParametro);
            cstmt.setString(1, nomParametro);
            loggerDebug("codModulo: "+ codModulo);
            cstmt.setString(2, codModulo);
            loggerDebug("codProducto: "+ codProducto);
            cstmt.setInt(3, Integer.parseInt(codProducto));
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
            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
            }
            
            resultado = cstmt.getString(4);
            
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("consultaParametros: fin");
        return resultado;
	}	
	
	/**
     * Metodo que registra traspaso masivo operador logisitico
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void insertaTraspasoOP(String numTraspaso, String numSecuencia, String codEstado) throws IntegracionExternaException{
		loggerDebug("insertaTraspasoOP: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_ingreso_traspaso_op_pr", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
			loggerDebug("numTraspaso: "+ numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            loggerDebug("numSecuencia: "+ numSecuencia);
            cstmt.setLong(2, Long.parseLong(numSecuencia));
            loggerDebug("codEstado: "+ codEstado);
            cstmt.setString(3, codEstado);
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
            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("insertaTraspasoOP: fin");
	}	
	
	/**
     * Metodo que actualiza estado traspaso masivo operador logisitico
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void actualizaTraspasoOP(String numTraspaso, String numSecuencia, String codEstado) throws IntegracionExternaException{
		loggerDebug("actualizaTraspasoOP: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_actualiza_traspaso_op_pr", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
			loggerDebug("numTraspaso: "+ numTraspaso);
            cstmt.setLong(1, Long.parseLong(numTraspaso));
            loggerDebug("numSecuencia: "+ numSecuencia);
            cstmt.setLong(2, Long.parseLong(numSecuencia));
            loggerDebug("codEstado: "+ codEstado);
            cstmt.setString(3, codEstado);
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
            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("actualizaTraspasoOP: fin");
	}	
	
	/**
     * Metodo que valida el numero de secuencia del operador logistico
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public boolean validaTraspOP(String numSecuencia) throws IntegracionExternaException{
		loggerDebug("validaTraspOP: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        boolean resultado = false;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_vali_traspaso_op", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numSecuencia: "+ numSecuencia);
            cstmt.setLong(1, Long.parseLong(numSecuencia));
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
            
            loggerDebug("Antes de Validar");
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
            }
            loggerDebug("despues de validar de Validar");
            if(cstmt.getLong(2) == 0){
            	resultado = true;
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("validaTraspOP: fin");
        return resultado;
	}
	
	/**
     * Metodo que consulta estado del traspaso masivo
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public SalidaConsultaTraspasoDTO consultaEstadoTraspOP(String numSecuencia) throws IntegracionExternaException{
		loggerDebug("consultaEstadoTraspOP: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        SalidaConsultaTraspasoDTO resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_consu_estad_tras_op", 8);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numSecuencia: "+ numSecuencia);
            cstmt.setInt(1, Integer.parseInt(numSecuencia));
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(5, OracleTypes.CURSOR);
            cstmt.registerOutParameter(6, java.sql.Types.INTEGER);
            cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
            cstmt.registerOutParameter(8, java.sql.Types.INTEGER);
            
            loggerDebug("Execute Antes");
            cstmt.execute();
            loggerDebug("Execute Despues");      
            
            codError = cstmt.getInt(6);
            msgError = cstmt.getString(7);
            numEvento = cstmt.getInt(8);
            
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
            }
            
            resultado = new SalidaConsultaTraspasoDTO();
            
            resultado.setNumTraspasoMasivo(String.valueOf(cstmt.getInt(2)));
            resultado.setEstadoTraspaso(cstmt.getString(3));
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
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("consultaEstadoTraspOP: fin");
        return resultado;
	}
	
	/**
     * Metodo que valida que la bodega sea del distribuidor
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public boolean validaBodegaDTS(String codCliente, String codBodega) throws IntegracionExternaException{
		loggerDebug("validaBodegaDTS: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        boolean resultado = false;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_valida_bodega_dts", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("codCliente: "+ codCliente);
            cstmt.setLong(1, Long.parseLong(codCliente));
            loggerDebug("codBodega: "+ codBodega);
            cstmt.setLong(2, Long.parseLong(codBodega));            
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
            
            loggerDebug("Antes de Validar");
            if(codError != 0){
            	loggerDebug("Codigo de Error: " + codError);
            	loggerDebug("Mensaje de Error: " + msgError);
            	loggerDebug("Numero de Evento: " +numEvento);            	
            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
            }            
            loggerDebug("despues de validar de Validar");
            
            if(cstmt.getLong(3) > 0){
            	resultado = true;
            }            
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("validaBodegaDTS: fin");
        return resultado;
	}
	
	/**
     * Metodo que obtiene lista de las series con error
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public SalidaConsultaTraspasoDTO obtieneSeriesErrorTM(SalidaConsultaTraspasoDTO traspasoDTO, String tipConsulta) throws IntegracionExternaException{
		loggerDebug("obtieneSeriesErrorTM: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        SalidaConsultaTraspasoDTO resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_obtiene_series_error", 6);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numTraspasoMasivo: "+ traspasoDTO.getNumTraspasoMasivo());
            cstmt.setLong(1, Long.parseLong(traspasoDTO.getNumTraspasoMasivo()));
            loggerDebug("tipConsulta: "+ tipConsulta);
            cstmt.setString(2, tipConsulta);
            cstmt.registerOutParameter(3, OracleTypes.CURSOR);
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
            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
            }
            
            ArrayList listaErr = new ArrayList();
        	ResultSet rs = (ResultSet) cstmt.getObject(3);
        	while(rs.next()){
        		SerieErrorDTO serieErrorDTO = new SerieErrorDTO();
        		serieErrorDTO.setNumSerie(rs.getString(1));
        		serieErrorDTO.setDesErrorSerie(rs.getString(2));
        		listaErr.add(serieErrorDTO);
			}
        	
        	resultado = new SalidaConsultaTraspasoDTO();
        	SerieErrorDTO[] errorDTOs = (SerieErrorDTO[]) copiaArregloTipoEspecifico(listaErr.toArray(), SerieErrorDTO.class);
        	resultado.setSeriesError(errorDTOs);
            
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("obtieneSeriesErrorTM: fin");
        return resultado;
	}
	
	/**
     * Metodo que elimina traspaso masivo
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void eliminaTraspasoMasivo(String nomTraspasoMasivo) throws IntegracionExternaException{
		loggerDebug("eliminaTraspasoMasivo: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_elimina_tras_mas", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
			loggerDebug("numTraspasoMasivo: "+ nomTraspasoMasivo);
            cstmt.setLong(1, Long.parseLong(nomTraspasoMasivo));
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
            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
            }
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("eliminaTraspasoMasivo: fin");
	}
	
	/**
     * Metodo que valida que la serie pertenesca a la bodega origen ingresada
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void validaSerieBodega(String nomTraspasoMasivo) throws IntegracionExternaException{
		loggerDebug("validaSerieBodega: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_valida_bode_tras", 4);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
			loggerDebug("numTraspasoMasivo: "+ nomTraspasoMasivo);
            cstmt.setLong(1, Long.parseLong(nomTraspasoMasivo));
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
            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
            }
        } catch (Exception e) {
            if (!(e instanceof IntegracionExternaException)) {
                loggerError("ERROR:");
                loggerError(e);
                loggerError("Codigo de Error[" + codError + "]");
                loggerError("Mensaje de Error[" + msgError + "]");
                loggerError("Numero de Evento[" + numEvento + "]");
                throw new IntegracionExternaException("ERR.0000", 0);
            } else {
                throw (IntegracionExternaException) e;
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
        loggerDebug("validaSerieBodega: fin");
	}
}
