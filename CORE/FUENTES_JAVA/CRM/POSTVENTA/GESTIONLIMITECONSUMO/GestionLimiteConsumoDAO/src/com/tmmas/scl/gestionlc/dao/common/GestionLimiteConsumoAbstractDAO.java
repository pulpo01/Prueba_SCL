/**
 * Copyright © 2009 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
   17-12-2010        Hugo Olivares          Versión Inicial 
 * 
 **/
package com.tmmas.scl.gestionlc.dao.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;
import com.tmmas.scl.gestionlc.common.helper.LoggerHelper;

public class GestionLimiteConsumoAbstractDAO {

    private final LoggerHelper logger = LoggerHelper.getInstance();
    private GlobalProperties global = GlobalProperties.getInstance();

    private Connection conn;

    public Connection obtenerConexion() throws GestionLimiteConsumoException {
        loggerDebug("obtenerConexion(): Inicio");
        loggerDebug("Jndi de conexión: " + global.getValorExterno("GE.jndi.dataSource.DAO"));
        try {
            conn = getConnectionFromWLSInitialContext(global.getValorExterno("GE.jndi.dataSource.DAO"));
        } catch (Exception e) {
            e.printStackTrace();
            loggerError(e);
            throw new GestionLimiteConsumoException("ERR.0000", 0);
        }
        loggerDebug("obtenerConexion(): Fin");
        return conn;
    }

    public void cerrarConexion(Connection pConn) throws SQLException {
        loggerDebug("Cerrando conexión.");
        pConn.close();
        loggerDebug("Conexión Cerrada.");
    }

    public Connection getConnectionFromWLSInitialContext(String jndiDataSource) throws Exception {

        Context ctx = null;
        ctx = new InitialContext();
        DataSource ds = null;
        ds = (DataSource) ctx.lookup(jndiDataSource);

        try {
            conn = ds.getConnection();
        } catch (SQLException e) {
            conn = null;
            loggerDebug("ERROR: Error obteniendo conexion");
            loggerError(e);
            throw e;
        }
        return conn;
    }

    public Connection conexionBD(String url, String usuario, String password) throws SQLException {
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        conn = DriverManager.getConnection(url, usuario, password);
        return conn;
    }

    public void loggerDebug(String mensaje) {
        logger.debug(mensaje, this.getClass().getName());
    }

    public void loggerInfo(String mensaje) {
        logger.info(mensaje, this.getClass().getName());
    }

    public void loggerError(String mensaje) {
        logger.error(mensaje, this.getClass().getName());
    }

    public void loggerError(Throwable e) {
        logger.error(e, this.getClass().getName());
    }

    public String getValorInterno(String propertie) {
        return global.getValor(propertie);
    }

    public String getValorExterno(String propertie) {
        return global.getValorExterno(propertie);
    }

    public String getSQL(String packageName, String procedureName, int paramCount) {
        StringBuffer sb = new StringBuffer("{call " + getValorInterno(packageName) + "." + getValorInterno(procedureName) + "(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) {
                sb.append(",");
            }
        }
        String buffer = sb.append(")}").toString();
        loggerDebug(buffer + "[" + paramCount + "]");
        return buffer;
    }

    public void evaluaResultado(int codError, String desError, int numEvento) throws GestionLimiteConsumoException {
        if (codError != 0) {
            loggerError("Error en Llamada a PL");
            loggerError("Cod. Error: " + codError);
            loggerError("Desc. Error:" + desError);
            loggerError("Evento: " + numEvento);
            loggerError("");
            throw new GestionLimiteConsumoException(Integer.toString(codError), numEvento, desError);
        }
    }

    public void evaluaResultado(int codError, String desError, int numEvento, String codErrorAplicacion) throws GestionLimiteConsumoException {
        if (codError != 0) {
            loggerError("Error en Llamada a PL");
            loggerError("Cod. Error: " + codError);
            loggerError("Desc. Error:" + desError);
            loggerError("Evento: " + numEvento);
            loggerError("Cod. Error Aplicación: " + codErrorAplicacion);
            loggerError("");
            throw new GestionLimiteConsumoException(codErrorAplicacion, numEvento, desError);
        }
    }

    public void imprimeDTO(GestionLimiteConsumoOutDTO outDTO) {
        logger.imprimeDTO(outDTO);
    }

    public void imprimirPropiedades(Object dto) {
        LoggerHelper.imprimirPropiedades(dto);
    }
}
