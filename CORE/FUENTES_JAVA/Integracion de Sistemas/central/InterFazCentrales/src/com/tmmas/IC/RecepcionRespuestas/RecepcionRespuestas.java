package com.tmmas.IC.RecepcionRespuestas;
import java.io.FileOutputStream;
import java.util.Vector;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.IC.Utils.ClassServerSocket;
import com.tmmas.IC.Utils.LecturaParametros;
import com.tmmas.SCH.Interfaz.JavaSched;


/**
 * Clase Principal para la Recpción de las notificaciones enviadas por el P+S u otra plataforma
 * @author Juan Ramos
 * @version $Revision$
 */
public class RecepcionRespuestas {
//--->>> Variables Globales de la Clase
/**
 * Field param
 */
	public static LecturaParametros param = new LecturaParametros();

/**
 * Field monitor 
 */
	public static Thread monitor;	

/**
 * Field tabProcesadores 
 */
	public static Vector tabProcesadores = new Vector();
	   
//--->>> Variables Privadas de la Clase
/**
 * Field numVersion
 */
	private static String numVersion = new String("v3.3"); // IMPORTANTE:-->> Registrar el cambio como una nueva versión
	/** Versión 1.0 Original**/
	/** Versión 2.0 contempla solución a Incidencia XO-0190**/
	/** Versión 3.2 contempla solución a problema hecho por el cambio en Incidencia XO-0190**/
	/** Versión 3.3 contempla solución a Incidencia XO-0348**/
/**
 * Field log
 */
	private static Logger log = Logger.getLogger(RecepcionRespuestas.class.getName());

/**
 * Field rutaConfig
 */
	private static String rutaConfig; 	
	
	public boolean evaluaError;
//------------------------------------------------------------------------------------------//
//  Metodo principal  MAIN                                               		    	    //	
//------------------------------------------------------------------------------------------//
 /**
 * Method main
 * @param args String[]
 * @throws Exception
 */
	
