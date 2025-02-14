package com.tmmas.cl.scl.integracionexterna.common.helper;

import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.lang.reflect.Method;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;

/**
 * Copyright © 2009 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones,
 * SA. Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile Todos los
 * derechos reservados.
 * 
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci&oacute;n y s&oacute;lo debe usarla en
 * concordancia con los t&eacute;rminos de derechos de licencias que sean
 * adquiridos con TM-mAs.
 * 
 * Fecha ------------------- Autor ------------------------- Cambios ----------
 * 01-04-2009 - 17:59:25 H&eacute;ctor Hermosilla Versión Inicial
 * 
 * 
 * 
 * @author H&eacute;ctor Hermosilla
 * @version 1.0
 * 
 **/
public final class LoggerHelper {

    private static Logger logger3;
    private static LoggerHelper instance = new LoggerHelper();
    private GlobalProperties global = GlobalProperties.getInstance();

    /**
     * Constructor privado según indica el patron singleton. Para mas
     * informacion acerca del patron y recomendaciones visitar:
     * http://www.ibm.com/developerworks/java/library/j-dcl.html
     * 
     * @author Luis Bautista
     * @param Sin
     *            parametros de entrada
     * @return Es el constructor de la clase
     * @exception Exception
     */
    private LoggerHelper() {
        try {
            /*
             * Construyo ruta de archivo de propiedades para configuracion de
             * log4j
             */
            String rutPropsfile = global.getValor("GE.log.aplicacion.GE");
            rutPropsfile = System.getProperty("user.dir") + "/" + rutPropsfile;

            /*
             * Instancio util.Properties para rescatar datos de configuracion de
             * log4j desde la ruta que se construyó (ruta_props_file)
             */
            Properties props = new Properties();

            FileInputStream inputStream = new FileInputStream(new File(rutPropsfile));
            props.load(inputStream);
            PropertyConfigurator.configure(props);

            /*
             * Inicio configuracion log4j según procediimento standard
             */
            logger3 = Logger.getLogger(LoggerHelper.class);

            /*
             * PatternLayout layout = newPatternLayout(props.getProperty(
             * "log4j.appender.LOG1.layout.ConversionPattern"));
             * RollingFileAppender appender = new
             * RollingFileAppender(layout,props
             * .getProperty("log4j.appender.LOG1.File"),true);
             * 
             * logger3.addAppender(appender);
             * logger3.setLevel(Level.toLevel(props
             * .getProperty("log4j.appender.LOG1.threshold")));
             */
            // Si quisiera fijar el nivel dentro del codigo ---->
            // logger3.setLevel((Level) Level.ALL);
            inputStream.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Metodo getInstance da acceso publico a una única instancia de la clase
     * 
     * @author Luis Bautista
     * @param Sin
     *            parametros de entrada
     * @return com.tmmas.scl.wsfranquicias.common.helper.FranquiciasLoggerHelper
     * @exception ProyectoException
     */
    public static LoggerHelper getInstance() {
        return instance;
    }

    /**
     * Metodo que escribe en el archivo de log del aplicativo a partir de una
     * Excepcion provista desde la componente que invoca el método
     * 
     * @author Luis Bautista
     * @param Exception
     * @return void
     * @exception Exception
     */
    public void debug(Exception ex) {
        try {
            final Writer result = new StringWriter();
            final PrintWriter printWriter = new PrintWriter(result);
            ex.printStackTrace(printWriter);
            logger3.debug(result.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * Metodo que escribe en el archivo de log del aplicativo a partir de un
     * String provisto desde la componente que invoca el método
     * 
     * @author Luis Bautista
     * @param String
     * @return void
     * @exception Exception
     */
    public void debug(String logstr, String nombreClase) {
        try {
            logger3 = Logger.getLogger(nombreClase);
            logger3.debug(logstr);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * Metodo que escribe en el archivo de log del aplicativo a partir de una
     * Excepcion provista desde la componente que invoca el método
     * 
     * @author Luis Bautista
     * @param Exception
     * @return void
     * @exception Exception
     */
    public void info(Exception ex) {
        try {
            final Writer result = new StringWriter();
            final PrintWriter printWriter = new PrintWriter(result);
            ex.printStackTrace(printWriter);
            logger3.debug(result.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * Metodo que escribe en el archivo de log del aplicativo a partir de un
     * String provisto desde la componente que invoca el método
     * 
     * @author Luis Bautista
     * @param String
     * @return void
     * @exception Exception
     */
    public void info(String logstr, String nombreClase) {
        try {
            logger3 = Logger.getLogger(nombreClase);
            logger3.info(logstr);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * Metodo que escribe la pila de error en el archivo error del aplicativo.
     * 
     * @author Héctor Hermosilla
     * @param String
     * @return void
     * @exception Exception
     */
    public void error(Throwable e, String nombreClase) {
        try {
            logger3 = Logger.getLogger(nombreClase);
            logger3.error("Error: ", e);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }

    /**
     * Metodo que escribe en el archivo de log del aplicativo a partir de un
     * String provisto desde la componente que invoca el método
     * 
     * @author Luis Bautista
     * @param String
     * @return void
     * @exception Exception
     */
    public void error(String logstr, String nombreClase) {
        try {
            logger3 = Logger.getLogger(nombreClase);
            logger3.error(logstr);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * Imprime solo valores: cod error, desc. error y Evento para el Exception
     * SpnSclBException (heredado por todos los DTO)
     * 
     * @param spnDTO
     */
    public void imprimeError(IntegracionExternaException e) {
        logger3.error("");
        logger3.error("Cod. Error: " + e.getCodigo());
        logger3.error("Desc. Error:" + e.getDescripcionEvento());
        logger3.error("Evento: " + e.getCodigoEvento());
        logger3.error("");
    }

    /**
     * JIC Imprime todas las propiedades de un objeto.
     * 
     * @param Object
     */

    public static void imprimirPropiedades(Object obj) {
        logger3.debug("");
        logger3.debug("INICIO imprimirPropiedades");
        if (obj == null) {
            return;
        }

        Class clase = obj.getClass();
        int k = 0;
        try {
            PropertyDescriptor[] pd = Introspector.getBeanInfo(clase).getPropertyDescriptors();
            logger3.debug("atributos : [" + (pd.length - 1) + "]");
            for (int i = 0; i < pd.length; i++) {
                Method me = pd[i].getReadMethod();
                String valor = "";
                Object[] objeto = null;
                if (me.invoke(obj, objeto) != null) {
                    valor = me.invoke(obj, objeto).toString();
                    logger3.debug("		" + me.getName() + ": [" + valor + "]");
                } else {
                    logger3.debug("		" + me.getName() + ": [NULO]");
                    k++;
                }
            }
            logger3.debug("atributos nulos : [" + k + "]");
        } catch (Exception e) {
            logger3.debug(e.getMessage());
        }
        logger3.debug("FIN imprimirPropiedades");
        logger3.debug("");
    }

    public void inicioMetodo(String nombreClase) {
        Throwable t = new Throwable();
        StackTraceElement[] elements = t.getStackTrace();
        if (elements.length <= 0) {
            logger3.debug("Metodo Sin Información.");
        }
        // elements[0] is this method
        if (elements.length < 2) {
            logger3.debug("Metodo Sin Información.");
        }
        logger3.debug("inicio: " + elements[1].getMethodName());
    }

    public void finMetodo(String nombreClase) {
        Throwable t = new Throwable();
        StackTraceElement[] elements = t.getStackTrace();
        if (elements.length <= 0) {
            logger3.debug("Metodo Sin Información.");
        }
        // elements[0] is this method
        if (elements.length < 2) {
            logger3.debug("Metodo Sin Información.");
        }
        logger3.debug("fin: " + elements[1].getMethodName());
    }

}
