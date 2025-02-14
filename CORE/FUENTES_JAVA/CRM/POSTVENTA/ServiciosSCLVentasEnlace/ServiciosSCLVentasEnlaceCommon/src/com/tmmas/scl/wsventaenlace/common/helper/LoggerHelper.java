package com.tmmas.scl.wsventaenlace.common.helper;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;


public class LoggerHelper {
	
	private GlobalProperties global = GlobalProperties.getInstance();
	  private static Logger logger3 = null;
	  private static LoggerHelper instance = new LoggerHelper();
	  

	  private LoggerHelper()
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
			logger3 = Logger.getLogger(LoggerHelper.class);
			
			/*PatternLayout layout = new PatternLayout(props.getProperty("log4j.appender.LOG1.layout.ConversionPattern"));
			RollingFileAppender appender = new RollingFileAppender(layout,props.getProperty("log4j.appender.LOG1.File"),true);
			
	        logger3.addAppender(appender);
	        logger3.setLevel(Level.toLevel(props.getProperty("log4j.appender.LOG1.threshold")));*/
	        //Si quisiera fijar el nivel dentro del codigo ----> logger3.setLevel((Level) Level.ALL);
	        
		} catch(Exception e){  
		    System.out.println("ERROR creando instancia Singleton de LogHelper " + "\n" + e.toString());
	    }
	  }

	  public static synchronized LoggerHelper getInstance()
	  {
		 return instance;
	  }

	  
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
	  
	  public void debug(String logstr,String nombreClase ){
		  try{
			  logger3 =Logger.getLogger(nombreClase);
		      logger3.debug(logstr);
		  }catch(Exception e){
			  System.out.println("ERROR al ejecutar el método LoggerHelper.debug" + "\n" + e.toString());
		  }
		  
	  }
	  
	   	  
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

		  public void info(String logstr,String nombreClase){
			  try{
				  logger3 =Logger.getLogger(nombreClase);
			      logger3.info(logstr);
			  }catch(Exception e){
				  System.out.println("ERROR al ejecutar el método LoggerHelper.info" + "\n" + e.toString());
			  }
			  
		  }

		  public void error(Throwable e, String nombreClase){
			  try{
				  logger3 =Logger.getLogger(nombreClase);
			      logger3.error("Error: ",e);
			  }catch(Throwable e1){
				  System.out.println("ERROR al ejecutar el método LoggerHelper.error" + "\n" + e1.toString());
			  }
			  
		  }


			  public void error(String logstr,String nombreClase){
				  try{
					  logger3 =Logger.getLogger(nombreClase);
				      logger3.error(logstr);
				  }catch(Exception e){
					  System.out.println("ERROR al ejecutar el método LoggerHelper.error" + "\n" + e.toString());
				  }
				  
			  }
}
