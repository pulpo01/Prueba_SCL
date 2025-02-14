package com.tmmas.scl.serviciospostventasiga.common.helper;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

/**
 * Copyright © 2009 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci&oacute;n y s&oacute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 01-04-2009 - 17:59:25     H&eacute;ctor Hermosilla      		Versión Inicial 
 * 
 * 
 * 
 * @author H&eacute;ctor Hermosilla
 * @version 1.0
 * 

 **/
public class ServiciosPostVentaSigaLoggerHelper {
	
	private Global global = Global.getInstance();
	  private static Logger logger3 = null;
	  private static ServiciosPostVentaSigaLoggerHelper instance = new ServiciosPostVentaSigaLoggerHelper();
	  

	  
	/**
	 * Constructor privado según indica el patron singleton.  Para mas informacion acerca del patron y 
	 * recomendaciones visitar: http://www.ibm.com/developerworks/java/library/j-dcl.html
	 * @author Luis Bautista
	 * @param Sin parametros de entrada 
	 * @return Es el constructor de la clase
	 * @exception Exception
	 */
	  private ServiciosPostVentaSigaLoggerHelper()
	  {
		System.out.println("Singleton LogHelper inicio"); 
		try {
			/*
			 * Construyo ruta de archivo de propiedades para configuracion de log4j 
			 */
			String ruta_propsfile = global.getValor("GE.log.aplicacion.GE");
			ruta_propsfile = System.getProperty("user.dir") + "/" + ruta_propsfile;
			
			/* Instancio util.Properties para rescatar datos de configuracion de log4j
			 * desde la ruta que se construyó (ruta_props_file) 
			**/
			Properties props = new Properties();
			props.load(new FileInputStream(new File(ruta_propsfile)));
			PropertyConfigurator.configure(props);

			/*
			 * Inicio configuracion log4j según procediimento standard
			 */
			logger3 = Logger.getLogger(ServiciosPostVentaSigaLoggerHelper.class);
			
			/*PatternLayout layout = new PatternLayout(props.getProperty("log4j.appender.LOG1.layout.ConversionPattern"));
			RollingFileAppender appender = new RollingFileAppender(layout,props.getProperty("log4j.appender.LOG1.File"),true);
			
	        logger3.addAppender(appender);
	        logger3.setLevel(Level.toLevel(props.getProperty("log4j.appender.LOG1.threshold")));*/
	        //Si quisiera fijar el nivel dentro del codigo ----> logger3.setLevel((Level) Level.ALL);
	        
		} catch(Exception e){  
		    System.out.println("ERROR creando instancia Singleton de LogHelper " + "\n" + e.toString());
	    }
	  }

	/**
	 * Metodo getInstance da acceso publico a una única instancia de la clase
	 * @author Luis Bautista
	 * @param Sin parametros de entrada 
	 * @return com.tmmas.scl.wsfranquicias.common.helper.FranquiciasLoggerHelper
	 * @exception ProyectoException
	 */	  
	  public static ServiciosPostVentaSigaLoggerHelper getInstance()
	  {
		 return instance;
	  }

	/**
	 * Metodo que escribe en el archivo de log del aplicativo
	 * a partir de una Excepcion provista desde la componente que
	 * invoca el método
	 * @author Luis Bautista
	 * @param Exception 
	 * @return void
	 * @exception Exception
	 */	 	  
	  public void debug(Exception ex){
		  try{
		    final Writer result = new StringWriter();
		    final PrintWriter printWriter = new PrintWriter(result);
		    ex.printStackTrace(printWriter);
 	    logger3.debug(result.toString());
		  }catch(Exception e){
			  System.out.println("ERROR al ejecutar el método LoggerHelper.debug" + "\n" + e.toString());
		  }
		  
	  }
	  
	/**
	 * Metodo que escribe en el archivo de log del aplicativo
	 * a partir de un String provisto desde la componente que
	 * invoca el método
	 * @author Luis Bautista
	 * @param String 
	 * @return void
	 * @exception Exception
	 */	
	  public void debug(String logstr,String nombreClase ){
		  try{
			  logger3 =Logger.getLogger(nombreClase);
		      logger3.debug(logstr);
		  }catch(Exception e){
			  System.out.println("ERROR al ejecutar el método LoggerHelper.debug" + "\n" + e.toString());
		  }
		  
	  }
	  
	  
	  /**
		 * Metodo que escribe en el archivo de log del aplicativo
		 * a partir de una Excepcion provista desde la componente que
		 * invoca el método
		 * @author Luis Bautista
		 * @param Exception 
		 * @return void
		 * @exception Exception
		 */	 	  
		  public void info(Exception ex){
			  try{
			    final Writer result = new StringWriter();
			    final PrintWriter printWriter = new PrintWriter(result);
			    ex.printStackTrace(printWriter);
	   	    logger3.debug(result.toString());
			  }catch(Exception e){
				  System.out.println("ERROR al ejecutar el método LoggerHelper.info" + "\n" + e.toString());
			  }
			  
		  }
		  
		/**
		 * Metodo que escribe en el archivo de log del aplicativo
		 * a partir de un String provisto desde la componente que
		 * invoca el método
		 * @author Luis Bautista
		 * @param String 
		 * @return void
		 * @exception Exception
		 */	
		  public void info(String logstr,String nombreClase){
			  try{
				  logger3 =Logger.getLogger(nombreClase);
			      logger3.info(logstr);
			  }catch(Exception e){
				  System.out.println("ERROR al ejecutar el método LoggerHelper.info" + "\n" + e.toString());
			  }
			  
		  }

		  
		  /**
			 * Metodo que escribe la pila de error en el archivo error del aplicativo.
			 * @author Héctor Hermosilla
			 * @param String 
			 * @return void
			 * @exception Exception
			 */	
		  public void error(Throwable e, String nombreClase){
			  try{
				  logger3 =Logger.getLogger(nombreClase);
			      logger3.error("Error: ",e);
			  }catch(Throwable e1){
				  System.out.println("ERROR al ejecutar el método LoggerHelper.error" + "\n" + e1.toString());
			  }
			  
		  }

		  
		  /**
			 * Metodo que escribe en el archivo de log del aplicativo
			 * a partir de un String provisto desde la componente que
			 * invoca el método
			 * @author Luis Bautista
			 * @param String 
			 * @return void
			 * @exception Exception
			 */	
			  public void error(String logstr,String nombreClase){
				  try{
					  logger3 =Logger.getLogger(nombreClase);
				      logger3.error(logstr);
				  }catch(Exception e){
					  System.out.println("ERROR al ejecutar el método LoggerHelper.error" + "\n" + e.toString());
				  }
				  
			  }
}
