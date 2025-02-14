package com.tmmas.cl.scl.integracionexterna.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import com.tmmas.cl.scl.integracionexterna.common.dto.SerieErrorDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.TraspasoMasivoDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;

public class MovimientoDAO extends IntegracionExternaDAO {
	
	/**
     * Funcion que inserta al_movimiento de las series informadas
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */
	public void insertaAlMovmiento(TraspasoMasivoDTO masivoDTO)throws IntegracionExternaException{
        loggerDebug("insertaAlMovmiento: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_ins_movimiento_descarga", 7);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            for (int i = 0; i < masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO().length; i++) {
				loggerDebug("numSerie: "+ masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].getNumSerie());
	            cstmt.setString(1, masivoDTO.getMasivoInDTO().getSerieTraspasoMasivoDTO()[i].getNumSerie());
	            loggerDebug("numSecuencia: "+ masivoDTO.getMasivoInDTO().getNumSecuencia());
	            cstmt.setLong(2,Long.parseLong(masivoDTO.getMasivoInDTO().getNumSecuencia()));
	            loggerDebug("codBodegaOrigen: "+ masivoDTO.getMasivoInDTO().getCodBodegaOrigen());
	            cstmt.setLong(3,Long.parseLong(masivoDTO.getMasivoInDTO().getCodBodegaOrigen()));
	            loggerDebug("codCliente: "+ masivoDTO.getMasivoInDTO().getCodCliente());
	            cstmt.setLong(4,Long.parseLong(masivoDTO.getMasivoInDTO().getCodCliente()));
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
        loggerDebug("insertaAlMovmiento: fin");
    }
	
	/**
     * Funcion que Obtiene el numero de secuencia del parametro ingresado
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */
	public SalidaConsultaTraspasoDTO obtSeriesErrorMov(String numSecuencia, String codModulo, String codProceso, String numLinea)throws IntegracionExternaException{
        loggerDebug("obtSeriesErrorMov: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        SalidaConsultaTraspasoDTO resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_series_error_dts", 8);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numSecuencia: "+numSecuencia);
            cstmt.setLong(1, Long.parseLong(numSecuencia));
            loggerDebug("codModulo: "+codModulo);
            cstmt.setString(2, codModulo);
            loggerDebug("codProceso: "+codProceso);
            cstmt.setString(3, codProceso);
            loggerDebug("numLinea: "+numLinea);
            cstmt.setLong(4, Long.parseLong(numLinea));
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
            
            SerieErrorDTO[] error = new SerieErrorDTO[0];
            resultado = new SalidaConsultaTraspasoDTO();
            resultado.setSeriesError(error);
            
            if(codError != 0){
            	if(codError == 1){
            		resultado.setNumTraspasoMasivo("");
                    resultado.setEstadoTraspaso("");
                    resultado.setValidacionOk("");
                    
                    ArrayList listaErr = new ArrayList();                    
                	ResultSet rs = (ResultSet) cstmt.getObject(5);
                	while(rs.next()){
                		SerieErrorDTO serieErrorDTO = new SerieErrorDTO();
                		serieErrorDTO.setNumSerie(rs.getString(1));
                		serieErrorDTO.setDesErrorSerie(rs.getString(2));
                		listaErr.add(serieErrorDTO);
        			}
                                        
                    SerieErrorDTO[] errorDTOs = (SerieErrorDTO[]) copiaArregloTipoEspecifico(listaErr.toArray(), SerieErrorDTO.class);    
                    resultado.setSeriesError(errorDTOs);	
            		
            	}else{
	            	loggerDebug("Codigo de Error: " + codError);
	            	loggerDebug("Mensaje de Error: " + msgError);
	            	loggerDebug("Numero de Evento: " +numEvento);            	
	            	throw new IntegracionExternaException(String.valueOf(codError),numEvento,msgError);
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
        loggerDebug("obtNumSecuencia: fin");
        return resultado;
    }
	
	/**
     * Funcion que elimina series con error de tabla temporal
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */
	public void eliminaTempoErrorMov(String numSecuencia, String codModulo, String codProceso, String numLinea)throws IntegracionExternaException{
        loggerDebug("eliminaTempoErrorMov: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        SalidaConsultaTraspasoDTO resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("AL_TRASPASO_MASIVO_WS_PG", "al_elimina_des_in_mas", 7);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            loggerDebug("numSecuencia: "+numSecuencia);
            cstmt.setLong(1, Long.parseLong(numSecuencia));
            loggerDebug("codModulo: "+codModulo);
            cstmt.setString(2, codModulo);
            loggerDebug("codProceso: "+codProceso);
            cstmt.setString(3, codProceso);
            loggerDebug("numLinea: "+numLinea);
            cstmt.setLong(4, Long.parseLong(numLinea));
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
        loggerDebug("eliminaTempoErrorMov: fin");
    }
}
