package com.tmmas.cl.scl.integracionsicsa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import oracle.jdbc.driver.OracleTypes;

import com.tmmas.cl.scl.integracionsicsa.common.dto.ConsultaDevolucionUsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.DetalleDevolucionDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.DetallePedidoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;

public class DevolucionDAO extends IntegracionSICSADAO {
	
	
	/**
	 * Hugo Olivares
	 * @param codUsuario
	 * @param codDevolucion
	 * @param fecDesde
	 * @param fecHasta
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public ConsultaDevolucionUsuarioDTO[] consultarDevolucionesUsuario(String codUsuario, String codDevolucion, String fecDesde, String fecHasta)throws IntegracionSICSAException{
        loggerDebug("consultarDevolucionesUsuario: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        ConsultaDevolucionUsuarioDTO[] resultado = null;
        try {
            conn = obtenerConexion();
            String call = getSQL("al_integracion_sicsa_pg", "al_get_devolu_usuario_pr", 8);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setString(1, codUsuario);
            loggerDebug("codUsuario: " + codUsuario);
            
            cstmt.setString(2, codDevolucion);
            loggerDebug("codDevolucion: " + codDevolucion);
            
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
            	ConsultaDevolucionUsuarioDTO devolucion = null;
            	
            	while(rs.next()){
            		devolucion = new ConsultaDevolucionUsuarioDTO();
            		devolucion.setCodDevolucion(rs.getString(1));
            		loggerDebug("evolucion: "+devolucion);
            		devolucion.setEstadoPedido(rs.getString(2));
            		devolucion.setFecDevolucion(rs.getString(3));
            		loggerDebug("devolucion.getFecDevolucion(): "+devolucion.getFecDevolucion());
            		lista.add(devolucion);
    			}

        	resultado = (ConsultaDevolucionUsuarioDTO[]) copiaArregloTipoEspecifico(lista.toArray(), ConsultaDevolucionUsuarioDTO.class);
        	
        	loggerDebug("Largo devoluciones: "+resultado.length);
            
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
        loggerDebug("consultarDevolucionesUsuario: fin");
        return resultado;
    }	
	
	/**
	 * Hugo Olivares
	 * @param codDevolucion
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public HashMap consultarDetalleDevolucionUsuario(String codDevolucion, HashMap detalles)throws IntegracionSICSAException{
        loggerDebug("consultarDetalleDevolucionUsuario: inicio");
        Connection conn = null;
        CallableStatement cstmt = null;
        int codError = 0;
        String msgError = null;
        int numEvento = 0;
        try {
            conn = obtenerConexion();
            String call = getSQL("al_integracion_sicsa_pg", "al_get_det_devolu_pr", 5);
            cstmt = conn.prepareCall(call);
            loggerDebug("SQL[" + call + "]");
            // PARAMETROS DE ENTRADA
            cstmt.setString(1, codDevolucion);
            loggerDebug("codDevolucion: " + codDevolucion);
                        
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
            	
            	DetalleDevolucionDTO detalleDevolucionDTO = null;
            	ArrayList lista = new ArrayList();
            	while(rs.next()){
            		detalleDevolucionDTO = new DetalleDevolucionDTO();
            		detalleDevolucionDTO.setCodDevolucion(codDevolucion);
            		detalleDevolucionDTO.setLinDevolucion(rs.getString(1));
            		detalleDevolucionDTO.setCodPedido(rs.getString(2));
            		detalleDevolucionDTO.setDesArticulo(rs.getString(3));
            		detalleDevolucionDTO.setSerie(rs.getString(4));
            		detalleDevolucionDTO.setTipoDevolucion(rs.getString(5));
            		lista.add(detalleDevolucionDTO);
    			}            	
            	detalles.put(codDevolucion, lista);
            	
            	loggerDebug("Largo detalle devoluciones: "+detalles.size());
            
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
        loggerDebug("consultarDetalleDevolucionUsuario: fin");
        return detalles;
    }
	
	
	
}