	public static void main(String[] args) 
    {
		int retorno;
		String plataforma = "";
		String nomShell   = "icrespuestas";
		
		try{
//--->>> Primero llama a la lectura de parámetros

		PropertyConfigurator.configureAndWatch("cfg/LogRespuestas.properties");
		if (args.length == 0) {
			log.fatal("Debe especificar la ruta completa del archivo de configuración");
			System.exit(-1);
		}
		rutaConfig = args[0];
		if (args.length >= 2) nomShell   = args[1]; 
		
		if ( (retorno = leeParametros()) != 0) System.exit(retorno);
		
		ClassServerSocket socket = new ClassServerSocket(); 
        try {
			log.info("+------------------------------------------------------------------------------------+");
			log.info(" Inicio Servicio de Recepción de Respuestas de Comandos");
			log.info(" Escuchando peticiones en el Puerto: " + param.numPuertoServidor);
			log.info(" N° de Versión: " + numVersion);
			log.info(" Plataforma de Trabajo: " + System.getProperties().getProperty("os.name") + " versión " + System.getProperties().getProperty("os.version"));
			log.info(" -------->>> Configuracion <<<----------");
			log.info("  Maximo Conexiones : " + param.numMaximoClientes);
			log.info("  Host Base Datos   : " + param.nomHostDB);
			log.info("  Puerto BD         : " + param.numPuertoDb);
			log.info("  Instancia         : " + param.instanciaDb);
			log.info("  Usuario           : " + param.usuarioDb  );
			log.info("  Tipo de Socket    : " + (param.tipoSocket == 0?"Normal":"SSL") );			
			log.info("  Refresco de Parametros, cada : " + param.tiempoRefrescaParam + " minutos");
			log.info("+------------------------------------------------------------------------------------+\n\n\n");

			plataforma = System.getProperties().getProperty("os.name").toLowerCase();
			if (plataforma.indexOf("indows") < 0) {
				JavaSched jSched = new JavaSched();
//--->>> Seteo Inicial de Señales 
//				jSched.LOG_PAUSE_PLAY = JavaSched.ACTIVA;
//				jSched.KILL_TERMINA   = JavaSched.DESACTIVA;
				log.info(" El PID del proceso es: " + jSched.getPid());
				log.info("El servidor se encuentra con una carga de: ");
				log.info("   * " + jSched.getHostMemCpu(JavaSched.SCH_RETORNA_CPU) + "% de promedio en CPU Utilizada");
				log.info("   * " + jSched.getHostMemCpu(JavaSched.SCH_RETORNA_MEMORIA) + "% de Memoria Utilizada");
				new RevisaTermino(socket,jSched).start(); //--->>> Manejo de Señales
				String archivoSalida = "tmp/" + nomShell + ".PID";
				try {
					FileOutputStream fSalida = new FileOutputStream(archivoSalida);
					fSalida.write(String.valueOf(jSched.getPid()).getBytes());
					fSalida.close();				
				} catch(Exception e) {
					log.error("No se pudo registrar el PID del proceso en archivo [" + archivoSalida + "]");
					log.error("StackTrace:",e);;
				}				
			}
			
//--->>> Crea tarea Monitor.
  			creaMonitor();
			
//--->>> Crea objetos para la atención del cliente
			boolean listener = true, corriendo = false; 
			socket.open(param.numPuertoServidor, param.nomKeyStore, param.tipoSocket);
			Thread receptor;
			ThreadGroup grupoReceptor = new ThreadGroup("GrupoReceptores");
			
			while (listener){ //(jSched.SENAL_STOP != jSched.ACTIVA) {
				receptor = new Receptor(grupoReceptor,socket.accept(),param,tabProcesadores);
				receptor.start();
			}
			

			if (!socket.close()) System.exit(1);
			System.exit(0);	  

	    	} catch (Exception e) {
				log.error("Error al iniciar servicio : --->>> [" + e.getMessage() + "] <<<---");
				log.error("Se cancela el proceso [-1]");
	            System.exit(-1);
	        }
		}catch(Exception e){
			log.fatal("Excepcion no atrapada en el main!!!");
			log.error("StackTrace:",e);;
		}
    }

/**
 * Crea la tarea de monitoreo de Porcesadores y Renotificaciones.
 * Method creaMonitor
 */
	public static void creaMonitor() {
		ThreadGroup grupoMonitor = new ThreadGroup("GrupoMonitores");
		monitor = new Monitor(grupoMonitor,param,tabProcesadores);
		monitor.setPriority(Thread.MAX_PRIORITY);
		monitor.start();		 
	}

/**
 * Metodo que lee los parámetros principales
 * Method leeParametros
 * @return int
 */
	public static int leeParametros() {
		try {
			int salida = 0;	
			salida = param.leer(rutaConfig);
			return(salida);
		} catch	 (Exception e) {
			log.error("Error en la lectura de parametros: --->>> [" + e.getMessage()+ e.getCause()  + "] <<<---");
			log.error("StackTrace:",e);
			return(1);
       	}
	}
	/**
	 * Metodo que evalua errores de excepciones
	 * Method evaluaError
	 * @return boolean
	 */
	
	public boolean  evaluaError(String mensaje) 
	{ 	
		if (mensaje!=null && mensaje!="" ){			
			if (mensaje.indexOf("Closed Connection") >= 0 )
			{			
				return (true);
			}
			else
			{
					if (mensaje.indexOf("ORA-02396") >= 0 )
					{					
						return (true);
					}				
					else
					{
						/*Para seguir agregando más errores se debe hacer desde aqui*/					
					}				
			}
		}	
		return(false);	
	}
}	


// ******************************************************************************************
// ** Información de Versionado *************************************************************
// ******************************************************************************************
// ** Pieza                                               : 
// **  %ARCHIVE%
// ** Identificador en PVCS                               : 
// **  %PID%
// ** Producto                                            : 
// **  %PP%
// ** Revisión                                            : 
// **  %PR%
// ** Autor de la Revisión                                :          
// **  %AUTHOR%
// ** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : 
// **  %PS%
// ** Fecha de Creación de la Revisión                    : 
// **  %DATE% 
// ** Worksets ******************************************************************************
// ** %PIRW%
// ** Historia ******************************************************************************
// ** %PL%
// ******************************************************************************************


