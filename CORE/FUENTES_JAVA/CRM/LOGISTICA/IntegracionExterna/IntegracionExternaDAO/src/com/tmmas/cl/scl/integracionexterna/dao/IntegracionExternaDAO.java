/**
 * Copyright � 2011 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 * 
 * 
 **/
package com.tmmas.cl.scl.integracionexterna.dao;

import java.lang.reflect.Array;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;
import com.tmmas.cl.scl.integracionexterna.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionexterna.common.helper.LoggerHelper;

public class IntegracionExternaDAO {

    private final LoggerHelper logger = LoggerHelper.getInstance();
    private GlobalProperties global = GlobalProperties.getInstance();

    private Connection conn;

    public Connection obtenerConexion() throws IntegracionExternaException {
        loggerDebug("obtenerConexion(): Inicio");
        loggerDebug("Jndi de conexi�n: " + global.getValorExterno("GE.jndi.dataSource.DAO"));
        try {
            conn = getConnectionFromWLSInitialContext(global.getValorExterno("GE.jndi.dataSource.DAO"));
        } catch (Exception e) {
            e.printStackTrace();
            throw new IntegracionExternaException("ERR.0000", 0);
        }
        loggerDebug("obtenerConexion(): Fin");
        return conn;
    }

    public void cerrarConexion(Connection pConn) throws SQLException {
        loggerDebug("Cerrando conexi�n.");
        pConn.close();
        loggerDebug("Conexi�n Cerrada.");
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
            logger.debug(e);
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

    public void loggerError(Exception e) {
        logger.error(e, e.getMessage());
    }

    public String getValorInterno(String propertie) {
        return global.getValor(propertie);
    }

    public String getValorExterno(String propertie) {
        return global.getValorExterno(propertie);
    }

    public String getSQL(String packageName, String procedureName, int paramCount) {
        StringBuffer sb = new StringBuffer("{call " + packageName + "." + procedureName + "(");
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
    
    public String getProcedure(String procedureName, int paramCount) {
        StringBuffer sb = new StringBuffer("{call " + procedureName + "(");
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

    public void evaluaResultado(int codError, String desError, int numEvento) throws IntegracionExternaException {
        if (codError != 0) {
            loggerError("Error en Llamada a PL");
            loggerError("Cod. Error: " + codError);
            loggerError("Desc. Error:" + desError);
            loggerError("Evento: " + numEvento);
            loggerError("");
            throw new IntegracionExternaException(Integer.toString(codError), numEvento, desError);
        }
    }

    public void evaluaResultado(int codError, String desError, int numEvento, String codErrorAplicacion) throws IntegracionExternaException {
        if (codError != 0) {
            loggerError("Error en Llamada a PL");
            loggerError("Cod. Error: " + codError);
            loggerError("Desc. Error:" + desError);
            loggerError("Evento: " + numEvento);
            loggerError("Cod. Error Aplicaci�n: " + codErrorAplicacion);
            loggerError("");
            throw new IntegracionExternaException(codErrorAplicacion, numEvento, desError);
        }
    }

    public void imprimeError(IntegracionExternaException e) {
        logger.imprimeError(e);
    }

    public void imprimirPropiedades(Object dto) {
        LoggerHelper.imprimirPropiedades(dto);
    }

    /**
     * Transforma de String a Date
     * 
     * @param String
     * @return Date
     * @throws SpnSclBException
     */
    public Date stringADate(String f) throws IntegracionExternaException {
        loggerDebug("inicio:stringADate()");
        loggerDebug("Dato Entrante: " + f);
        SimpleDateFormat formatoDelTexto = new SimpleDateFormat("dd-MM-yyyy");
        java.util.Date fecha;
        Date sqlFecha;
        try {
            loggerDebug("Antes De Parsear");
            fecha = formatoDelTexto.parse(f);
            loggerDebug("Despues De Parsear");
            sqlFecha = new Date(fecha.getTime());
        } catch (ParseException e) {
            loggerError(e);
            throw new IntegracionExternaException("ERR.0001", 0);
        }
        loggerDebug("fin:stringADate()");
        return sqlFecha;
    }
    
    public static Object copiaArregloTipoEspecifico(Object[] aOrig, Class type) {
		Object copy = Array.newInstance(type, aOrig.length);
		System.arraycopy(aOrig, 0, copy, 0, aOrig.length);
		return copy;
	}

}
